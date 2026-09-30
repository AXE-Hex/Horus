import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/features/enrollment/data/models/invoice_models.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final enrollmentRepositoryProvider = Provider<EnrollmentRepository>((ref) {
  return EnrollmentRepository(ref.watch(supabaseClientProvider));
});

class EnrollmentRepository {
  EnrollmentRepository(this.client);

  final SupabaseClient client;

  Future<List<EnrollmentRecord>> getStudentEnrollments(
    String studentId, {
    String? semester,
    int offset = 0,
    int limit = 100,
  }) async {
    if (offset < 0 || limit < 1 || limit > 100) {
      throw ArgumentError('Enrollment pagination is out of range.');
    }
    var query = client
        .from('enrollments')
        .select(
          'id,student_id,course_id,status,semester,semester_id,enrolled_at,approved_at,created_at,updated_at,courses(id,code,name_en,name_ar,description,credit_hours,department_id,is_active)',
        )
        .eq('student_id', studentId);
    if (semester != null) {
      query = query.eq('semester', semester);
    }
    final result = await query
        .order('enrolled_at', ascending: false)
        .range(offset, offset + limit - 1);
    return result.map((row) => EnrollmentRecord.fromJson(row)).toList();
  }

  Future<EnrollmentRecord> enrollInCourse(EnrollmentDraft draft) async {
    final row = await client
        .from('enrollments')
        .insert(draft.toDatabase())
        .select(
          'id,student_id,course_id,status,semester,semester_id,enrolled_at,approved_at,created_at,updated_at,courses(id,code,name_en,name_ar,description,credit_hours,department_id,is_active)',
        )
        .single();
    return EnrollmentRecord.fromJson(row);
  }

  Future<EnrollmentRecord> updateEnrollmentStatus(
    String id,
    EnrollmentStatus status,
  ) async {
    if (status == EnrollmentStatus.unknown) {
      throw StateError('Unknown enrollment status cannot be written.');
    }
    final row = await client
        .from('enrollments')
        .update({'status': status.name})
        .eq('id', id)
        .select(
          'id,student_id,course_id,status,semester,semester_id,enrolled_at,approved_at,created_at,updated_at,courses(id,code,name_en,name_ar,description,credit_hours,department_id,is_active)',
        )
        .single();
    return EnrollmentRecord.fromJson(row);
  }

  Future<void> withdrawFromCourse(String enrollmentId) => client
      .from('enrollments')
      .update({'status': 'withdrawn'})
      .eq('id', enrollmentId);

  Future<List<Invoice>> getStudentInvoices(String studentId) async {
    final rows = await client
        .from('invoices')
        .select(
          'id,student_id,semester,description,description_ar,amount,currency,status,due_date,paid_at,receipt_url,created_at',
        )
        .eq('student_id', studentId)
        .order('created_at', ascending: false);
    return rows.map((row) => Invoice.fromJson(row)).toList();
  }

  Future<Invoice> getInvoice(String invoiceId) async {
    final row = await client
        .from('invoices')
        .select(
          'id,student_id,semester,description,description_ar,amount,currency,status,due_date,paid_at,receipt_url,created_at',
        )
        .eq('id', invoiceId)
        .single();
    return Invoice.fromJson(row);
  }
}
