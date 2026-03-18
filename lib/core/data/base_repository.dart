import 'package:supabase_flutter/supabase_flutter.dart';

class BaseRepository {
  final SupabaseClient client;

  BaseRepository(this.client);

  Future<List<Map<String, dynamic>>> fetchAll(
    String table, {
    String? orderBy,
    bool ascending = true,
    Map<String, dynamic>? filters,
    int? limit,
  }) async {
    var query = client.from(table).select();

    if (filters != null) {
      for (final entry in filters.entries) {
        query = query.eq(entry.key, entry.value);
      }
    }

    final List<dynamic> result;
    if (orderBy != null && limit != null) {
      result = await query.order(orderBy, ascending: ascending).limit(limit);
    } else if (orderBy != null) {
      result = await query.order(orderBy, ascending: ascending);
    } else if (limit != null) {
      result = await query.limit(limit);
    } else {
      result = await query;
    }

    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> fetchById(String table, String id) async {
    final result = await client.from(table).select().eq('id', id).single();
    return Map<String, dynamic>.from(result);
  }

  Future<List<Map<String, dynamic>>> fetchWhere(
    String table,
    String column,
    dynamic value, {
    String? orderBy,
    bool ascending = true,
  }) async {
    var query = client.from(table).select().eq(column, value);

    final List<dynamic> result;
    if (orderBy != null) {
      result = await query.order(orderBy, ascending: ascending);
    } else {
      result = await query;
    }

    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final result = await client.from(table).insert(data).select().single();
    return Map<String, dynamic>.from(result);
  }

  Future<List<Map<String, dynamic>>> insertMany(
    String table,
    List<Map<String, dynamic>> rows,
  ) async {
    final result = await client.from(table).insert(rows).select();
    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final result = await client
        .from(table)
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return Map<String, dynamic>.from(result);
  }

  Future<Map<String, dynamic>> upsert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final result = await client.from(table).upsert(data).select().single();
    return Map<String, dynamic>.from(result);
  }

  Future<void> softDelete(String table, String id) async {
    await client
        .from(table)
        .update({'deleted_at': DateTime.now().toIso8601String()})
        .eq('id', id);
  }

  Future<void> hardDelete(String table, String id) async {
    await client.from(table).delete().eq('id', id);
  }

  RealtimeChannel subscribe(
    String table, {
    required void Function(PostgresChangePayload payload) onInsert,
    void Function(PostgresChangePayload payload)? onUpdate,
    void Function(PostgresChangePayload payload)? onDelete,
  }) {
    final channel = client
        .channel('${table}_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: table,
          callback: onInsert,
        );

    if (onUpdate != null) {
      channel.onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: table,
        callback: onUpdate,
      );
    }

    if (onDelete != null) {
      channel.onPostgresChanges(
        event: PostgresChangeEvent.delete,
        schema: 'public',
        table: table,
        callback: onDelete,
      );
    }

    channel.subscribe();
    return channel;
  }

  Future<String> uploadFile(
    String bucket,
    String path,
    List<int> bytes, {
    String? contentType,
  }) async {
    await client.storage
        .from(bucket)
        .uploadBinary(
          path,
          bytes as dynamic,
          fileOptions: FileOptions(contentType: contentType),
        );
    return client.storage.from(bucket).getPublicUrl(path);
  }

  Future<String> getSignedUrl(
    String bucket,
    String path, {
    int expiresIn = 3600,
  }) async {
    return client.storage.from(bucket).createSignedUrl(path, expiresIn);
  }
}
