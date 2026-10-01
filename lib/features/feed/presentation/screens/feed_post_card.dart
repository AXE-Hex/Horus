part of 'feed_screen.dart';

class _PostCard extends ConsumerStatefulWidget {
  final PostModel post;
  const _PostCard({required this.post});

  @override
  ConsumerState<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<_PostCard> {
  bool _isLiking = false;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final authState = ref.watch(authControllerProvider);
    final isAuthor = authState.user?.id == widget.post.authorId;
    final isCollegePost = widget.post.collegeId != null;
    final isAnnouncement = widget.post.type == PostType.announcement;

    final senderName = isCollegePost
        ? (isArabic ? widget.post.collegeNameAr : widget.post.collegeNameEn) ??
              'College'
        : widget.post.authorName ?? 'Unknown';

    final subLabel = widget.post.departmentId != null
        ? (isArabic
              ? widget.post.departmentNameAr
              : widget.post.departmentNameEn)
        : null;

    final content = widget.post.content;
    final isLong = content.length > 280;
    final displayContent = (!_expanded && isLong)
        ? '${content.substring(0, 280)}…'
        : content;

    String? extractedLink = widget.post.linkUrl;
    if (extractedLink == null) {
      final urlRegExp = RegExp(
        r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,})',
      );
      final match = urlRegExp.firstMatch(content);
      if (match != null) {
        extractedLink = content.substring(match.start, match.end);
        if (!extractedLink.startsWith('http')) {
          extractedLink = 'https://$extractedLink';
        }
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      decoration: BoxDecoration(
        color: isDark ? _kSurface : AppColors.warmWhite,
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : _kBorderLight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.10 : 0.035),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Announcement Banner ──────────────────────────────────────────
          if (isAnnouncement)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _kGold.withValues(alpha: 0.15),
                    _kGold.withValues(alpha: 0.05),
                  ],
                ),
                border: Border(
                  bottom: BorderSide(color: _kGold.withValues(alpha: 0.25)),
                ),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.megaphone, color: _kGold, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    t.home.post_announcement,
                    style: TextStyle(
                      color: _kGold,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

          // ── Author Header ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AvatarWidget(
                  avatarUrl: widget.post.authorAvatarUrl,
                  name: senderName,
                  radius: 22,
                  isDark: isDark,
                  isOrg: isCollegePost,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              senderName,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF0F172A),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (isCollegePost ||
                              widget.post.authorRole == UserRole.professor ||
                              widget.post.authorRole == UserRole.rector)
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: _kPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          if (subLabel != null) ...[
                            _RoleChip(
                              label: subLabel,
                              color: _kPrimary,
                              isDark: isDark,
                            ),
                            const SizedBox(width: 6),
                          ] else if (widget.post.authorRole != null) ...[
                            _RoleChip(
                              label: _roleLabel(
                                widget.post.authorRole!,
                                isArabic,
                              ),
                              color: _roleColor(widget.post.authorRole!),
                              isDark: isDark,
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            timeago.format(widget.post.createdAt),
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.38)
                                  : Colors.black.withValues(alpha: 0.38),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isAuthor)
                  _OptionsMenu(
                    post: widget.post,
                    isDark: isDark,
                    isArabic: isArabic,
                  ),
              ],
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────
          if (content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayContent,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.55,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.87)
                          : const Color(0xFF1E293B),
                    ),
                  ),
                  if (isLong) ...[
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => setState(() => _expanded = !_expanded),
                      child: Text(
                        _expanded
                            ? (isArabic ? 'عرض أقل' : 'Show less')
                            : (isArabic ? 'عرض المزيد' : 'See more'),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _kPrimary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

          // ── Link Preview ─────────────────────────────────────────────────
          if (extractedLink != null && widget.post.mediaUrls.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: LinkPreviewWidget(url: extractedLink),
            ),

          // ── Media ────────────────────────────────────────────────────────
          if (widget.post.mediaUrls.isNotEmpty)
            ClipRRect(
              child: MediaGrid(
                mediaUrls: widget.post.mediaUrls,
                borderRadius: 0,
              ),
            ),

          // ── Stats Bar ────────────────────────────────────────────────────
          if (widget.post.likesCount > 0 || widget.post.commentsCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  if (widget.post.likesCount > 0)
                    Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: _kDanger,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.post.likesCount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.38)
                                : Colors.black.withValues(alpha: 0.38),
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  if (widget.post.commentsCount > 0)
                    Text(
                      '${widget.post.commentsCount} ${isArabic ? 'تعليق' : 'comments'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.38)
                            : Colors.black.withValues(alpha: 0.38),
                      ),
                    ),
                ],
              ),
            ),

          // ── Divider ──────────────────────────────────────────────────────
          Divider(
            height: 1,
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : _kBorderLight,
          ),

          // ── Action Buttons ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: widget.post.isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    label: isArabic ? 'إعجاب' : 'Like',
                    color: widget.post.isLiked ? _kDanger : null,
                    isDark: isDark,
                    onTap: _handleLike,
                    isLoading: _isLiking,
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    icon: LucideIcons.messageSquare,
                    label: isArabic ? 'تعليق' : 'Comment',
                    isDark: isDark,
                    onTap: _showComments,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleLike() async {
    if (_isLiking) return;
    HapticFeedback.lightImpact();
    setState(() => _isLiking = true);
    await ref.read(feedProvider.notifier).toggleLike(widget.post.id);
    if (mounted) setState(() => _isLiking = false);
  }

  void _showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) => _CommentSheet(post: widget.post),
    );
  }

  String _roleLabel(UserRole role, bool isArabic) {
    switch (role) {
      case UserRole.rector:
        return isArabic ? 'رئيس الجامعة' : 'Rector';
      case UserRole.dean:
        return isArabic ? 'العميد' : 'Dean';
      case UserRole.professor:
        return isArabic ? 'أستاذ' : 'Professor';
      case UserRole.teachingAssistant:
        return isArabic ? 'معيد' : 'TA';
      default:
        return isArabic ? 'طالب' : 'Student';
    }
  }

  Color _roleColor(UserRole role) {
    switch (role) {
      case UserRole.rector:
        return _kGold;
      case UserRole.dean:
        return const Color(0xFFF97316);
      case UserRole.professor:
        return _kPrimary;
      case UserRole.teachingAssistant:
        return const Color(0xFF10B981);
      default:
        return Colors.grey;
    }
  }
}

// ─── Action Button ────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final bool isDark;
  final VoidCallback onTap;
  final bool isLoading;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.onTap,
    this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final c =
        color ??
        (isDark
            ? Colors.white.withValues(alpha: 0.54)
            : Colors.black.withValues(alpha: 0.45));
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 1.5, color: c),
              )
            else
              Icon(icon, size: 18, color: c),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: c,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Role Chip ────────────────────────────────────────────────────────────────
class _RoleChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;
  const _RoleChip({
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ─── Options Menu ─────────────────────────────────────────────────────────────
