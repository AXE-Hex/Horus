
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/config/supabase_client.dart';
import 'package:hue/features/enrollment/data/models/registration_models.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final registrationRepositoryProvider = Provider((ref) {
  return RegistrationRepository(ref.watch(supabaseClientProvider));
});

class RegistrationRepository {
  final SupabaseClient _supabase;

  RegistrationRepository(this._supabase);

  Future<List<Course>> fetchCoursesBySemester(String semester) async {
    final response = await _supabase
        .from('courses')
        .select('*')
        .eq('is_active', true);
    return (response as List)
        .map(
          (json) => Course(
            id: json['id'],
            code: json['code'],
            name: json['name'],
            nameAr: json['name_ar'],
            description: json['description'],
            descriptionAr: json['description_ar'],
            credits: json['credits'],
            departmentId: json['department_id'],
            prerequisites: List<String>.from(json['prerequisites'] ?? []),
            isActive: json['is_active'],
          ),
        )
        .toList();
  }

  Future<List<String>> fetchAvailableSections(String semester) async {
    final response = await _supabase
        .from('course_sections')
        .select('name')
        .eq('semester', semester);

    final names = (response as List)
        .map((e) => e['name'] as String)
        .toSet()
        .toList();
    names.sort();
    return names;
  }

  Future<List<String>> fetchSubSections(
    String semester,
    String sectionName,
  ) async {
    final sectionsResp = await _supabase
        .from('course_sections')
        .select('id')
        .eq('semester', semester)
        .eq('name', sectionName);

    if ((sectionsResp as List).isEmpty) return [];

    final sectionIds = sectionsResp.map((e) => e['id']).toList();

    final subSectionsResp = await _supabase
        .from('course_sub_sections')
        .select('name')
        .inFilter('section_id', sectionIds);

    final names = (subSectionsResp as List)
        .map((e) => e['name'] as String)
        .toSet()
        .toList();
    names.sort();
    return names;
  }

  Future<StudentRegistration?> getStudentRegistration(
    String studentId,
    String semester,
  ) async {
    try {
      final response = await _supabase
          .from('student_registrations')
          .select('*')
          .eq('student_id', studentId)
          .eq('semester', semester)
          .maybeSingle();

      if (response == null) return null;
      return StudentRegistration.fromJson(response);
    } catch (e) {
      debugPrint('Error registering student: $e');
      return null;
    }
  }

  Future<void> registerStudent(
    String studentId,
    String semester,
    String sectionName,
    String subSectionName,
  ) async {
    await _supabase.from('student_registrations').upsert({
      'student_id': studentId,
      'semester': semester,
      'section_name': sectionName,
      'sub_section_name': subSectionName,
      'registered_at': DateTime.now().toIso8601String(),
    }, onConflict: 'student_id, semester');
  }
}
