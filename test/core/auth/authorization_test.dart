import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/models/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(url: 'http://localhost', anonKey: 'test-key');
  });

  group('canonical role parsing', () {
    test('maps all database roles, including assistant_hod', () {
      expect(UserRoleX.fromDbString('assistant_hod'), UserRole.assistantHod);
      expect(
        UserRoleX.fromDbString('academic_advisor'),
        UserRole.academicAdvisor,
      );
    });

    test('unknown roles do not silently become guest', () {
      expect(UserRoleX.tryFromDbString('root_admin'), isNull);
      expect(() => UserRoleX.fromDbString('root_admin'), throwsFormatException);
    });

    test('profile roles come from canonical role assignments', () {
      final profile = ProfileModel.fromJson(
        {
          'id': 'user-id',
          'email': 'user@example.test',
          'full_name': 'User',
          'roles': ['rector'],
          'created_at': '2026-01-01T00:00:00Z',
          'updated_at': '2026-01-01T00:00:00Z',
        },
        roleCodes: ['student', 'academic_advisor'],
      );

      expect(profile.roles, [UserRole.student, UserRole.academicAdvisor]);
    });
  });

  test('permission checks use canonical permission codes', () {
    const auth = AuthState(permissionCodes: {'grades.read'});

    expect(auth.hasPermission(RolePermission.viewGrades), isTrue);
    expect(auth.hasPermission(RolePermission.manageGrades), isFalse);
    expect(RolePermission.adviseStudents.code, 'students.advise');
  });

  test(
    'permission refresh replaces previous grants and inactive profiles deny',
    () {
      final active = ProfileModel(
        id: 'user-1',
        email: 'user@example.test',
        fullName: 'User',
        roles: [UserRole.student],
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        isActive: true,
      );
      const auth = AuthState(permissionCodes: {'finance.read'});
      final refreshed = auth.copyWith(
        profile: active,
        permissionCodes: {'courses.enroll'},
      );

      expect(refreshed.hasRole, isTrue);
      expect(refreshed.permissionCodes, {'courses.enroll'});
      expect(refreshed.hasPermission(RolePermission.viewFinance), isFalse);
      expect(
        refreshed
            .copyWith(
              profile: ProfileModel(
                id: 'inactive',
                email: 'inactive@example.test',
                fullName: 'Inactive',
                roles: [UserRole.student],
                createdAt: DateTime.utc(2026),
                updatedAt: DateTime.utc(2026),
                isActive: false,
              ),
            )
            .hasRole,
        isFalse,
      );
    },
  );

  test('mock sign-in is unavailable in production builds', () {
    expect(isMockSignInAllowed(false, 'student@horus.edu.eg'), isFalse);
    expect(isMockSignInAllowed(true, ' student@horus.edu.eg '), isTrue);
    expect(isMockSignInAllowed(true, 'unknown@horus.edu.eg'), isFalse);
  });

  test(
    'debug mock sign-in creates a scoped student session without network',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .signIn(' student@horus.edu.eg ', 'ignored-in-development');

      final auth = container.read(authControllerProvider);
      expect(auth.isAuthenticated, isTrue);
      expect(auth.role, UserRole.regularStudent);
      expect(auth.hasPermission(RolePermission.enrollCourses), isTrue);
      expect(auth.hasRole, isTrue);
    },
  );
}
