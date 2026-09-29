import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/academic/data/repositories/professor_repository.dart';

GradeRecord _grade({
  required String id,
  required bool published,
  required double? points,
  required int? credits,
}) => GradeRecord(
  id: id,
  studentId: 'student-1',
  courseId: 'course-$id',
  semester: '2026-1',
  coursework: null,
  midterm: null,
  practical: null,
  finalExam: null,
  total: null,
  gradeLetter: null,
  gpaPoints: points,
  isPublished: published,
  publishedAt: null,
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
  course: credits == null ? null : GradeCourseSummary(creditHours: credits),
);

void main() {
  test(
    'academic summary calculates weighted GPA from published grades only',
    () {
      final summary = AcademicSummary.fromGrades([
        _grade(id: 'a', published: true, points: 4, credits: 3),
        _grade(id: 'b', published: true, points: 2, credits: 4),
        _grade(id: 'c', published: false, points: 0, credits: 3),
      ]);

      expect(summary.gpa, closeTo((4 * 3 + 2 * 4) / 7, 0.000001));
      expect(summary.completedCredits, 7);
      expect(summary.remainingCredits, 133);
    },
  );

  test(
    'empty transcript produces zero GPA and null credit relation uses default',
    () {
      expect(AcademicSummary.fromGrades(const []).gpa, 0);
      final summary = AcademicSummary.fromGrades([
        _grade(id: 'a', published: true, points: 3, credits: null),
        _grade(id: 'b', published: true, points: 0, credits: 5),
      ]);

      expect(summary.gpa, closeTo(9 / 8, 0.000001));
      expect(summary.completedCredits, 3);
    },
  );
}
