import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'institutional_repository.g.dart';

class InstitutionalRepository {
  final SupabaseClient _client;

  InstitutionalRepository(this._client);

  // Colleges
  Future<List<CollegeModel>> getColleges() async {
    final response = await _client.from('colleges').select().order('name_en');
    return (response as List)
        .map((json) => CollegeModel.fromJson(json))
        .toList();
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

  // Departments
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

  Future<void> createDepartment(Map<String, dynamic> data) async {
    await _client.from('departments').insert(data);
  }

  Future<void> updateDepartment(String id, Map<String, dynamic> data) async {
    await _client.from('departments').update(data).eq('id', id);
  }

  Future<void> deleteDepartment(String id) async {
    await _client.from('departments').delete().eq('id', id);
  }

  // Appointments
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
