import 'package:hue/features/admin/data/models/audit_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'audit_repository.g.dart';

class AuditRepository {
  final SupabaseClient _client;

  AuditRepository(this._client);

  Future<List<AuditLogModel>> getLogs({
    String? entityType,
    String? entityId,
    String? actorId,
    int limit = 100,
  }) async {
    var query = _client.from('audit_logs').select();

    if (entityType != null) query = query.eq('entity_type', entityType);
    if (entityId != null) query = query.eq('entity_id', entityId);
    if (actorId != null) query = query.eq('actor_id', actorId);

    final response = await query
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((json) => AuditLogModel.fromJson(json))
        .toList();
  }

  Stream<List<AuditLogModel>> watchLogs({
    String? entityType,
    String? entityId,
    String? actorId,
    int limit = 100,
  }) {
    dynamic stream = _client.from('audit_logs').stream(primaryKey: ['id']);

    if (entityType != null) stream = stream.eq('entity_type', entityType);
    if (entityId != null) stream = stream.eq('entity_id', entityId);
    if (actorId != null) stream = stream.eq('actor_id', actorId);

    return stream
        .order('created_at', ascending: false)
        .limit(limit)
        .map(
          (list) => list.map((json) => AuditLogModel.fromJson(json)).toList(),
        );
  }

  Future<void> logAction({
    required String action,
    required String entityType,
    String? entityId,
    Map<String, dynamic>? oldData,
    Map<String, dynamic>? newData,
  }) async {
    await _client.rpc(
      'log_audit_event',
      params: {
        'p_action': action,
        'p_entity_type': entityType,
        'p_entity_id': entityId,
        'p_old_data': oldData,
        'p_new_data': newData,
      },
    );
  }

  Future<void> addLogReport(String logId, String report) async {
    await _client.from('audit_logs').update({'report': report}).eq('id', logId);
  }
}

@Riverpod(keepAlive: true)
AuditRepository auditRepository(Ref ref) {
  return AuditRepository(Supabase.instance.client);
}
