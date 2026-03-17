import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/core/auth/roles.dart';
export 'package:hue/core/auth/roles.dart'
    show UserRole, RoleCategory, RolePermission, UserRoleX, RoleCategoryX;

part 'auth_provider.g.dart';

class AuthState {
  final User? user;
  final UserRole role;
  final String? fullName;
  final String? avatarUrl;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.role = UserRole.guest,
    this.fullName,
    this.avatarUrl,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null;
  bool get isStudent => role.isStudent;
  bool get isProfessor => role == UserRole.professor;
  bool get isAdmin => role.isAdmin;

  AuthState copyWith({
    User? user,
    UserRole? role,
    String? fullName,
    String? avatarUrl,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

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

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        _loadProfile(session!.user);
      } else if (event == AuthChangeEvent.signedOut) {
        _unsubscribeFromProfile();
        state = const AuthState();
      } else if (event == AuthChangeEvent.tokenRefreshed &&
          session?.user != null) {
        state = state.copyWith(user: session!.user);
      }
    });

    return const AuthState();
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
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

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? studentId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'student_id': studentId,
          'roles': ['student'],
        },
      );
      if (response.user != null) {
        await _client.from('profiles').upsert({
          'id': response.user!.id,
          'email': email,
          'full_name': fullName,
          'student_id': studentId,
          'roles': ['student'],
        });
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
    try {
      await _client.auth.signOut();
    } catch (_) {}
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
          .select()
          .eq('id', user.id)
          .single();

      List<UserRole> roles;
      if (data['roles'] != null) {
        roles = (data['roles'] as List)
            .map((r) => UserRoleX.fromDbString(r as String))
            .toList();
      } else {
        final roleStr = data['role'] as String? ?? 'student';
        roles = [UserRoleX.fromDbString(roleStr)];
      }

      final primaryRole = roles.isNotEmpty ? roles.first : UserRole.guest;

      state = AuthState(
        user: user,
        role: primaryRole,
        fullName: data['full_name'] as String?,
        avatarUrl: data['avatar_url'] as String?,
        isLoading: false,
      );

      // Start listening for real-time profile changes
      _subscribeToProfileChanges(user.id);
    } catch (e) {
      final isMissingProfile = e.toString().contains('PGRST116');

      state = AuthState(
        user: user,
        role: UserRole.student,
        isLoading: false,
        error: isMissingProfile ? null : e.toString(),
      );
    }
  }

  // ════════════════════════════════════════════════════════════════════════════
  //  REALTIME: Listen for profile changes (role, name, avatar, etc.)
  // ════════════════════════════════════════════════════════════════════════════

  void _subscribeToProfileChanges(String userId) {
    // Avoid duplicate subscriptions
    _unsubscribeFromProfile();

    _profileChannel = _client
        .channel('profile_changes_$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'profiles',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: userId,
          ),
          callback: (payload) {
            _handleProfileChange(payload.newRecord);
          },
        )
        .subscribe();
  }

  void _handleProfileChange(Map<String, dynamic> newData) {
    if (state.user == null) return;

    // Parse updated roles
    List<UserRole> roles;
    if (newData['roles'] != null) {
      roles = (newData['roles'] as List)
          .map((r) => UserRoleX.fromDbString(r.toString()))
          .toList();
    } else {
      final roleStr = newData['role'] as String? ?? 'student';
      roles = [UserRoleX.fromDbString(roleStr)];
    }

    final primaryRole = roles.isNotEmpty ? roles.first : UserRole.guest;

    // Update state — this triggers a rebuild of all listening widgets
    state = AuthState(
      user: state.user,
      role: primaryRole,
      fullName: newData['full_name'] as String? ?? state.fullName,
      avatarUrl: newData['avatar_url'] as String? ?? state.avatarUrl,
      isLoading: false,
    );
  }

  void _unsubscribeFromProfile() {
    if (_profileChannel != null) {
      _client.removeChannel(_profileChannel!);
      _profileChannel = null;
    }
  }
}
