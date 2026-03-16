import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'institutional_repository.g.dart';

class InstitutionalRepository {
  final SupabaseClient _client;

  InstitutionalRepository(this._client);

  // ─── Colleges ───────────────────────────────────────────────

  Future<List<CollegeModel>> getColleges() async {
    final response = await _client.from('colleges').select().order('name');
    return (response as List)
        .map((json) => CollegeModel.fromJson(json))
        .toList();
  }

  Future<CollegeModel> getCollegeById(String id) async {
    final response = await _client
        .from('colleges')
        .select()
        .eq('id', id)
        .single();
    return CollegeModel.fromJson(response);
  }

  Future<void> createCollege(Map<String, dynamic> data) async {
    await _client.from('colleges').insert(data);
  }

  Future<void> updateCollege(String id, Map<String, dynamic> data) async {
    await _client.from('colleges').update(data).eq('id', id);
  }

  Future<void> deleteCollege(String id) async {
    await _client.from('colleges').delete().eq('id', id);
  }

  // ─── Departments ────────────────────────────────────────────

  Future<List<DepartmentModel>> getDepartments({String? collegeId}) async {
    var query = _client.from('departments').select();
    if (collegeId != null) {
      query = query.eq('college_id', collegeId);
    }
    final response = await query.order('name');
    return (response as List)
        .map((json) => DepartmentModel.fromJson(json))
        .toList();
  }

  Future<DepartmentModel> getDepartmentById(String id) async {
    final response = await _client
        .from('departments')
        .select()
        .eq('id', id)
        .single();
    return DepartmentModel.fromJson(response);
  }

  Future<void> createDepartment(Map<String, dynamic> data) async {
    await _client.from('departments').insert(data);
  }

  Future<void> updateDepartment(String id, Map<String, dynamic> data) async {
    await _client.from('departments').update(data).eq('id', id);
  }

  Future<void> deleteDepartment(String id) async {
    await _client.from('departments').delete().eq('id', id);
  }

  // ─── Staff Management ──────────────────────────────────────

  /// Get all faculty/staff users assigned to a specific department
  Future<List<UserProfileModel>> getStaffByDepartment(
    String departmentId,
  ) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('department_id', departmentId)
        .order('full_name');
    return (response as List)
        .map((json) => UserProfileModel.fromJson(json))
        .toList();
  }

  /// Get all faculty/staff users assigned to a specific college
  Future<List<UserProfileModel>> getStaffByCollege(String collegeId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('college_id', collegeId)
        .order('full_name');
    return (response as List)
        .map((json) => UserProfileModel.fromJson(json))
        .toList();
  }

  /// Assign a user to a department (and its parent college)
  Future<void> assignStaffToDepartment(
    String userId,
    String departmentId,
    String collegeId,
  ) async {
    await _client
        .from('profiles')
        .update({'department_id': departmentId, 'college_id': collegeId})
        .eq('id', userId);
  }

  /// Remove a user from their department
  Future<void> removeStaffFromDepartment(String userId) async {
    await _client
        .from('profiles')
        .update({'department_id': null})
        .eq('id', userId);
  }

  // ─── Department Projects ────────────────────────────────────

  Future<List<DepartmentProjectModel>> getDepartmentProjects(
    String departmentId,
  ) async {
    final response = await _client
        .from('department_projects')
        .select()
        .eq('department_id', departmentId)
        .order('created_at', ascending: false);
    return (response as List)
        .map((json) => DepartmentProjectModel.fromJson(json))
        .toList();
  }

  // ─── Appointments ───────────────────────────────────────────

  Future<List<AppointmentModel>> getAppointments({
    bool activeOnly = true,
  }) async {
    var query = _client.from('appointments').select();
    if (activeOnly) {
      query = query.eq('is_active', true);
    }
    final response = await query.order('start_date', ascending: false);
    return (response as List)
        .map((json) => AppointmentModel.fromJson(json))
        .toList();
  }

  Future<void> createAppointment(Map<String, dynamic> data) async {
    await _client.from('appointments').insert(data);
  }

  Future<void> endAppointment(String id) async {
    await _client
        .from('appointments')
        .update({
          'is_active': false,
          'end_date': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }
}

@Riverpod(keepAlive: true)
InstitutionalRepository institutionalRepository(Ref ref) {
  return InstitutionalRepository(Supabase.instance.client);
}
