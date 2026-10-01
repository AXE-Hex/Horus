import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_colors.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/features/messaging/data/repositories/conversation_repository.dart';
import 'package:horus/features/messaging/presentation/providers/conversation_provider.dart';
import 'package:horus/features/messaging/presentation/screens/conversation_thread_screen.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:intl/intl.dart';

class ConversationListScreen extends ConsumerStatefulWidget {
  const ConversationListScreen({super.key});

  @override
  ConsumerState<ConversationListScreen> createState() =>
      _ConversationListScreenState();
}

class _ConversationListScreenState
    extends ConsumerState<ConversationListScreen> {
  ConversationRecord? _selected;
  final List<ConversationRecord> _additional = [];
  bool _hasMore = true;
  bool _loadingMore = false;

  Future<void> _loadMore(int currentPageLength) async {
    if (_loadingMore || !_hasMore) return;
    setState(() => _loadingMore = true);
    try {
      final page = await ref
          .read(conversationRepositoryProvider)
          .getConversations(offset: currentPageLength + _additional.length);
      if (!mounted) return;
      setState(() {
        _additional.addAll(page);
        _hasMore = page.length == 30;
      });
    } catch (_) {
      if (mounted) _showError();
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(t.shared.error)));
  }

  @override
  Widget build(BuildContext context) {
    final conversations = ref.watch(conversationsProvider);
    final currentUserId = ref.watch(authControllerProvider).user?.id;
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;
        return Scaffold(
          appBar: AppBar(
            title: Text(t.messaging.title),
            actions: [
              IconButton(
                tooltip: t.messaging.refresh,
                onPressed: () {
                  _additional.clear();
                  _selected = null;
                  _hasMore = true;
                  ref.invalidate(conversationsProvider);
                },
                icon: const Icon(Icons.refresh_rounded),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
          ),
          body: conversations.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => _ConversationError(onRetry: _refresh),
            data: (firstPage) {
              final all = [...firstPage, ..._additional];
              final selected = all.where((item) => item.id == _selected?.id);
              final active = selected.isNotEmpty
                  ? selected.first
                  : (wide && all.isNotEmpty ? all.first : null);

              if (!wide) {
                return _ConversationListPanel(
                  conversations: all,
                  currentUserId: currentUserId,
                  hasMore: _hasMore && firstPage.length == 30,
                  isLoadingMore: _loadingMore,
                  onLoadMore: () => _loadMore(firstPage.length),
                  onSelect: (conversation) =>
                      context.push('/conversations/${conversation.id}'),
                );
              }

              return Row(
                children: [
                  SizedBox(
                    width: 352,
                    child: _ConversationListPanel(
                      conversations: all,
                      currentUserId: currentUserId,
                      selectedId: active?.id,
                      hasMore: _hasMore && firstPage.length == 30,
                      isLoadingMore: _loadingMore,
                      onLoadMore: () => _loadMore(firstPage.length),
                      onSelect: (conversation) =>
                          setState(() => _selected = conversation),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: active == null
                        ? const _ConversationPlaceholder()
                        : ConversationThreadView(
                            key: ValueKey(active.id),
                            conversation: active,
                            embedded: true,
                          ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _refresh() {
    _additional.clear();
    _selected = null;
    _hasMore = true;
    ref.invalidate(conversationsProvider);
  }
}

class _ConversationListPanel extends StatelessWidget {
  const _ConversationListPanel({
    required this.conversations,
    required this.currentUserId,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onSelect,
    this.selectedId,
  });

  final List<ConversationRecord> conversations;
  final String? currentUserId;
  final String? selectedId;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final ValueChanged<ConversationRecord> onSelect;

  @override
  Widget build(BuildContext context) {
    if (conversations.isEmpty) return const _ConversationPlaceholder();
    final showLoadMore = hasMore;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: conversations.length + (showLoadMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == conversations.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: isLoadingMore
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: onLoadMore,
                      child: Text(t.messaging.load_more),
                    ),
            ),
          );
        }
        final conversation = conversations[index];
        return _ConversationTile(
          conversation: conversation,
          currentUserId: currentUserId,
          selected: selectedId == conversation.id,
          onTap: () => onSelect(conversation),
        );
      },
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.conversation,
    required this.currentUserId,
    required this.selected,
    required this.onTap,
  });

  final ConversationRecord conversation;
  final String? currentUserId;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final members = conversation.members;
    final currentMember = members.where(
      (member) => member.userId == currentUserId,
    );
    final lastReadAt = currentMember.isEmpty
        ? null
        : currentMember.first.lastReadAt;
    final unread =
        lastReadAt != null &&
        conversation.lastMessageAt?.isAfter(lastReadAt) == true;
    final otherMember = members.where(
      (member) => member.userId != currentUserId,
    );
    final otherProfile = otherMember.isEmpty ? null : otherMember.first.profile;
    final title = conversation.isGroup
        ? (conversation.title ?? t.academic.groups)
        : (otherProfile?.fullName ?? t.extracted.user);
    final avatarUrl = conversation.isGroup ? null : otherProfile?.avatarUrl;

    return ListTile(
      selected: selected,
      selectedTileColor: theme.colorScheme.primary.withValues(alpha: 0.08),
      onTap: onTap,
      minVerticalPadding: 12,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: AppColors.navy600,
        backgroundImage: avatarUrl == null || avatarUrl.isEmpty
            ? null
            : NetworkImage(avatarUrl),
        child: avatarUrl == null || avatarUrl.isEmpty
            ? Icon(
                conversation.isGroup ? Icons.groups_rounded : Icons.person,
                color: AppColors.white,
                size: conversation.isGroup ? 22 : 18,
                semanticLabel: title,
              )
            : null,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: unread ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
          if (conversation.lastMessageAt != null)
            Text(
              DateFormat.jm(
                Localizations.localeOf(context).toString(),
              ).format(conversation.lastMessageAt!.toLocal()),
              style: theme.textTheme.labelSmall,
            ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                conversation.lastMessage ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ),
            if (unread)
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: AppColors.gold500,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ConversationPlaceholder extends StatelessWidget {
  const _ConversationPlaceholder();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xxxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.forum_outlined,
            size: 42,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(t.messaging.no_conversations, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

class _ConversationError extends StatelessWidget {
  const _ConversationError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(t.shared.error),
        const SizedBox(height: AppSpacing.md),
        OutlinedButton(onPressed: onRetry, child: Text(t.shared.retry)),
      ],
    ),
  );
}
