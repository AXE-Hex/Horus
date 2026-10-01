import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/messaging/data/repositories/conversation_repository.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';

final conversationsProvider =
    FutureProvider.autoDispose<List<ConversationRecord>>(
      (ref) => ref.watch(conversationRepositoryProvider).getConversations(),
    );

final conversationProvider = FutureProvider.autoDispose
    .family<ConversationRecord?, String>(
      (ref, id) =>
          ref.watch(conversationRepositoryProvider).getConversation(id),
    );

final messagesProvider = FutureProvider.autoDispose
    .family<List<MessageRecord>, String>(
      (ref, id) => ref.watch(conversationRepositoryProvider).getMessages(id),
    );
