part of 'feed_screen.dart';

class _CommentItem extends StatelessWidget {
  final CommentModel comment;
  final bool isDark;
  const _CommentItem({required this.comment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AvatarWidget(
          avatarUrl: comment.authorAvatarUrl,
          name: comment.authorName,
          radius: 16,
          isDark: isDark,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : const Color(0xFFF1F5F9),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.authorName ?? 'User',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: isDark ? Colors.white : _kBg,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.content,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        height: 1.4,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.70)
                            : const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  timeago.format(comment.createdAt),
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Avatar Widget ────────────────────────────────────────────────────────────
class _AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final String? name;
  final double radius;
  final bool isDark;
  final bool isOrg;

  const _AvatarWidget({
    required this.avatarUrl,
    required this.name,
    required this.radius,
    required this.isDark,
    this.isOrg = false,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name != null && name!.isNotEmpty
        ? name!.trim().split(' ').take(2).map((w) => w[0]).join()
        : '?';

    return CircleAvatar(
      radius: radius,
      backgroundColor: isOrg
          ? _kPrimary.withValues(alpha: 0.15)
          : (isDark
                ? Colors.white.withValues(alpha: 0.08)
                : _kPrimary.withValues(alpha: 0.1)),
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
      child: avatarUrl == null
          ? Text(
              isOrg ? '🏛' : initials,
              style: GoogleFonts.outfit(
                fontSize: radius * 0.7,
                fontWeight: FontWeight.bold,
                color: _kPrimary,
              ),
            )
          : null,
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────
class _EmptyFeedState extends StatelessWidget {
  final bool isArabic;
  final bool isDark;
  const _EmptyFeedState({required this.isArabic, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _kPrimary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.rss, color: _kPrimary, size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            isArabic ? 'لا توجد منشورات' : 'No posts yet',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withValues(alpha: 0.70) : _kBg,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'كن أول من ينشر شيئاً!'
                : 'Be the first to share something!',
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ─── Error State ──────────────────────────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String error;
  final bool isDark;
  const _ErrorState({required this.error, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.wifiOff, color: _kDanger, size: 40),
          const SizedBox(height: 12),
          Text(
            'Something went wrong',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withValues(alpha: 0.70) : _kBg,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            error,
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ─── Skeleton ─────────────────────────────────────────────────────────────────
class _PostSkeleton extends StatefulWidget {
  final bool isDark;
  const _PostSkeleton({required this.isDark});

  @override
  State<_PostSkeleton> createState() => _PostSkeletonState();
}

class _PostSkeletonState extends State<_PostSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = widget.isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.05);

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          color: widget.isDark ? _kSurface : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _Bone(
                    width: 44,
                    height: 44,
                    radius: 22,
                    base: base,
                    opacity: _anim.value,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Bone(
                        width: 140,
                        height: 14,
                        radius: 8,
                        base: base,
                        opacity: _anim.value,
                      ),
                      const SizedBox(height: 6),
                      _Bone(
                        width: 90,
                        height: 10,
                        radius: 6,
                        base: base,
                        opacity: _anim.value,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _Bone(
                width: double.infinity,
                height: 14,
                radius: 8,
                base: base,
                opacity: _anim.value,
              ),
              const SizedBox(height: 6),
              _Bone(
                width: double.infinity,
                height: 14,
                radius: 8,
                base: base,
                opacity: _anim.value,
              ),
              const SizedBox(height: 6),
              _Bone(
                width: 200,
                height: 14,
                radius: 8,
                base: base,
                opacity: _anim.value,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Bone extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color base;
  final double opacity;

  const _Bone({
    required this.width,
    required this.height,
    required this.radius,
    required this.base,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
