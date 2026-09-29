import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/institutional/data/models/institutional_models.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/features/profiles/data/models/directory_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InstitutionalRepository {
  final SupabaseClient _client;

  InstitutionalRepository(this._client);

  Future<List<CollegeModel>> getColleges() async {
    final response = await _client.from('colleges').select().order('name_en');
    return (response as List)
        .map((json) => CollegeModel.fromJson(json))
        .toList();
  }

  Future<CollegeModel?> getCollegeForDean(String deanId) async {
    final response = await _client
        .from('colleges')
        .select()
        .eq('dean_id', deanId)
        .maybeSingle();
    return response == null ? null : CollegeModel.fromJson(response);
  }

  Future<List<DepartmentModel>> getDepartments({String? collegeId}) async {
    var query = _client.from('departments').select();
    if (collegeId != null) {
      query = query.eq('college_id', collegeId);
    }
    final response = await query.order('name_en');
    return (response as List)
        .map((json) => DepartmentModel.fromJson(json))
        .toList();
  }

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

  Future<Map<String, int>> getCollegeRealTimeStats(String collegeId) async {
    try {
      final directory = await _client
          .from('profile_directory')
          .select('role_codes')
          .eq('college_id', collegeId);
      final roleLists = (directory as List)
          .map((row) => (row['role_codes'] as List).cast<String>())
          .toList();
      final studentsCount = roleLists
          .where(
            (roles) => roles.any(
              (role) =>
                  {'student', 'freshman', 'regular_student'}.contains(role),
            ),
          )
          .length;
      final facultyCount = roleLists
          .where(
            (roles) =>
                roles.any((role) => {'professor', 'lecturer'}.contains(role)),
          )
          .length;
      final assistantsCount = roleLists
          .where((roles) => roles.contains('teaching_assistant'))
          .length;

      final researchResponse = await _client
          .from('shared_files')
          .select('id, courses!inner(departments!inner(college_id))')
          .eq('courses.departments.college_id', collegeId);
      final researchCount = (researchResponse as List).length;

      return {
        'students': studentsCount,
        'faculty': facultyCount,
        'assistants': assistantsCount,
        'research': researchCount,
      };
    } catch (e) {
      debugPrint('Error fetching college stats: $e');
      return {'students': 0, 'faculty': 0, 'assistants': 0, 'research': 0};
    }
  }

  Future<List<DirectoryProfileModel>> getCollegeStaffList(
    String collegeId,
  ) async {
    final response = await _client
        .from('profile_directory')
        .select()
        .eq('college_id', collegeId)
        .order('full_name');

    return (response as List)
        .map((json) => DirectoryProfileModel.fromJson(json))
        .where((profile) => profile.roles.any((role) => role.isTeachingStaff))
        .toList();
  }
}

final institutionalRepositoryProvider = Provider<InstitutionalRepository>((
  ref,
) {
  return InstitutionalRepository(Supabase.instance.client);
});

final collegeRealTimeStatsProvider =
    FutureProvider.family<Map<String, int>, String>((ref, collegeId) async {
      return ref
          .watch(institutionalRepositoryProvider)
          .getCollegeRealTimeStats(collegeId);
    });

final collegeStaffListProvider =
    FutureProvider.family<List<DirectoryProfileModel>, String>((
      ref,
      collegeId,
    ) async {
      return ref
          .watch(institutionalRepositoryProvider)
          .getCollegeStaffList(collegeId);
    });
