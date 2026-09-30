import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/router/route_guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;

AuthState _authenticatedState({
  List<UserRole> roles = const [UserRole.student],
  Set<String> permissions = const {},
  bool active = true,
}) {
  final user = User(
    id: 'user-1',
    email: 'student@example.test',
    appMetadata: const {},
    userMetadata: const {},
    aud: 'authenticated',
    createdAt: DateTime.utc(2026).toIso8601String(),
  );
  final profile = ProfileModel(
    id: user.id,
    email: user.email!,
    fullName: 'Student',
    roles: roles,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
    isActive: active,
  );
  return AuthState(user: user, profile: profile, permissionCodes: permissions);
}

void main() {
  test('allows a protected route only with its mapped permission', () {
    expect(
      canAccessRoute('/manage-tas', {'teaching_assistants.manage'}),
      isTrue,
    );
    expect(canAccessRoute('/manage-tas', {'profiles.read'}), isFalse);
    expect(canAccessRoute('/invoices', {'finance.read'}), isTrue);
  });

  test('denies routes with no explicit mapping', () {
    expect(canAccessRoute('/unknown-admin-panel', {'profiles.read'}), isFalse);
    expect(canAccessRoute('/professor-dashboard', const {}), isFalse);
  });

  test('keeps public route declarations explicit', () {
    expect(publicRoutes.contains('/forgot-password'), isTrue);
    expect(publicRoutes.contains('/welcome'), isFalse);
    expect(publicRoutes.contains('/guest-registration'), isTrue);
    expect(publicRoutes.contains('/manage-tas'), isFalse);
    expect(publicRoutes.contains('/ui-style-selection'), isFalse);
    expect(publicRoutes.contains('/language-selection'), isFalse);
    expect(publicRoutes.contains('/theme-selection'), isFalse);
  });

  test('redirects unauthenticated protected navigation to sign-in', () {
    expect(redirectForAuthState('/registration', const AuthState()), '/login');
    expect(redirectForAuthState('/forgot-password', const AuthState()), isNull);
  });

  test(
    'student permissions allow course registration and deny admin routes',
    () {
      final student = _authenticatedState(permissions: {'courses.enroll'});

      expect(redirectForAuthState('/registration', student), isNull);
      expect(redirectForAuthState('/manage-tas', student), '/access-pending');
    },
  );

  test('role and permission refresh protects subsequent transitions', () {
    final withPermission = _authenticatedState(
      roles: const [UserRole.professor],
      permissions: {'grades.manage'},
    );
    final revoked = withPermission.copyWith(permissionCodes: const {});
    final inactive = _authenticatedState(
      roles: const [UserRole.professor],
      permissions: {'grades.manage'},
      active: false,
    );

    expect(
      redirectForAuthState('/professor-dashboard', withPermission),
      isNull,
    );
    expect(
      redirectForAuthState('/professor-dashboard', revoked),
      '/access-pending',
    );
    expect(
      redirectForAuthState('/professor-dashboard', inactive),
      '/access-pending',
    );
  });

  test(
    'initial destination resolves from canonical permissions and fails closed',
    () {
      expect(resolveInitialDestination(const AuthState()), '/login');
      expect(
        resolveInitialDestination(
          _authenticatedState(
            roles: const [UserRole.professor],
            permissions: {'grades.manage'},
          ),
        ),
        '/professor-dashboard',
      );
      expect(
        resolveInitialDestination(
          _authenticatedState(
            roles: const [UserRole.dean],
            permissions: {'profiles.read', 'colleges.manage'},
          ),
        ),
        '/home',
      );
      expect(
        resolveInitialDestination(
          _authenticatedState(
            roles: const [UserRole.registrarOfficer],
            permissions: {'registration.manage'},
          ),
        ),
        '/registration',
      );
      expect(
        resolveInitialDestination(
          _authenticatedState(roles: const [UserRole.guest]),
        ),
        '/access-pending',
      );
      expect(
        resolveInitialDestination(
          _authenticatedState(
            roles: const [UserRole.professor],
            permissions: {'grades.manage'},
            active: false,
          ),
        ),
        '/access-pending',
      );
    },
  );
}
