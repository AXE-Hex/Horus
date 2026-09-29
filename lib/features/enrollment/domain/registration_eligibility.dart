import 'package:horus/features/enrollment/data/models/registration_models.dart';

/// Pure prerequisite decision used after the repository loads published grades.
/// A missing or insufficient grade keeps the course locked.
abstract final class RegistrationEligibility {
  static Map<String, bool> evaluatePrerequisites({
    required List<Course> courses,
    required Map<String, double> completedGradesByCourseCode,
  }) {
    return {
      for (final course in courses)
        course.id: course.prerequisites.any((prerequisite) {
          final grade = completedGradesByCourseCode[prerequisite.code];
          return grade == null || grade < prerequisite.minimumGrade;
        }),
    };
  }
}
