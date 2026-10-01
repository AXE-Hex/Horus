import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/auth/rbac_records.dart';
import 'package:horus/core/models/profile_model.dart';
export 'package:horus/core/auth/roles.dart'
    show UserRole, RoleCategory, RolePermission, UserRoleX, RoleCategoryX;

part 'auth_provider.g.dart';

class AuthState {
  final User? user;
  final ProfileModel? profile;
  final bool isLoading;
  final String? error;
  final Set<String> permissionCodes;

  const AuthState({
    this.user,
    this.profile,
    this.isLoading = false,
    this.error,
    this.permissionCodes = const {},
  });

  bool get isAuthenticated => user != null;
  UserRole get role => profile?.primaryRole ?? UserRole.guest;
  bool get isStudent => role.isStudent;
  bool get isProfessor => role == UserRole.professor;
  bool hasPermission(RolePermission permission) =>
      hasRole && permissionCodes.contains(permission.code);
  bool get hasRole =>
      isAuthenticated &&
      user!.id == profile?.id &&
      (profile?.roles.isNotEmpty ?? false) &&
      (profile?.isActive ?? false) &&
      !(profile?.isBanned ?? true);

  AuthState copyWith({
    User? user,
    ProfileModel? profile,
    bool? isLoading,
    String? error,
    Set<String>? permissionCodes,
  }) {
    return AuthState(
      user: user ?? this.user,
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      permissionCodes: permissionCodes ?? this.permissionCodes,
    );
  }
}

String normalizeUniversityEmail(String value) {
  final input = value.trim().toLowerCase();
  if (input.contains('@')) return input;
  return '$input@horus.edu.eg';
}

bool isUniversityEmail(String value) {
  final email = normalizeUniversityEmail(value);

  final isOfficialUniversityEmail =
      RegExp(r'^[a-z0-9._%+-]+@horus\.edu\.eg$').hasMatch(email);

  if (isOfficialUniversityEmail) {
    return true;
  }

  // Development/test accounts only.
  if (kDebugMode) {
    return RegExp(r'^[a-z0-9._%+-]+@horus\.local$').hasMatch(email);
  }

  return false;
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  SupabaseClient get _client => Supabase.instance.client;
  RealtimeChannel? _profileChannel;
  StreamSubscription? _authSub;
  Timer? _roleExpiryTimer;
  int _loadGeneration = 0;

  @override
  AuthState build() {
    ref.onDispose(() {
      _authSub?.cancel();
      _roleExpiryTimer?.cancel();
      _loadGeneration++;
      _unsubscribeFromProfile();
    });

    final currentUser = _client.auth.currentUser;
    if (currentUser != null) {
      _loadProfile(currentUser);
    }

    _authSub = _client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if ((event == AuthChangeEvent.signedIn ||
              event == AuthChangeEvent.initialSession) &&
          session?.user != null) {
        _loadProfile(session!.user);
      } else if (event == AuthChangeEvent.signedOut) {
        _loadGeneration++;
        _roleExpiryTimer?.cancel();
        _unsubscribeFromProfile();
        state = const AuthState();
      } else if (event == AuthChangeEvent.tokenRefreshed &&
          session?.user != null) {
        state = state.copyWith(user: session!.user);
      }
    });

    return AuthState(user: currentUser, isLoading: currentUser != null);
  }

  Future<void> signIn(String email, String password) async {
    if (!isUniversityEmail(email)) {
      state = const AuthState(error: 'invalid_university_email');
      return;
    }
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _client.auth.signInWithPassword(
        email: normalizeUniversityEmail(email),
        password: password,
      );
      if (response.user != null && response.session != null) {
        await _loadProfile(response.user!);
      }
    } on AuthException catch (_) {
      state = state.copyWith(isLoading: false, error: 'sign_in_failed');
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'sign_in_failed');
    }
  }

  /// New profiles and the default role are created by the Auth database trigger.
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final normalizedEmail = normalizeUniversityEmail(email);
    if (!isUniversityEmail(normalizedEmail)) {
      state = state.copyWith(
        isLoading: false,
        error: 'invalid_university_email',
      );
      return;
    }
    try {
      final response = await _client.auth.signUp(
        email: normalizedEmail,
        password: password,
        data: {'full_name': fullName},
      );
      if (response.user != null && response.session != null) {
        await _loadProfile(response.user!);
      } else {
        state = const AuthState(error: 'confirmation_required');
      }
    } on AuthException catch (_) {
      state = state.copyWith(isLoading: false, error: 'sign_up_failed');
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'sign_up_failed');
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (_) {
      state = state.copyWith(isLoading: false, error: 'sign_out_failed');
      return;
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'sign_out_failed');
      return;
    }
    _unsubscribeFromProfile();
    state = const AuthState();
  }

  Future<void> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      if (!isUniversityEmail(email)) {
        state = state.copyWith(
          isLoading: false,
          error: 'invalid_university_email',
        );
        return;
      }
      await _client.auth.resetPasswordForEmail(normalizeUniversityEmail(email));
      state = state.copyWith(isLoading: false);
    } on AuthException catch (_) {
      state = state.copyWith(isLoading: false, error: 'password_reset_failed');
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'password_reset_failed');
    }
  }

  Future<void> _loadProfile(User user) async {
    final generation = ++_loadGeneration;
    try {
      final data = await _client
          .from('profiles')
          .select(
            'id, full_name, full_name_ar, avatar_url, college_id, department_id, created_at, updated_at',
          )
          .eq('id', user.id)
          .single();
      final privateRows = await _client.rpc('get_my_profile_private');
      final profileData = {
        ...data,
        ...((privateRows as List).single as Map<String, dynamic>),
      };

      final roleRows = await _client
          .from('user_roles')
          .select(
            'role_id, expires_at, role_definitions!inner(id, code, priority)',
          )
          .eq('user_id', user.id)
          .lte('granted_at', DateTime.now().toUtc().toIso8601String())
          .eq('role_definitions.is_active', true)
          .or(
            'expires_at.is.null,expires_at.gt.${DateTime.now().toUtc().toIso8601String()}',
          );
      final assignments =
          roleRows.map((row) => UserRoleAssignmentRecord.fromJson(row)).toList()
            ..sort((left, right) {
              final priorityComparison = left.role.priority.compareTo(
                right.role.priority,
              );
              return priorityComparison != 0
                  ? priorityComparison
                  : left.role.code.compareTo(right.role.code);
            });
      final roleCodes = assignments.map((row) => row.role.code).toList();
      final roleIds = assignments.map((row) => row.roleId).toList();
      final permissionRows = roleIds.isEmpty
          ? <dynamic>[]
          : await _client
                .from('role_permissions')
                .select('role_id, permissions!inner(id, code)')
                .inFilter('role_id', roleIds);
      final permissionCodes = permissionRows
          .map((row) => RolePermissionAssignmentRecord.fromJson(row))
          .map((row) => row.permission.code)
          .toSet();

      final profile = ProfileModel.fromJson(profileData, roleCodes: roleCodes);
      if (generation != _loadGeneration ||
          _client.auth.currentUser?.id != user.id) {
        return;
      }

      state = AuthState(
        user: user,
        profile: profile,
        isLoading: false,
        permissionCodes: profile.isActive && !profile.isBanned
            ? permissionCodes
            : const {},
      );

      _roleExpiryTimer?.cancel();
      final expirations =
          assignments.map((row) => row.expiresAt).whereType<DateTime>().toList()
            ..sort();
      if (expirations.isNotEmpty) {
        final remaining = expirations.first.difference(DateTime.now().toUtc());
        _roleExpiryTimer = Timer(
          remaining.isNegative ? Duration.zero : remaining,
          () {
            state = AuthState(user: user, isLoading: true);
            _loadProfile(user);
          },
        );
      }

      _subscribeToAuthorizationChanges(user.id);
    } catch (e) {
      if (generation != _loadGeneration) return;
      final isMissingProfile = e.toString().contains('PGRST116');

      state = AuthState(
        user: user,
        isLoading: false,
        error: isMissingProfile ? null : 'profile_load_failed',
      );
    }
  }

  void _subscribeToAuthorizationChanges(String userId) {
    _unsubscribeFromProfile();

    _profileChannel = _client
        .channel('authorization_changes_$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'profiles',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: userId,
          ),
          callback: (_) => _refreshAuthorization(),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'user_roles',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (_) => _refreshAuthorization(),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'role_permissions',
          callback: (_) => _refreshAuthorization(),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'role_definitions',
          callback: (_) => _refreshAuthorization(),
        )
        .subscribe();
  }

  void _refreshAuthorization() {
    final user = state.user;
    if (user != null) _loadProfile(user);
  }

  void _unsubscribeFromProfile() {
    if (_profileChannel != null) {
      _client.removeChannel(_profileChannel!);
      _profileChannel = null;
    }
  }
}
