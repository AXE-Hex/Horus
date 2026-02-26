import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'financial_repository.g.dart';

class FinancialRepository {
  final SupabaseClient _client;

  FinancialRepository(this._client);

  Future<void> recordTransaction({
    required String studentId,
    required double amount,
    required String type,
    String? reference,
  }) async {
    await _client.from('financial_transactions').insert({
      'student_id': studentId,
      'amount': amount,
      'type': type,
      'reference': reference,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<double> getStudentBalance(String studentId) async {
    final response = await _client.rpc(
      'get_student_balance',
      params: {'p_student_id': studentId},
    );
    return (response as num).toDouble();
  }

  Future<void> setFeeStatus({
    required String studentId,
    required String semesterId,
    required bool isPaid,
  }) async {
    await _client.from('student_fees').upsert({
      'student_id': studentId,
      'semester_id': semesterId,
      'is_paid': isPaid,
    });
  }
}

@Riverpod(keepAlive: true)
FinancialRepository financialRepository(Ref ref) {
  return FinancialRepository(Supabase.instance.client);
}
