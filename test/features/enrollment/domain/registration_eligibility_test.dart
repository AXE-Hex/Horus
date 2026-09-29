import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:horus/features/enrollment/domain/registration_eligibility.dart';

Course _course(String id, List<CoursePrerequisite> prerequisites) => Course(
  id: id,
  code: id.toUpperCase(),
  name: id,
  credits: 3,
  departmentId: 'department-1',
  prerequisites: prerequisites,
);

CoursePrerequisite _prerequisite(String code, double minimumGrade) =>
    CoursePrerequisite(
      courseId: 'prerequisite-$code',
      code: code,
      nameEn: code,
      minimumGrade: minimumGrade,
    );

void main() {
  test('requires every prerequisite and accepts the exact minimum grade', () {
    final courses = [
      _course('no-prerequisites', const []),
      _course('one-prerequisite', [_prerequisite('CS101', 60)]),
      _course('multiple-prerequisites', [
        _prerequisite('CS101', 60),
        _prerequisite('MATH101', 70),
      ]),
    ];

    expect(
      RegistrationEligibility.evaluatePrerequisites(
        courses: courses,
        completedGradesByCourseCode: {'CS101': 60, 'MATH101': 69.99},
      ),
      {
        'no-prerequisites': false,
        'one-prerequisite': false,
        'multiple-prerequisites': true,
      },
    );
  });

  test('missing prerequisite grades fail closed', () {
    final locked = RegistrationEligibility.evaluatePrerequisites(
      courses: [
        _course('advanced', [_prerequisite('CS101', 60)]),
      ],
      completedGradesByCourseCode: const {},
    );

    expect(locked['advanced'], isTrue);
  });
}
