import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final conversationRepositoryProvider = Provider<ConversationRepository>(
  (ref) => ConversationRepository(Supabase.instance.client),
);

class ConversationRepository {
  ConversationRepository(this._client);

  final SupabaseClient _client;

  static const _conversationProjection = '''
    id, title, is_group, created_by, last_message, last_message_at,
    created_at, updated_at,
    conversation_members(
      conversation_id, user_id, joined_at, last_read_at, is_admin, is_muted,
      profiles(id, full_name, avatar_url)
    )
  ''';

  static const _messageProjection = '''
    id, conversation_id, sender_id, content, media_url, status,
    reply_to_id, is_edited, created_at, deleted_at,
    sender:profiles!messages_sender_id_fkey(id, full_name, avatar_url)
  ''';

  Future<List<ConversationRecord>> getConversations({
    int limit = 30,
    int offset = 0,
  }) async {
    if (limit < 1 || limit > 50 || offset < 0) {
      throw ArgumentError('Conversation page is out of range.');
    }
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return const [];

    final response = await _client
        .from('conversations')
        .select(_conversationProjection)
        .order('last_message_at', ascending: false)
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    return (response as List<dynamic>)
        .map(
          (row) => ConversationRecord.fromJson(
            Map<String, dynamic>.from(row as Map),
          ),
        )
        .where(
          (conversation) =>
              conversation.members.any((member) => member.userId == userId),
        )
        .toList(growable: false);
  }

  Future<ConversationRecord?> getConversation(String conversationId) async {
    final response = await _client
        .from('conversations')
        .select(_conversationProjection)
        .eq('id', conversationId)
        .maybeSingle();
    if (response == null) return null;
    return ConversationRecord.fromJson(Map<String, dynamic>.from(response));
  }

  Future<List<MessageRecord>> getMessages(
    String conversationId, {
    int limit = 50,
    DateTime? before,
  }) async {
    if (limit < 1 || limit > 100) {
      throw ArgumentError('Message page is out of range.');
    }
    var query = _client
        .from('messages')
        .select(_messageProjection)
        .eq('conversation_id', conversationId)
        .isFilter('deleted_at', null);
    if (before != null) {
      query = query.lt('created_at', before.toUtc().toIso8601String());
    }

    final response = await query
        .order('created_at', ascending: false)
        .order('id', ascending: false)
        .limit(limit);
    return (response as List<dynamic>)
        .map(
          (row) =>
              MessageRecord.fromJson(Map<String, dynamic>.from(row as Map)),
        )
        .toList(growable: false);
  }

  Future<MessageRecord> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final userId = _client.auth.currentUser?.id;
    final trimmedContent = content.trim();
    if (userId == null) throw StateError('Authentication is required.');
    if (trimmedContent.isEmpty) throw ArgumentError('Message is empty.');

    final response = await _client
        .from('messages')
        .insert({
          'conversation_id': conversationId,
          'sender_id': userId,
          'content': trimmedContent,
        })
        .select(_messageProjection)
        .single();
    return MessageRecord.fromJson(Map<String, dynamic>.from(response));
  }

  Future<void> markConversationRead(String conversationId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw StateError('Authentication is required.');
    await _client
        .from('conversation_members')
        .update({'last_read_at': DateTime.now().toUtc().toIso8601String()})
        .match({'conversation_id': conversationId, 'user_id': userId});
  }
}
