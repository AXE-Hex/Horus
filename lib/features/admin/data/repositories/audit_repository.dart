import 'package:hue/features/admin/data/models/audit_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'audit_repository.g.dart';

class AuditRepository {
  final SupabaseClient _client;

  AuditRepository(this._client);

  Future<List<AuditLogModel>> getLogs({
    String? tableName,
    String? recordId,
    String? performedBy,
    int limit = 100,
  }) async {
    var query = _client
        .from('audit_logs')
        .select('*, profiles!performed_by(full_name)');

    if (tableName != null) query = query.eq('table_name', tableName);
    if (recordId != null) query = query.eq('record_id', recordId);
    if (performedBy != null) query = query.eq('performed_by', performedBy);

    final response = await query
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((json) => AuditLogModel.fromJson(json))
        .toList();
  }

  Stream<List<AuditLogModel>> watchLogs({
    String? tableName,
    String? recordId,
    String? performedBy,
    int limit = 100,
  }) {
    dynamic stream = _client.from('audit_logs').stream(primaryKey: ['id']);

    if (tableName != null) stream = stream.eq('table_name', tableName);
    if (recordId != null) stream = stream.eq('record_id', recordId);
    if (performedBy != null) stream = stream.eq('performed_by', performedBy);

    return stream
        .order('created_at', ascending: false)
        .limit(limit)
        .map<List<AuditLogModel>>((list) {
          return (list as List)
              .map(
                (json) => AuditLogModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        });
  }

  Future<void> logAction({
    required String action,
    required String tableName,
    String? recordId,
    Map<String, dynamic>? oldData,
    Map<String, dynamic>? newData,
    String? notes,
  }) async {
    await _client.from('audit_logs').insert({
      'performed_by': _client.auth.currentUser?.id,
      'action': action,
      'table_name': tableName,
      'record_id': recordId,
      'old_data': oldData,
      'new_data': newData,
      'notes': notes,
    });
  }

  Future<void> addLogReport(String logId, String report) async {
    await _client.from('audit_logs').update({'notes': report}).eq('id', logId);
  }
}

@Riverpod(keepAlive: true)
AuditRepository auditRepository(Ref ref) {
  return AuditRepository(Supabase.instance.client);
}
