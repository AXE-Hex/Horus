// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/academic/data/models/professor_profile_models.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class ProfessorChatScreen extends ConsumerStatefulWidget {
  final ProfessorProfile profile;

  const ProfessorChatScreen({super.key, required this.profile});

  @override
  ConsumerState<ProfessorChatScreen> createState() =>
      _ProfessorChatScreenState();
}

class _ChatMessage {
  final String senderName;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  _ChatMessage(this.senderName, this.text, this.timestamp, this.isMe);
}

class _ProfessorChatScreenState extends ConsumerState<ProfessorChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late List<_ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = [
      _ChatMessage(
        'System',
        'Chat initialized with Team TAs.',
        DateTime.now().subtract(const Duration(days: 1)),
        false,
      ),
      _ChatMessage(
        'Eng. Pam Beesly',
        'Prof, the midterm grades are all uploaded.',
        DateTime.now().subtract(const Duration(hours: 2)),
        false,
      ),
      _ChatMessage(
        'Eng. Ryan Howard',
        'I also finished checking the absent students list for Lab B.',
        DateTime.now().subtract(const Duration(minutes: 45)),
        false,
      ),
    ];
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    HapticFeedback.lightImpact();
    setState(() {
      _messages.add(
        _ChatMessage(widget.profile.name, text, DateTime.now(), true),
      );
    });

    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Mock reply
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        HapticFeedback.mediumImpact();
        setState(() {
          _messages.add(
            _ChatMessage(
              'Eng. Pam Beesly',
              'Noted, Professor.',
              DateTime.now(),
              false,
            ),
          );
        });
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final color = Colors.teal;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return isGlass
        ? GlassScaffold(
            appBar: _buildAppBar(isGlass, color, isArabic),
            body: _buildChatBody(isGlass, color, isArabic),
          )
        : Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: _buildAppBar(isGlass, color, isArabic),
            body: _buildChatBody(isGlass, color, isArabic),
          );
  }

  AppBar _buildAppBar(bool isGlass, Color color, bool isArabic) {
    return AppBar(
      backgroundColor: isGlass ? Colors.black.withValues(alpha: 0.2) : color,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white24,
            child: const Icon(LucideIcons.users, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'فريق المعيدين' : 'TA Team Chat',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${widget.profile.teachingAssistants.length} ${isArabic ? "أعضاء" : "Members"}',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.info, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildChatBody(bool isGlass, Color color, bool isArabic) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return _buildMessageBubble(msg, isGlass, color);
            },
          ),
        ),
        _buildInputArea(isGlass, color, isArabic),
      ],
    );
  }

  Widget _buildMessageBubble(_ChatMessage msg, bool isGlass, Color color) {
    final isSystem = msg.senderName == 'System';

    if (isSystem) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            msg.text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isGlass ? Colors.white70 : Colors.black54,
            ),
          ),
        ),
      );
    }

    final alignment = msg.isMe
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final bubbleColor = msg.isMe
        ? color
        : (isGlass
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2));
    final textColor = msg.isMe
        ? Colors.white
        : (isGlass ? Colors.white : Colors.black87);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          if (!msg.isMe)
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: Text(
                msg.senderName,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: isGlass ? Colors.white60 : Colors.grey,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(16).copyWith(
                bottomRight: msg.isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(16),
                bottomLeft: !msg.isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(16),
              ),
            ),
            child: Text(
              msg.text,
              style: GoogleFonts.inter(color: textColor, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
            child: Text(
              DateFormat('hh:mm a').format(msg.timestamp),
              style: GoogleFonts.inter(
                fontSize: 10,
                color: isGlass ? Colors.white30 : Colors.grey,
              ),
            ),
          ),
        ],
      ).animate().fadeIn().slideY(begin: 0.2, end: 0, duration: 200.ms),
    );
  }

  Widget _buildInputArea(bool isGlass, Color color, bool isArabic) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    );

    return Container(
      padding: const EdgeInsets.all(
        16,
      ).copyWith(bottom: 16 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: isGlass
            ? Colors.black.withValues(alpha: 0.2)
            : Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: isGlass
                ? Colors.white12
                : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              LucideIcons.paperclip,
              color: isGlass ? Colors.white54 : Colors.grey,
            ),
            onPressed: () => HapticFeedback.selectionClick(),
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: GoogleFonts.inter(
                color: isGlass ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: isArabic ? 'اكتب رسالة...' : 'Type a message...',
                hintStyle: GoogleFonts.inter(
                  color: isGlass ? Colors.white54 : Colors.grey,
                ),
                filled: true,
                fillColor: isGlass
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.1),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: color,
            child: IconButton(
              icon: const Icon(LucideIcons.send, color: Colors.white, size: 18),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
