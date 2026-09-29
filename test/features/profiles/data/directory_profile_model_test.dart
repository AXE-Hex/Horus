import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/features/profiles/data/models/directory_profile_model.dart';

void main() {
  test('directory model exposes only the directory contract fields', () {
    final profile = DirectoryProfileModel.fromJson({
      'id': 'student-1',
      'full_name': 'Student',
      'full_name_ar': null,
      'avatar_url': null,
      'role_codes': ['student', 'new_unknown_role'],
      'college_id': 'college-1',
      'department_id': null,
      'created_at': '2026-01-02T03:04:05Z',
      // Private columns may occur in an overbroad response but never enter the
      // public directory model.
      'email': 'private@example.test',
      'national_id': 'private-id',
      'student_id': 'private-number',
    });

    expect(profile.roles, [UserRole.student]);
    expect(profile.fullNameAr, isNull);
    expect(profile.departmentId, isNull);
    expect(profile.toString(), isNot(contains('private-id')));
  });

  test('directory model rejects malformed required fields', () {
    expect(
      () => DirectoryProfileModel.fromJson({'id': 'student-1'}),
      throwsFormatException,
    );
  });
}
