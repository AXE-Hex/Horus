import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/core/data/db_row.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:horus/features/enrollment/domain/registration_eligibility.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final registrationRepositoryProvider = Provider((ref) {
  return RegistrationRepository(ref.watch(supabaseClientProvider));
});

class RegistrationRepository {
  final SupabaseClient _supabase;

  RegistrationRepository(this._supabase);

  Future<List<Course>> fetchCoursesBySemester(String semester) async {
    final response = await _supabase
        .from('courses')
        .select('''
          *,
          course_prerequisites!course_prerequisites_course_id_fkey(
            minimum_grade,
            prerequisite_course:courses!course_prerequisites_prerequisite_course_id_fkey(
              id, code, name_en, name_ar
            )
          )
        ''')
        .eq('is_active', true);
    return (response as List)
        .map((json) => Course.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> fetchAvailableSections(String semester) async {
    final response = await _supabase
        .from('course_sections')
        .select('name')
        .eq('semester', semester);

    final names = (response as List)
        .map((e) => DbRow(e, context: 'course_sections').requiredString('name'))
        .toSet()
        .toList();
    names.sort();
    return names;
  }

  Future<List<ScheduleOption>> fetchSectionsByCourse(
    String courseId,
    String semester,
  ) async {
    final response = await _supabase
        .from('schedules')
        .select('*')
        .eq('course_id', courseId)
        .eq('semester', semester);

    return (response as List)
        .map((row) => ScheduleOption.fromJson(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<List<String>> fetchSubSections(
    String semester,
    String sectionName,
  ) async {
    final sectionsResp = await _supabase
        .from('course_sections')
        .select('id')
        .eq('semester', semester)
        .eq('name', sectionName);

    if ((sectionsResp as List).isEmpty) return [];

    final sectionIds = (sectionsResp as List)
        .map(
          (row) => DbRow(row, context: 'course_sections').requiredString('id'),
        )
        .toList();

    final subSectionsResp = await _supabase
        .from('course_sub_sections')
        .select('name')
        .inFilter('section_id', sectionIds);

    final names = (subSectionsResp as List)
        .map(
          (row) =>
              DbRow(row, context: 'course_sub_sections').requiredString('name'),
        )
        .toSet()
        .toList();
    names.sort();
    return names;
  }

  Future<StudentRegistration?> getStudentRegistration(
    String studentId,
    String semester,
  ) async {
    try {
      final response = await _supabase
          .from('student_registrations')
          .select('*')
          .eq('student_id', studentId)
          .eq('semester', semester)
          .maybeSingle();

      if (response == null) return null;
      return StudentRegistration.fromJson(response);
    } catch (e) {
      debugPrint('Error registering student: $e');
      return null;
    }
  }

  Future<List<CompletedCourseGrade>> getTranscript(String studentId) async {
    final response = await _supabase
        .from('grades')
        .select('total, courses(code)')
        .eq('student_id', studentId)
        .eq('is_published', true);
    return (response as List)
        .map(
          (row) =>
              CompletedCourseGrade.fromJson(Map<String, dynamic>.from(row)),
        )
        .toList();
  }

  Future<Map<String, bool>> checkPrerequisites(
    String studentId,
    List<Course> courses,
  ) async {
    final transcript = await getTranscript(studentId);
    final gradesByCourseCode = <String, double>{};
    for (final grade in transcript) {
      final code = grade.courseCode;
      final total = grade.total;
      if (code != null && total != null) {
        final previous = gradesByCourseCode[code];
        if (previous == null || total > previous) {
          gradesByCourseCode[code] = total;
        }
      }
    }

    return RegistrationEligibility.evaluatePrerequisites(
      courses: courses,
      completedGradesByCourseCode: gradesByCourseCode,
    );
  }

  Future<void> registerStudent(
    String studentId,
    String semester,
    String sectionName,
    String subSectionName,
  ) async {
    await _supabase.from('student_registrations').upsert({
      'student_id': studentId,
      'semester': semester,
      'section_name': sectionName,
      'sub_section_name': subSectionName,
      'registered_at': DateTime.now().toIso8601String(),
    }, onConflict: 'student_id, semester');
  }

  Future<void> registerCourseSections(
    String studentId,
    String semester,
    List<RegistrationCourseSelection> registrations,
  ) async {
    await _supabase
        .from('student_course_registrations')
        .delete()
        .eq('student_id', studentId)
        .eq('semester', semester);

    if (registrations.isEmpty) return;

    await _supabase
        .from('student_course_registrations')
        .insert(
          registrations
              .map(
                (registration) => {
                  'student_id': studentId,
                  'course_id': registration.courseId,
                  'semester': semester,
                  'section_name': registration.sectionName,
                  'sub_section_name': registration.subSectionName,
                  'registered_at': DateTime.now().toIso8601String(),
                },
              )
              .toList(),
        );
  }

  Future<List<StudentCourseRegistration>> getStudentCourseRegistrations(
    String studentId,
    String semester,
  ) async {
    final response = await _supabase
        .from('student_course_registrations')
        .select('*, courses(*)')
        .eq('student_id', studentId)
        .eq('semester', semester);

    return (response as List)
        .map((json) => StudentCourseRegistration.fromJson(json))
        .toList();
  }
}
