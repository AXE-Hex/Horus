import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/models/profile_model.dart';

User testUser() => User(
  id: 'user-1',
  appMetadata: const {},
  userMetadata: const {},
  aud: 'authenticated',
  createdAt: '2026-01-01T00:00:00Z',
);

ProfileModel testProfile() => ProfileModel(
  id: 'user-1',
  email: 'fixture@example.invalid',
  fullName: 'Test Fixture',
  roles: [UserRole.student],
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
  isActive: true,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
    final auth = AuthState(
      user: testUser(),
      profile: testProfile(),
      permissionCodes: {'grades.read'},
    );

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
      final auth = AuthState(
        user: testUser(),
        permissionCodes: {'finance.read'},
      );
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

  test('university login accepts prefixes and full university email', () {
    expect(
      normalizeUniversityEmail(' Student.Dev '),
      'student.dev@horus.edu.eg',
    );
    expect(
      normalizeUniversityEmail(' Student.Dev@Horus.edu.eg '),
      'student.dev@horus.edu.eg',
    );
    expect(isUniversityEmail('student.dev'), isTrue);
    expect(isUniversityEmail('student.dev@horus.edu.eg'), isTrue);
    expect(isUniversityEmail('student@elsewhere.example'), isFalse);
    expect(isUniversityEmail('not an email'), isFalse);
  });
}
