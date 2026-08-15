import 'package:horus/core/data/base_repository.dart';

class AcademicRepository extends BaseRepository {
  AcademicRepository(super.client);

  Future<List<Map<String, dynamic>>> getCourses({String? semester}) async {
    if (semester != null) {
      return fetchWhere('courses', 'semester', semester, orderBy: 'code');
    }
    return fetchAll('courses', orderBy: 'code');
  }

  Future<Map<String, dynamic>> getCourse(String courseId) =>
      fetchById('courses', courseId);

  Future<List<Map<String, dynamic>>> getCoursesByProfessor(
    String professorId,
  ) => fetchWhere('courses', 'professor_id', professorId, orderBy: 'code');

  Future<List<Map<String, dynamic>>> getStudentGrades(
    String studentId, {
    String? semester,
  }) async {
    if (semester != null) {
      return fetchAll(
        'grades',
        filters: {
          'student_id': studentId,
          'semester': semester,
          'is_published': true,
        },
      );
    }
    return fetchWhere('grades', 'student_id', studentId);
  }

  Future<Map<String, dynamic>> submitGrade(Map<String, dynamic> gradeData) =>
      upsert('grades', gradeData);

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

  Future<List<Map<String, dynamic>>> getExamSchedule({
    required String semester,
  }) =>
      fetchWhere('exam_schedules', 'semester', semester, orderBy: 'exam_date');

  Future<List<Map<String, dynamic>>> getStudentAttendance(
    String studentId,
    String courseId,
  ) => fetchAll(
    'attendance',
    filters: {'student_id': studentId, 'course_id': courseId},
    orderBy: 'date',
    ascending: false,
  );

  Future<Map<String, dynamic>> recordAttendance(Map<String, dynamic> data) =>
      insert('attendance', data);

  Future<List<Map<String, dynamic>>> getActionPlan(String studentId) =>
      fetchWhere('action_plan_items', 'student_id', studentId, orderBy: 'year');

  Future<Map<String, dynamic>> updateActionPlanItem(
    String id,
    Map<String, dynamic> data,
  ) => update('action_plan_items', id, data);

  Future<List<Map<String, dynamic>>> getTranscript(String studentId) async {
    final result = await client
        .from('grades')
        .select('*, courses(*)')
        .eq('student_id', studentId)
        .eq('is_published', true)
        .order('semester');
    return List<Map<String, dynamic>>.from(result);
  }

  Future<List<Map<String, dynamic>>> getStudentSchedule({
    required String studentId,
    required String semester,
  }) async {
    final regResponse = await client
        .from('student_course_registrations')
        .select('course_id, section_name, sub_section_name')
        .eq('student_id', studentId)
        .eq('semester', semester);

    final registrations = regResponse as List;
    if (registrations.isEmpty) return [];

    // Collect all course IDs to fetch schedules in a single query (solves N+1 query problem)
    final List<String> courseIds =
        registrations.map((reg) => reg['course_id'] as String).toList();

    final schedulesResponse = await client
        .from('schedules')
        .select('*, courses(*)')
        .inFilter('course_id', courseIds)
        .eq('semester', semester);

    final List<Map<String, dynamic>> allSchedules =
        List<Map<String, dynamic>>.from(schedulesResponse);

    final List<Map<String, dynamic>> filteredSchedules = [];

    // Filter schedules client-side matching the student's registered sections/sub-sections
    for (final reg in registrations) {
      final courseId = reg['course_id'];
      final sectionName = reg['section_name'];
      final subSectionName = reg['sub_section_name'];

      final matchedSchedules = allSchedules.where((s) {
        final sameCourse = s['course_id'] == courseId;
        final sameSection =
            sectionName == null || s['section_name'] == sectionName;
        final sameSubSection =
            subSectionName == null || s['sub_section_name'] == subSectionName;
        return sameCourse && sameSection && sameSubSection;
      });

      filteredSchedules.addAll(matchedSchedules);
    }

    return filteredSchedules;
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

  Future<List<Map<String, dynamic>>> getDepartmentProjects(
    String departmentId,
  ) async {
    return fetchWhere(
      'department_projects',
      'department_id',
      departmentId,
      orderBy: 'created_at',
      ascending: false,
    );
  }
}
