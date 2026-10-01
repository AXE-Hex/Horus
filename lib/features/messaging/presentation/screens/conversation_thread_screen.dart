import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_colors.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/features/messaging/data/repositories/conversation_repository.dart';
import 'package:horus/features/messaging/presentation/providers/conversation_provider.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:intl/intl.dart';

class ConversationThreadScreen extends ConsumerWidget {
  const ConversationThreadScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversation = ref.watch(conversationProvider(conversationId));
    return conversation.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Center(child: Text(t.shared.error)),
      ),
      data: (record) {
        if (record == null) {
          return Scaffold(
            appBar: AppBar(leading: const BackButton()),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  t.messaging.unavailable,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () => context.pop()),
            title: _ConversationTitle(conversation: record),
            actions: [
              IconButton(
                tooltip: t.messaging.refresh,
                onPressed: () => ref.invalidate(messagesProvider(record.id)),
                icon: const Icon(Icons.refresh_rounded),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
          ),
          body: ConversationThreadView(conversation: record),
        );
      },
    );
  }
}

class ConversationThreadView extends ConsumerStatefulWidget {
  const ConversationThreadView({
    super.key,
    required this.conversation,
    this.embedded = false,
  });

  final ConversationRecord conversation;
  final bool embedded;

  @override
  ConsumerState<ConversationThreadView> createState() =>
      _ConversationThreadViewState();
}

class _ConversationThreadViewState
    extends ConsumerState<ConversationThreadView> {
  final _messageController = TextEditingController();
  final _messageFocus = FocusNode();
  final List<MessageRecord> _olderMessages = [];
  bool _sending = false;
  bool _loadingOlder = false;
  bool _hasOlder = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _markRead());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocus.dispose();
    super.dispose();
  }

  Future<void> _markRead() async {
    if (ref.read(authControllerProvider).user == null) return;
    try {
      await ref
          .read(conversationRepositoryProvider)
          .markConversationRead(widget.conversation.id);
      ref.invalidate(conversationsProvider);
    } catch (_) {
      if (mounted) _showMessage(t.shared.error);
    }
  }

  Future<void> _send() async {
    final content = _messageController.text.trim();
    if (content.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      await ref
          .read(conversationRepositoryProvider)
          .sendMessage(
            conversationId: widget.conversation.id,
            content: content,
          );
      _messageController.clear();
      HapticFeedback.selectionClick();
      ref.invalidate(messagesProvider(widget.conversation.id));
      ref.invalidate(conversationsProvider);
    } catch (_) {
      _showMessage(t.messaging.send_failed);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _loadOlder(List<MessageRecord> loadedMessages) async {
    if (_loadingOlder || !_hasOlder || loadedMessages.isEmpty) return;
    setState(() => _loadingOlder = true);
    try {
      final page = await ref
          .read(conversationRepositoryProvider)
          .getMessages(
            widget.conversation.id,
            before: loadedMessages.last.createdAt,
          );
      if (!mounted) return;
      setState(() {
        _olderMessages.addAll(
          page.where(
            (message) =>
                !_olderMessages.any((existing) => existing.id == message.id),
          ),
        );
        _hasOlder = page.length == 50;
      });
    } catch (_) {
      if (mounted) _showMessage(t.shared.error);
    } finally {
      if (mounted) setState(() => _loadingOlder = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider(widget.conversation.id));
    final currentUserId = ref.watch(authControllerProvider).user?.id;
    final theme = Theme.of(context);

    return Column(
      children: [
        if (widget.embedded)
          Material(
            color: theme.colorScheme.surface,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _ConversationTitle(
                      conversation: widget.conversation,
                    ),
                  ),
                  IconButton(
                    tooltip: t.messaging.refresh,
                    onPressed: () => ref.invalidate(
                      messagesProvider(widget.conversation.id),
                    ),
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                ],
              ),
            ),
          ),
        Expanded(
          child: messagesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => _MessageLoadError(
              onRetry: () =>
                  ref.invalidate(messagesProvider(widget.conversation.id)),
            ),
            data: (latest) {
              if (latest.isEmpty && _olderMessages.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Text(
                      t.messaging.no_messages,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              final messages = [...latest, ..._olderMessages];
              final showOlderControl = _hasOlder && latest.length == 50;
              return RefreshIndicator(
                onRefresh: () async =>
                    ref.invalidate(messagesProvider(widget.conversation.id)),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  itemCount: messages.length + (showOlderControl ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: _loadingOlder
                              ? null
                              : () => _loadOlder(messages),
                          child: _loadingOlder
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(t.messaging.load_older),
                        ),
                      );
                    }
                    return _MessageBubble(
                      message: messages[index],
                      currentUserId: currentUserId,
                      isGroup: widget.conversation.isGroup,
                    );
                  },
                ),
              );
            },
          ),
        ),
        _MessageComposer(
          controller: _messageController,
          focusNode: _messageFocus,
          isSending: _sending,
          onSend: _send,
        ),
      ],
    );
  }
}

class _ConversationTitle extends ConsumerWidget {
  const _ConversationTitle({required this.conversation});

  final ConversationRecord conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authControllerProvider).user?.id;
    final otherMember = conversation.members.where(
      (member) => member.userId != userId,
    );
    final profile = otherMember.isEmpty ? null : otherMember.first.profile;
    final title = conversation.isGroup
        ? (conversation.title ?? t.academic.groups)
        : (profile?.fullName ?? t.extracted.user);
    return Text(title, maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.currentUserId,
    required this.isGroup,
  });

  final MessageRecord message;
  final String? currentUserId;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final own = message.senderId == currentUserId;
    final background = own
        ? (theme.brightness == Brightness.dark
              ? AppColors.navy600
              : AppColors.navy700)
        : theme.colorScheme.surface;
    final foreground = own ? AppColors.white : theme.colorScheme.onSurface;
    final alignment = own
        ? AlignmentDirectional.centerEnd
        : AlignmentDirectional.centerStart;

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.fromLTRB(14, 10, 12, 7),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadiusDirectional.only(
              topStart: const Radius.circular(16),
              topEnd: const Radius.circular(16),
              bottomStart: Radius.circular(own ? 16 : 4),
              bottomEnd: Radius.circular(own ? 4 : 16),
            ),
            border: own
                ? null
                : Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isGroup && !own && message.sender?.fullName != null) ...[
                Text(
                  message.sender!.fullName,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
              ],
              Text(
                message.content,
                style: theme.textTheme.bodyMedium?.copyWith(color: foreground),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  DateFormat.Hm(
                    Localizations.localeOf(context).toString(),
                  ).format(message.createdAt.toLocal()),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: foreground.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageComposer extends StatelessWidget {
  const _MessageComposer({
    required this.controller,
    required this.focusNode,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Material(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                minLines: 1,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: t.messaging.message_hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton.filled(
              tooltip: t.academic.send_message,
              onPressed: isSending ? null : onSend,
              icon: isSending
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    ),
  );
}

class _MessageLoadError extends StatelessWidget {
  const _MessageLoadError({required this.onRetry});

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
