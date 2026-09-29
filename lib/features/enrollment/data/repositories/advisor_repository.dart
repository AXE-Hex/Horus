import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/core/data/db_row.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final advisorRepositoryProvider = Provider((ref) {
  return AdvisorRepository(ref.watch(supabaseClientProvider));
});

class AdvisorRepository {
  final SupabaseClient _supabase;
  AdvisorRepository(this._supabase);

  String get _currentUserId => _supabase.auth.currentUser?.id ?? '';

  Future<List<RegistrationRequest>> getAdvisorRequests({
    String? statusFilter,
  }) async {
    try {
      final response = await _supabase
          .from('registration_requests')
          .select('''
            *,
            registration_request_courses(*, courses(*)),
            student:profiles!student_id(id, full_name, avatar_url)
          ''')
          .eq('advisor_id', _currentUserId)
          .order('submitted_at', ascending: false);

      final list = (response as List)
          .map((j) => RegistrationRequest.fromJson(j))
          .toList();

      if (statusFilter != null) {
        return list.where((r) => r.status.name == statusFilter).toList();
      }
      return list;
    } catch (e) {
      debugPrint('getAdvisorRequests error: $e');
      return [];
    }
  }

  Future<void> approveRequest(String requestId, {String? notes}) async {
    await _supabase
        .from('registration_requests')
        .update({
          'status': 'approved',
          'advisor_notes': notes,
          'reviewed_at': DateTime.now().toIso8601String(),
        })
        .eq('id', requestId);
  }

  Future<void> rejectRequest(String requestId, {String? notes}) async {
    await _supabase
        .from('registration_requests')
        .update({
          'status': 'rejected',
          'advisor_notes': notes,
          'reviewed_at': DateTime.now().toIso8601String(),
        })
        .eq('id', requestId);
  }

  Future<List<AdvisorStudent>> getAdvisorStudents() async {
    try {
      final response = await _supabase.rpc(
        'get_advisor_directory',
        params: {
          'p_college_id': null,
          'p_assigned_to_me': true,
          'p_unassigned_only': false,
        },
      );
      return (response as List)
          .map((row) => AdvisorStudent.fromJson(Map<String, dynamic>.from(row)))
          .toList();
    } catch (e) {
      debugPrint('getAdvisorStudents error: $e');
      return [];
    }
  }

  Future<List<AdvisorInfo>> getCollegeAdvisors(String collegeId) async {
    try {
      final response = await _supabase
          .from('profile_directory')
          .select('id, full_name, avatar_url')
          .contains('role_codes', ['academic_advisor'])
          .eq('college_id', collegeId);
      return (response as List)
          .map((j) => AdvisorInfo.fromJson(Map<String, dynamic>.from(j)))
          .toList();
    } catch (e) {
      debugPrint('getCollegeAdvisors error: $e');
      return [];
    }
  }

  Future<List<AdvisorStudent>> getCollegeStudents(
    String collegeId, {
    bool unassignedOnly = false,
  }) async {
    try {
      final response = await _supabase.rpc(
        'get_advisor_directory',
        params: {
          'p_college_id': collegeId,
          'p_assigned_to_me': false,
          'p_unassigned_only': unassignedOnly,
        },
      );
      return (response as List)
          .map((row) => AdvisorStudent.fromJson(Map<String, dynamic>.from(row)))
          .toList();
    } catch (e) {
      debugPrint('getCollegeStudents error: $e');
      return [];
    }
  }

  Future<void> assignAdvisorToStudent({
    required String studentId,
    required String advisorId,
  }) async {
    await _supabase.rpc(
      'assign_student_advisor',
      params: {'p_student_id': studentId, 'p_advisor_id': advisorId},
    );
  }

  Future<void> removeAdvisorFromStudent(String studentId) async {
    await _supabase.rpc(
      'assign_student_advisor',
      params: {'p_student_id': studentId, 'p_advisor_id': null},
    );
  }

  Future<AdvisorInfo?> getMyAdvisor() async {
    try {
      final profileRows = await _supabase.rpc('get_my_profile_private');
      final profile = DbRow(
        (profileRows as List).single,
        context: 'private profile',
      );

      final advisorId = profile.optionalString('advisor_id');
      if (advisorId == null) return null;

      final advisor = await _supabase
          .from('profiles')
          .select('id, full_name, avatar_url')
          .eq('id', advisorId)
          .single();

      return AdvisorInfo.fromJson(Map<String, dynamic>.from(advisor));
    } catch (e) {
      debugPrint('getMyAdvisor error: $e');
      return null;
    }
  }

  Future<RegistrationRequest> submitRegistrationRequest({
    required String semester,
    required List<RegistrationCourseSelection> courses,
  }) async {
    final profileRows = await _supabase.rpc('get_my_profile_private');
    final profile = DbRow(
      (profileRows as List).single,
      context: 'private profile',
    );

    final advisorId = profile.optionalString('advisor_id');

    await _supabase
        .from('registration_requests')
        .delete()
        .eq('student_id', _currentUserId)
        .eq('semester', semester)
        .eq('status', 'pending');

    final requestData = await _supabase
        .from('registration_requests')
        .insert({
          'student_id': _currentUserId,
          'advisor_id': advisorId,
          'semester': semester,
          'status': 'pending',
          'submitted_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    final requestId = DbRow(
      requestData,
      context: 'registration_requests',
    ).requiredString('id');

    if (courses.isNotEmpty) {
      await _supabase
          .from('registration_request_courses')
          .insert(
            courses
                .map(
                  (course) => {
                    'request_id': requestId,
                    'course_id': course.courseId,
                    'section_name': course.sectionName,
                    'sub_section_name': course.subSectionName,
                  },
                )
                .toList(),
          );
    }

    final full = await _supabase
        .from('registration_requests')
        .select('*, registration_request_courses(*, courses(*))')
        .eq('id', requestId)
        .single();

    return RegistrationRequest.fromJson(full);
  }

  Future<RegistrationRequest?> getMyRegistrationRequest(String semester) async {
    try {
      final response = await _supabase
          .from('registration_requests')
          .select('''
            *,
            registration_request_courses(*, courses(*)),
            advisor:profiles!advisor_id(id, full_name, avatar_url)
          ''')
          .eq('student_id', _currentUserId)
          .eq('semester', semester)
          .maybeSingle();

      if (response == null) return null;
      return RegistrationRequest.fromJson(response);
    } catch (e) {
      debugPrint('getMyRegistrationRequest error: $e');
      return null;
    }
  }

  Future<int> getPendingRequestCount() async {
    try {
      final response = await _supabase
          .from('registration_requests')
          .select('id')
          .eq('advisor_id', _currentUserId)
          .eq('status', 'pending');
      return (response as List).length;
    } catch (e) {
      return 0;
    }
  }
}
