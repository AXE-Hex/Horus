import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'academic_repository.g.dart';

class AcademicRepository {
  final SupabaseClient _client;

  AcademicRepository(this._client);

  Future<void> assignWorkload({
    required String professorId,
    required String courseId,
    required int hours,
    required String semesterId,
  }) async {
    await _client.rpc(
      'assign_academic_workload',
      params: {
        'p_professor_id': professorId,
        'p_course_id': courseId,
        'p_hours': hours,
        'p_semester_id': semesterId,
      },
    );
  }

  Future<void> updateScheduleEntry({
    required String entryId,
    required Map<String, dynamic> data,
  }) async {
    await _client.from('schedules').update(data).eq('id', entryId);
  }

  Future<void> approveFinalResults({
    required String courseId,
    required String semesterId,
    required String approverId,
  }) async {
    await _client.rpc(
      'approve_course_results',
      params: {
        'p_course_id': courseId,
        'p_semester_id': semesterId,
        'p_approver_id': approverId,
      },
    );
  }
}

@Riverpod(keepAlive: true)
AcademicRepository academicRepository(Ref ref) {
  return AcademicRepository(Supabase.instance.client);
}
