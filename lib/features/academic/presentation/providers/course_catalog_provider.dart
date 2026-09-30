import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:horus/features/enrollment/data/repositories/enrollment_repository.dart';

class CourseCatalogState {
  const CourseCatalogState({
    required this.courses,
    required this.enrolledCourseIds,
  });

  final List<Course> courses;
  final Set<String> enrolledCourseIds;

  List<Course> get enrolledCourses => courses
      .where((course) => enrolledCourseIds.contains(course.id))
      .toList(growable: false);

  List<Course> get availableCourses => courses
      .where((course) => !enrolledCourseIds.contains(course.id))
      .toList(growable: false);
}

final courseCatalogProvider = FutureProvider.family<CourseCatalogState, String>(
  (ref, studentId) async {
    final coursesFuture = ref
        .read(academicRepositoryProvider)
        .getCourses(limit: 100);
    final enrollmentsFuture = ref
        .read(enrollmentRepositoryProvider)
        .getStudentEnrollments(studentId, limit: 100);
    final courses = await coursesFuture;
    final enrollments = await enrollmentsFuture;
    final enrolledIds = enrollments
        .where(
          (record) =>
              record.status == EnrollmentStatus.approved ||
              record.status == EnrollmentStatus.pending,
        )
        .map((record) => record.courseId)
        .toSet();
    return CourseCatalogState(courses: courses, enrolledCourseIds: enrolledIds);
  },
);
