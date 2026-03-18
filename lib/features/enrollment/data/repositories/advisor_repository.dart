import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/config/supabase_client.dart';
import 'package:hue/features/enrollment/data/models/registration_models.dart';
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
            student:profiles!student_id(id, full_name, email, avatar_url, student_id)
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

  Future<List<Map<String, dynamic>>> getAdvisorStudents() async {
    try {
      final response = await _supabase
          .from('profiles')
          .select(
            'id, full_name, email, student_id, avatar_url, department_id, college_id',
          )
          .eq('advisor_id', _currentUserId)
          .order('full_name');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('getAdvisorStudents error: $e');
      return [];
    }
  }

  Future<List<AdvisorInfo>> getCollegeAdvisors(String collegeId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select('id, full_name, email, avatar_url')
          .contains('roles', ['academic_advisor'])
          .eq('college_id', collegeId);
      return (response as List).map((j) => AdvisorInfo.fromJson(j)).toList();
    } catch (e) {
      debugPrint('getCollegeAdvisors error: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getCollegeStudents(
    String collegeId, {
    bool unassignedOnly = false,
  }) async {
    try {
      var query = _supabase
          .from('profiles')
          .select(
            'id, full_name, email, student_id, avatar_url, advisor_id, department_id',
          )
          .eq('college_id', collegeId)
          .contains('roles', ['student']);

      if (unassignedOnly) {
        query = query.isFilter('advisor_id', null);
      }

      final response = await query.order('full_name');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('getCollegeStudents error: $e');
      return [];
    }
  }

  Future<void> assignAdvisorToStudent({
    required String studentId,
    required String advisorId,
  }) async {
    await _supabase
        .from('profiles')
        .update({'advisor_id': advisorId})
        .eq('id', studentId);
  }

  Future<void> removeAdvisorFromStudent(String studentId) async {
    await _supabase
        .from('profiles')
        .update({'advisor_id': null})
        .eq('id', studentId);
  }

  Future<AdvisorInfo?> getMyAdvisor() async {
    try {
      final profile = await _supabase
          .from('profiles')
          .select('advisor_id')
          .eq('id', _currentUserId)
          .single();

      final advisorId = profile['advisor_id'];
      if (advisorId == null) return null;

      final advisor = await _supabase
          .from('profiles')
          .select('id, full_name, email, avatar_url')
          .eq('id', advisorId)
          .single();

      return AdvisorInfo.fromJson(advisor);
    } catch (e) {
      debugPrint('getMyAdvisor error: $e');
      return null;
    }
  }

  Future<RegistrationRequest> submitRegistrationRequest({
    required String semester,
    required List<Map<String, dynamic>> courses,
  }) async {
    final profile = await _supabase
        .from('profiles')
        .select('advisor_id')
        .eq('id', _currentUserId)
        .single();

    final advisorId = profile['advisor_id'];

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

    final requestId = requestData['id'];

    if (courses.isNotEmpty) {
      await _supabase
          .from('registration_request_courses')
          .insert(
            courses
                .map(
                  (c) => {
                    'request_id': requestId,
                    'course_id': c['course_id'],
                    'section_name': c['section_name'],
                    'sub_section_name': c['sub_section_name'],
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
            advisor:profiles!advisor_id(id, full_name, email, avatar_url)
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
