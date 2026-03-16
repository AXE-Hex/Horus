
import 'package:hue/core/data/base_repository.dart';

class EnrollmentRepository extends BaseRepository {
  EnrollmentRepository(super.client);

  Future<List<Map<String, dynamic>>> getStudentEnrollments(
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
      return List<Map<String, dynamic>>.from(result);
    }
    final result = await client
        .from('enrollments')
        .select('*, courses(*)')
        .eq('student_id', studentId)
        .order('enrolled_at', ascending: false);
    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> enrollInCourse(Map<String, dynamic> data) =>
      insert('enrollments', data);

  Future<Map<String, dynamic>> updateEnrollmentStatus(
    String id,
    String status,
  ) => update('enrollments', id, {'status': status});

  Future<void> withdrawFromCourse(String enrollmentId) =>
      update('enrollments', enrollmentId, {'status': 'withdrawn'});

  Future<List<Map<String, dynamic>>> getStudentInvoices(String studentId) =>
      fetchWhere(
        'invoices',
        'student_id',
        studentId,
        orderBy: 'created_at',
        ascending: false,
      );

  Future<Map<String, dynamic>> getInvoice(String invoiceId) =>
      fetchById('invoices', invoiceId);

  Future<Map<String, dynamic>> markInvoicePaid(
    String invoiceId, {
    String? receiptUrl,
  }) => update('invoices', invoiceId, {
    'status': 'paid',
    'paid_at': DateTime.now().toIso8601String(),
    'receipt_url': receiptUrl,
  });
}
