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
  }) async {
    if (semester != null) {
      final result = await client
          .from('enrollments')
          .select('*, courses(*)')
          .eq('student_id', studentId)
          .eq('semester', semester)
          .order('enrolled_at');
      return result.map((row) => EnrollmentRecord.fromJson(row)).toList();
    }
    final result = await client
        .from('enrollments')
        .select('*, courses(*)')
        .eq('student_id', studentId)
        .order('enrolled_at', ascending: false);
    return result.map((row) => EnrollmentRecord.fromJson(row)).toList();
  }

  Future<EnrollmentRecord> enrollInCourse(EnrollmentDraft draft) async {
    final row = await client
        .from('enrollments')
        .insert(draft.toDatabase())
        .select('*, courses(*)')
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
        .select('*, courses(*)')
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
        .select()
        .eq('student_id', studentId)
        .order('created_at', ascending: false);
    return rows.map((row) => Invoice.fromJson(row)).toList();
  }

  Future<Invoice> getInvoice(String invoiceId) async {
    final row = await client
        .from('invoices')
        .select()
        .eq('id', invoiceId)
        .single();
    return Invoice.fromJson(row);
  }
}
