import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/institutional/data/models/institutional_models.dart';
import 'package:horus/features/profiles/data/models/directory_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InstitutionalRepository {
  final SupabaseClient _client;

  InstitutionalRepository(this._client);

  Future<List<CollegeModel>> getColleges() async {
    final response = await _client
        .from('colleges')
        .select(
          'id,name_en,name_ar,code,description,description_ar,dean_id,image_url,established,student_count,created_at',
        )
        .eq('is_active', true)
        .order('name_en');
    return (response as List)
        .map((json) => CollegeModel.fromJson(json))
        .toList();
  }

  Future<CollegeModel?> getCollegeForDean(String deanId) async {
    final response = await _client
        .from('colleges')
        .select(
          'id,name_en,name_ar,code,description,description_ar,dean_id,image_url,established,student_count,created_at',
        )
        .eq('dean_id', deanId)
        .maybeSingle();
    return response == null ? null : CollegeModel.fromJson(response);
  }

  Future<List<DepartmentModel>> getDepartments({String? collegeId}) async {
    var query = _client
        .from('departments')
        .select(
          'id,college_id,name_en,name_ar,code,description,description_ar,hod_id,assistant_hod_id,building,floor,office_symbol,student_count,created_at',
        )
        .eq('is_active', true);
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
        .select(
          'id,department_id,title_en,title_ar,description_en,description_ar,status,created_at',
        )
        .eq('department_id', departmentId)
        .order('created_at', ascending: false);
    return (response as List)
        .map((json) => DepartmentProjectModel.fromJson(json))
        .toList();
  }

  Future<Map<String, int>> getCollegeRealTimeStats(String collegeId) async {
    Future<int> people(List<String> roles) => _client
        .from('profile_directory')
        .count(CountOption.exact)
        .eq('college_id', collegeId)
        .overlaps('role_codes', roles);
    final counts = await Future.wait([
      people(['student', 'freshman', 'regular_student']),
      people(['professor', 'lecturer']),
      people(['teaching_assistant']),
    ]);
    // Shared files are learning materials, not a publication database. Do not
    // misrepresent their count as a research/publication statistic.
    return {
      'students': counts[0],
      'faculty': counts[1],
      'assistants': counts[2],
    };
  }

  Future<List<DirectoryProfileModel>> getCollegeStaffList(
    String collegeId,
  ) async {
    final response = await _client
        .from('profile_directory')
        .select(
          'id,full_name,full_name_ar,avatar_url,college_id,department_id,created_at,role_codes',
        )
        .eq('college_id', collegeId)
        .overlaps('role_codes', [
          'professor',
          'lecturer',
          'teaching_assistant',
          'dean',
          'department_head',
          'assistant_hod',
        ])
        .order('full_name')
        .range(0, 99);

    return (response as List)
        .map((json) => DirectoryProfileModel.fromJson(json))
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
