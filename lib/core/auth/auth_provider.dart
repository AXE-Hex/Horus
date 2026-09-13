import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/models/profile_model.dart';
export 'package:horus/core/auth/roles.dart'
    show UserRole, RoleCategory, RolePermission, UserRoleX, RoleCategoryX;

part 'auth_provider.g.dart';

class AuthState {
  final User? user;
  final ProfileModel? profile;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.profile,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null;
  UserRole get role => profile?.primaryRole ?? UserRole.guest;
  bool get isStudent => role.isStudent;
  bool get isProfessor => role == UserRole.professor;

  AuthState copyWith({
    User? user,
    ProfileModel? profile,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// IDs used by the local mock sign-in bypass — never hit Supabase for these.
const _kMockIds = {'mock-student-id', 'mock-ta-id', 'mock-professor-id', 'mock-rector-id'};

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
      if (session?.user != null && _kMockIds.contains(session!.user.id)) return;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        _loadProfile(session!.user);
      } else if (event == AuthChangeEvent.signedOut) {
        // Only clear state if we weren't on a mock account
        if (!_kMockIds.contains(state.user?.id)) {
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
    if (cleanEmail == 'student@horus.edu.eg' ||
        cleanEmail == 'ta@horus.edu.eg' ||
        cleanEmail == 'professor@horus.edu.eg') {
      
      await Future.delayed(const Duration(milliseconds: 600)); // Simulate network lag
      
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
    // For mock accounts we only need to clear local state
    if (!_kMockIds.contains(state.user?.id)) {
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
          .select()
          .eq('id', user.id)
          .single();

      final profile = ProfileModel.fromJson(data);

      state = AuthState(
        user: user,
        profile: profile,
        isLoading: false,
      );

      _subscribeToProfileChanges(user.id);
    } catch (e) {
      final isMissingProfile = e.toString().contains('PGRST116');

      state = AuthState(
        user: user,
        isLoading: false,
        error: isMissingProfile ? null : e.toString(),
      );
    }
  }

  void _subscribeToProfileChanges(String userId) {
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

    final profile = ProfileModel.fromJson(newData);

    state = AuthState(
      user: state.user,
      profile: profile,
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
