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

  Future<AcademicSemester?> getCurrentSemester() async {
    final row = await client
        .from('semesters')
        .select('code,name_en,name_ar')
        .eq('is_current', true)
        .eq('is_active', true)
        .maybeSingle();
    return row == null ? null : AcademicSemester.fromJson(row);
  }

  Future<List<Course>> getCourses({
    String? semester,
    int offset = 0,
    int limit = 50,
  }) async {
    if (offset < 0 || limit < 1 || limit > 100) {
      throw ArgumentError('Course pagination is out of range.');
    }
    var query = client
        .from('courses')
        .select(
          'id,department_id,code,name_en,name_ar,description,credit_hours,is_active',
        );
    query = query.eq('is_active', true);
    if (semester != null) query = query.eq('semester', semester);
    final rows = await query.order('code').range(offset, offset + limit - 1);
    return rows.map((row) => Course.fromJson(row)).toList();
  }

  Future<Course> getCourse(String courseId) async {
    final row = await client
        .from('courses')
        .select(
          'id,department_id,code,name_en,name_ar,description,credit_hours,is_active',
        )
        .eq('id', courseId)
        .single();
    return Course.fromJson(row);
  }

  Future<List<Course>> getCoursesByProfessor(String professorId) async {
    final rows = await client
        .from('courses')
        .select(
          'id,department_id,code,name_en,name_ar,description,credit_hours,is_active',
        )
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
        .select(
          'id,student_id,course_id,semester,semester_id,coursework,midterm,practical,final_exam,total,grade_letter,gpa_points,is_published,published_at,created_at,updated_at,courses(code,name_en,name_ar,credit_hours)',
        )
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
        .select(
          'id,student_id,course_id,semester,semester_id,coursework,midterm,practical,final_exam,total,grade_letter,gpa_points,is_published,published_at,created_at,updated_at,courses(code,name_en,name_ar,credit_hours)',
        )
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
        .select(
          'id,course_id,exam_type,exam_date,start_time,end_time,semester,created_at,room,building,notes,courses!inner(code,name_en)',
        )
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
        .select(
          'id,student_id,course_id,date,status,notes,recorded_by,created_at,courses(code,name_en,name_ar,credit_hours)',
        )
        .eq('student_id', studentId)
        .eq('course_id', courseId)
        .order('date', ascending: false);
    return rows.map((row) => AttendanceRecord.fromJson(row)).toList();
  }

  Future<List<AttendanceRecord>> getStudentAttendanceRecords(
    String studentId, {
    int offset = 0,
    int limit = 100,
  }) async {
    if (offset < 0 || limit < 1 || limit > 100) {
      throw ArgumentError('Attendance pagination is out of range.');
    }
    final rows = await client
        .from('attendance')
        .select(
          'id,student_id,course_id,date,status,notes,recorded_by,created_at,courses(code,name_en,name_ar,credit_hours)',
        )
        .eq('student_id', studentId)
        .order('date', ascending: false)
        .range(offset, offset + limit - 1);
    return rows.map((row) => AttendanceRecord.fromJson(row)).toList();
  }

  Future<AttendanceRecord> recordAttendance(
    AttendanceSubmission submission,
  ) async {
    final row = await client
        .from('attendance')
        .insert(submission.toDatabase())
        .select(
          'id,student_id,course_id,date,status,notes,recorded_by,created_at,courses(code,name_en,name_ar,credit_hours)',
        )
        .single();
    return AttendanceRecord.fromJson(row);
  }

  Future<List<ActionPlanItemRecord>> getActionPlan(String studentId) async {
    final rows = await client
        .from('action_plan_items')
        .select(
          'id,student_id,semester,semester_id,year,course_id,status,grade_letter,notes,created_at,courses(name_en)',
        )
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
        .select(
          'id,student_id,course_id,semester,semester_id,coursework,midterm,practical,final_exam,total,grade_letter,gpa_points,is_published,published_at,created_at,updated_at,courses(code,name_en,name_ar,credit_hours)',
        )
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

    final registrations = <String, (String?, String?)>{};
    for (final reg in regResponse) {
      final registration = DbRow(reg, context: 'student_course_registrations');
      final courseId = registration.requiredString('course_id');
      registrations[courseId] = (
        registration.optionalString('section_name'),
        registration.optionalString('sub_section_name'),
      );
    }

    final scheduleRows = await client
        .from('schedules')
        .select(
          'id,course_id,day,start_time,end_time,schedule_type,room,building,section_name,sub_section_name,courses!inner(name_en,name_ar,professor:profiles!courses_professor_id_fkey(full_name))',
        )
        .eq('semester', semester)
        .inFilter('course_id', registrations.keys.toList())
        .order('start_time');

    return scheduleRows
        .where((row) {
          final selected = registrations[row['course_id'] as String];
          return selected != null &&
              (selected.$1 == null || row['section_name'] == selected.$1) &&
              (selected.$2 == null || row['sub_section_name'] == selected.$2);
        })
        .map((row) => StudentScheduleRecord.fromJson(row))
        .toList();
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
        .select(
          'id,department_id,title_en,title_ar,description_en,description_ar,status,created_at',
        )
        .eq('department_id', departmentId)
        .order('created_at', ascending: false);
    return rows.map((row) => DepartmentProjectModel.fromJson(row)).toList();
  }
}
