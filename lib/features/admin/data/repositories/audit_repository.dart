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
    // Note: Supabase realtime might not natively support joining `profiles`
    // effectively in a standard stream without a view, but we can try basic watch.
    // For standard `stream()`, left joins aren't supported.
    // Best approach for realtime is usually watching just the table and mapping manually or relying on `getLogs` polling instead if full names are crucial.
    // We will use `.stream` just on `audit_logs` primarily to satisfy current structure, but actorName won't auto-resolve here without `.select()` which isn't available on raw `.stream`.

    // We will switch to polling or simple stream. Keep stream for now:
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
    // Inserting directly since we might not have the rpc 'log_audit_event' setup correctly.
    // Assuming 'audit_logs' allows inserts via RLS or this is admin.
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
