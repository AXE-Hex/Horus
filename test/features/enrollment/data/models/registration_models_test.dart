import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';

void main() {
  test(
    'maps a course and normalized prerequisite row from the DB contract',
    () {
      final course = Course.fromJson({
        'id': 'course-1',
        'code': 'CS201',
        'name_en': 'Data Structures',
        'name_ar': 'هياكل البيانات',
        'description': 'Core data structures',
        'credit_hours': 4,
        'department_id': 'department-1',
        'is_active': true,
        'course_prerequisites': [
          {
            'minimum_grade': 60,
            'prerequisite_course': {
              'id': 'course-0',
              'code': 'CS101',
              'name_en': 'Programming I',
              'name_ar': 'برمجة ١',
            },
          },
        ],
      });

      expect(course.name, 'Data Structures');
      expect(course.credits, 4);
      expect(course.prerequisites, hasLength(1));
      expect(course.prerequisites.single.code, 'CS101');
      expect(course.prerequisites.single.minimumGrade, 60);
    },
  );
}
