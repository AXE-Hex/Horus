import 'package:hue/core/data/base_repository.dart';

class OnboardingRepository extends BaseRepository {
  OnboardingRepository(super.client);

  Future<List<Map<String, dynamic>>> getColleges() async {
    final result = await client
        .from('colleges')
        .select('*, profiles:dean_id(full_name, full_name_ar, avatar_url)')
        .order('name');
    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> getCollege(String collegeId) async {
    final result = await client
        .from('colleges')
        .select('*, profiles:dean_id(full_name, full_name_ar, avatar_url)')
        .eq('id', collegeId)
        .single();
    return Map<String, dynamic>.from(result);
  }

  Future<List<Map<String, dynamic>>> getDepartments(String collegeId) async {
    final result = await client
        .from('departments')
        .select('*, profiles:hod_id(full_name, full_name_ar, avatar_url)')
        .eq('college_id', collegeId)
        .order('name');
    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> getDepartment(String departmentId) async {
    final result = await client
        .from('departments')
        .select('''
          *,
          profiles:hod_id(full_name, full_name_ar, email, avatar_url, bio),
          colleges(name, name_ar, code)
        ''')
        .eq('id', departmentId)
        .single();
    return Map<String, dynamic>.from(result);
  }

  Future<List<Map<String, dynamic>>> getStaffByDepartment(
    String departmentId,
  ) async {
    final result = await client
        .from('professor_details')
        .select(
          '*, profiles(full_name, full_name_ar, email, avatar_url, roles)',
        )
        .eq('department_id', departmentId)
        .order('created_at');
    return List<Map<String, dynamic>>.from(result);
  }
}
