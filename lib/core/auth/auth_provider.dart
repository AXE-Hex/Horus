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
      permissionCodes.contains(permission.code);
  bool get hasRole =>
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

/// IDs used by the local mock sign-in bypass — never hit Supabase for these.
const _kMockIds = {
  'mock-student-id',
  'mock-ta-id',
  'mock-professor-id',
  'mock-rector-id',
};
const _kMockEmails = {
  'student@horus.edu.eg',
  'ta@horus.edu.eg',
  'professor@horus.edu.eg',
};

const universityEmailDomain = 'horus.edu.eg';

String? normalizeUniversityEmail(String identifier) {
  var value = identifier.trim().toLowerCase();
  if (value.isEmpty) return null;

  if (!value.contains('@')) {
    value = '$value@$universityEmailDomain';
  }

  final parts = value.split('@');
  if (parts.length != 2 ||
      parts.first.isEmpty ||
      parts.last != universityEmailDomain ||
      !RegExp(r'^[a-z0-9._%+-]+

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  SupabaseClient get _client => Supabase.instance.client;
  RealtimeChannel? _profileChannel;
  StreamSubscription? _authSub;
  Future<void>? _profileLoadFuture;
  String? _profileLoadUserId;

  @override
  AuthState build() {
    ref.onDispose(() {
      _authSub?.cancel();
      _unsubscribeFromProfile();
    });

    final currentUser = _client.auth.currentUser;
    if (currentUser != null) {
      _loadProfile(currentUser);
    }

    _authSub = _client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      // Skip Supabase network calls for mock accounts
      if (kDebugMode &&
          session?.user != null &&
          _kMockIds.contains(session!.user.id)) {
        return;
      }

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        _loadProfile(session!.user);
      } else if (event == AuthChangeEvent.signedOut) {
        // Only clear state if we weren't on a mock account
        if (!kDebugMode || !_kMockIds.contains(state.user?.id)) {
          _unsubscribeFromProfile();
          state = const AuthState();
        }
      } else if (event == AuthChangeEvent.tokenRefreshed &&
          session?.user != null) {
        state = state.copyWith(user: session!.user);
      }
    });

    return const AuthState();
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final cleanEmail = normalizeUniversityEmail(email);
    if (cleanEmail == null) {
      state = state.copyWith(
        isLoading: false,
        error: 'Use your Horus University email (@$universityEmailDomain).',
      );
      return;
    }

    // ── Mock Sign-In Bypass for Development & Testing ─────────────────────────
    if (isMockSignInAllowed(kDebugMode, cleanEmail)) {
      await Future.delayed(
        const Duration(milliseconds: 600),
      ); // Simulate network lag

      final String mockId;
      final String fullName;
      final String? fullNameAr;
      final List<UserRole> roles;
      String? collegeId = 'CS';
      String? departmentId = 'CS-SE';

      if (cleanEmail == 'student@horus.edu.eg') {
        mockId = 'mock-student-id';
        fullName = 'Ahmed Ali';
        fullNameAr = 'أحمد علي';
        roles = [UserRole.regularStudent];
      } else if (cleanEmail == 'ta@horus.edu.eg') {
        mockId = 'mock-ta-id';
        fullName = 'Sarah Mohamed';
        fullNameAr = 'سارة محمد';
        roles = [UserRole.teachingAssistant];
      } else {
        mockId = 'mock-professor-id';
        fullName = 'Dr. Khaled Mahmoud';
        fullNameAr = 'د. خالد محمود';
        roles = [UserRole.professor];
      }

      final mockUser = User(
        id: mockId,
        email: cleanEmail,
        appMetadata: const {},
        userMetadata: const {},
        aud: 'authenticated',
        createdAt: DateTime.now().toIso8601String(),
      );

      final mockProfile = ProfileModel(
        id: mockId,
        email: cleanEmail,
        fullName: fullName,
        fullNameAr: fullNameAr,
        roles: roles,
        collegeId: collegeId,
        departmentId: departmentId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
        isVerified: true,
      );

      state = AuthState(
        user: mockUser,
        profile: mockProfile,
        isLoading: false,
        permissionCodes: roles
            .expand((role) => role.info.permissions)
            .map((permission) => permission.code)
            .toSet(),
      );
      return;
    }

    try {
      final response = await _client.auth.signInWithPassword(
        email: cleanEmail,
        password: password,
      );
      if (response.user != null) {
        await _loadProfile(response.user!);
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Self-service sign-up never establishes university authority.
  /// The database trigger assigns the canonical guest role only.
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName, 'requested_access': 'guest'},
      );
      if (response.user != null) {
        await _loadProfile(response.user!);
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    _unsubscribeFromProfile();
    // For mock accounts we only need to clear local state
    if (!kDebugMode || !_kMockIds.contains(state.user?.id)) {
      try {
        await _client.auth.signOut();
      } catch (_) {}
    }
    state = const AuthState();
  }

  Future<void> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _client.auth.resetPasswordForEmail(email);
      state = state.copyWith(isLoading: false);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    }
  }

  Future<void> _loadProfile(User user) {
    if (_profileLoadUserId == user.id && _profileLoadFuture != null) {
      return _profileLoadFuture!;
    }

    final future = _loadProfileInternal(user);
    _profileLoadUserId = user.id;
    _profileLoadFuture = future;
    future.whenComplete(() {
      if (identical(_profileLoadFuture, future)) {
        _profileLoadFuture = null;
        _profileLoadUserId = null;
      }
    });
    return future;
  }

  Future<void> _loadProfileInternal(User user) async {
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

      state = AuthState(
        user: user,
        profile: profile,
        isLoading: false,
        permissionCodes: permissionCodes,
      );

      _subscribeToAuthorizationChanges(user.id);
    } catch (e) {
      final isMissingProfile = e.toString().contains('PGRST116');

      state = AuthState(
        user: user,
        isLoading: false,
        error: isMissingProfile ? null : e.toString(),
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
).hasMatch(parts.first)) {
    return null;
  }
  return value;
}

bool isMockSignInAllowed(bool isDebugBuild, String email) =>
    isDebugBuild && _kMockEmails.contains(email.toLowerCase().trim());

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  SupabaseClient get _client => Supabase.instance.client;
  RealtimeChannel? _profileChannel;
  StreamSubscription? _authSub;

  @override
  AuthState build() {
    ref.onDispose(() {
      _authSub?.cancel();
      _unsubscribeFromProfile();
    });

    final currentUser = _client.auth.currentUser;
    if (currentUser != null) {
      _loadProfile(currentUser);
    }

    _authSub = _client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      // Skip Supabase network calls for mock accounts
      if (kDebugMode &&
          session?.user != null &&
          _kMockIds.contains(session!.user.id)) {
        return;
      }

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        _loadProfile(session!.user);
      } else if (event == AuthChangeEvent.signedOut) {
        // Only clear state if we weren't on a mock account
        if (!kDebugMode || !_kMockIds.contains(state.user?.id)) {
          _unsubscribeFromProfile();
          state = const AuthState();
        }
      } else if (event == AuthChangeEvent.tokenRefreshed &&
          session?.user != null) {
        state = state.copyWith(user: session!.user);
      }
    });

    return const AuthState();
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    // ── Mock Sign-In Bypass for Development & Testing ─────────────────────────
    final cleanEmail = email.toLowerCase().trim();
    if (isMockSignInAllowed(kDebugMode, cleanEmail)) {
      await Future.delayed(
        const Duration(milliseconds: 600),
      ); // Simulate network lag

      final String mockId;
      final String fullName;
      final String? fullNameAr;
      final List<UserRole> roles;
      String? collegeId = 'CS';
      String? departmentId = 'CS-SE';

      if (cleanEmail == 'student@horus.edu.eg') {
        mockId = 'mock-student-id';
        fullName = 'Ahmed Ali';
        fullNameAr = 'أحمد علي';
        roles = [UserRole.regularStudent];
      } else if (cleanEmail == 'ta@horus.edu.eg') {
        mockId = 'mock-ta-id';
        fullName = 'Sarah Mohamed';
        fullNameAr = 'سارة محمد';
        roles = [UserRole.teachingAssistant];
      } else {
        mockId = 'mock-professor-id';
        fullName = 'Dr. Khaled Mahmoud';
        fullNameAr = 'د. خالد محمود';
        roles = [UserRole.professor];
      }

      final mockUser = User(
        id: mockId,
        email: cleanEmail,
        appMetadata: const {},
        userMetadata: const {},
        aud: 'authenticated',
        createdAt: DateTime.now().toIso8601String(),
      );

      final mockProfile = ProfileModel(
        id: mockId,
        email: cleanEmail,
        fullName: fullName,
        fullNameAr: fullNameAr,
        roles: roles,
        collegeId: collegeId,
        departmentId: departmentId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
        isVerified: true,
      );

      state = AuthState(
        user: mockUser,
        profile: mockProfile,
        isLoading: false,
        permissionCodes: roles
            .expand((role) => role.info.permissions)
            .map((permission) => permission.code)
            .toSet(),
      );
      return;
    }

    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await _loadProfile(response.user!);
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// New profiles and the default role are created by the Auth database trigger.
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );
      if (response.user != null) {
        await _loadProfile(response.user!);
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    _unsubscribeFromProfile();
    // For mock accounts we only need to clear local state
    if (!kDebugMode || !_kMockIds.contains(state.user?.id)) {
      try {
        await _client.auth.signOut();
      } catch (_) {}
    }
    state = const AuthState();
  }

  Future<void> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _client.auth.resetPasswordForEmail(email);
      state = state.copyWith(isLoading: false);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    }
  }

  Future<void> _loadProfile(User user) async {
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

      state = AuthState(
        user: user,
        profile: profile,
        isLoading: false,
        permissionCodes: permissionCodes,
      );

      _subscribeToAuthorizationChanges(user.id);
    } catch (e) {
      final isMissingProfile = e.toString().contains('PGRST116');

      state = AuthState(
        user: user,
        isLoading: false,
        error: isMissingProfile ? null : e.toString(),
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
