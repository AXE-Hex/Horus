import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/core/data/base_repository.dart';
import 'package:horus/core/data/db_row.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:horus/features/institutional/data/models/institutional_models.dart';

final academicRepositoryProvider = Provider<AcademicRepository>((ref) {
  return AcademicRepository(ref.watch(supabaseClientProvider));
});

class AcademicRepository extends BaseRepository {
  AcademicRepository(super.client);

  Future<String?> getCurrentSemesterName() async {
    final row = await client
        .from('semesters')
        .select('name_en')
        .eq('is_current', true)
        .eq('is_active', true)
        .maybeSingle();
    return row == null
        ? null
        : DbRow(row, context: 'semesters').optionalString('name_en');
  }

  Future<List<Course>> getCourses({String? semester}) async {
    final rows = semester == null
        ? await client.from('courses').select('*').order('code')
        : await client
              .from('courses')
              .select('*')
              .eq('semester', semester)
              .order('code');
    return rows.map((row) => Course.fromJson(row)).toList();
  }

  Future<Course> getCourse(String courseId) async {
    final row = await client
        .from('courses')
        .select()
        .eq('id', courseId)
        .single();
    return Course.fromJson(row);
  }

  Future<List<Course>> getCoursesByProfessor(String professorId) async {
    final rows = await client
        .from('courses')
        .select()
        .eq('professor_id', professorId)
        .order('code');
    return rows.map((row) => Course.fromJson(row)).toList();
  }

  Future<List<GradeRecord>> getStudentGrades(
    String studentId, {
    String? semester,
  }) async {
    var query = client
        .from('grades')
        .select('*, courses(credit_hours)')
        .eq('student_id', studentId);
    if (semester != null) {
      query = query.eq('semester', semester).eq('is_published', true);
    }
    final result = await query;
    return result.map((row) => GradeRecord.fromJson(row)).toList();
  }

  Future<GradeRecord> submitGrade(GradeSubmission submission) async {
    final row = await client
        .from('grades')
        .upsert(
          submission.toDatabase(),
          onConflict: 'student_id,course_id,semester',
        )
        .select('*, courses(credit_hours)')
        .single();
    return GradeRecord.fromJson(row);
  }

  Future<List<Map<String, dynamic>>> getSchedule({
    required String semester,
    String? courseId,
  }) async {
    if (courseId != null) {
      return fetchAll(
        'schedules',
        filters: {'course_id': courseId, 'semester': semester},
        orderBy: 'start_time',
      );
    }
    return fetchWhere('schedules', 'semester', semester, orderBy: 'start_time');
  }

  Future<List<ExamScheduleRecord>> getExamSchedule({
    required String semester,
  }) async {
    final rows = await client
        .from('exam_schedules')
        .select('*, courses!inner(code, name_en)')
        .eq('semester', semester)
        .order('exam_date');
    return rows.map((row) => ExamScheduleRecord.fromJson(row)).toList();
  }

  Future<List<AttendanceRecord>> getStudentAttendance(
    String studentId,
    String courseId,
  ) async {
    final rows = await client
        .from('attendance')
        .select()
        .eq('student_id', studentId)
        .eq('course_id', courseId)
        .order('date', ascending: false);
    return rows.map((row) => AttendanceRecord.fromJson(row)).toList();
  }

  Future<AttendanceRecord> recordAttendance(
    AttendanceSubmission submission,
  ) async {
    final row = await client
        .from('attendance')
        .insert(submission.toDatabase())
        .select()
        .single();
    return AttendanceRecord.fromJson(row);
  }

  Future<List<ActionPlanItemRecord>> getActionPlan(String studentId) async {
    final rows = await client
        .from('action_plan_items')
        .select('*, courses(name_en)')
        .eq('student_id', studentId)
        .order('year');
    return rows.map((row) => ActionPlanItemRecord.fromJson(row)).toList();
  }

  Future<Map<String, dynamic>> updateActionPlanItem(
    String id,
    Map<String, dynamic> data,
  ) => update('action_plan_items', id, data);

  Future<List<GradeRecord>> getTranscript(String studentId) async {
    final result = await client
        .from('grades')
        .select('*, courses(*)')
        .eq('student_id', studentId)
        .eq('is_published', true)
        .order('semester');
    return result.map((row) => GradeRecord.fromJson(row)).toList();
  }

  Future<List<StudentScheduleRecord>> getStudentSchedule({
    required String studentId,
    required String semester,
  }) async {
    final regResponse = await client
        .from('student_course_registrations')
        .select('course_id, section_name, sub_section_name')
        .eq('student_id', studentId)
        .eq('semester', semester);

    if ((regResponse as List).isEmpty) return [];

    final allSchedules = <StudentScheduleRecord>[];

    for (final reg in regResponse) {
      final registration = DbRow(reg, context: 'student_course_registrations');
      final courseId = registration.requiredString('course_id');
      final sectionName = registration.optionalString('section_name');
      final subSectionName = registration.optionalString('sub_section_name');

      var query = client
          .from('schedules')
          .select(
            '*, courses!inner(name_en, name_ar, professor:profiles!courses_professor_id_fkey(full_name))',
          )
          .eq('course_id', courseId)
          .eq('semester', semester);

      if (sectionName != null) {
        query = query.eq('section_name', sectionName);
      }

      if (subSectionName != null) {
        query = query.eq('sub_section_name', subSectionName);
      }

      final schedules = await query;
      allSchedules.addAll(
        schedules.map((row) => StudentScheduleRecord.fromJson(row)),
      );
    }

    return allSchedules;
  }

  Future<List<Map<String, dynamic>>> getColleges() async {
    return fetchAll('colleges', orderBy: 'name_en');
  }

  Future<List<Map<String, dynamic>>> getDepartments({String? collegeId}) async {
    if (collegeId != null) {
      return fetchWhere(
        'departments',
        'college_id',
        collegeId,
        orderBy: 'name_en',
      );
    }
    return fetchAll('departments', orderBy: 'name_en');
  }

  Future<List<DepartmentProjectModel>> getDepartmentProjects(
    String departmentId,
  ) async {
    final rows = await client
        .from('department_projects')
        .select()
        .eq('department_id', departmentId)
        .order('created_at', ascending: false);
    return rows.map((row) => DepartmentProjectModel.fromJson(row)).toList();
  }
}
