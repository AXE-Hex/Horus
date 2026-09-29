part of 'create_post_screen.dart';

class _Toolbar extends StatelessWidget {
  final bool isDark;
  final bool isArabic;
  final PostType currentType;
  final int selectedCount;
  final VoidCallback onPickImage;
  final VoidCallback onPickVideo;
  final VoidCallback onToggleLink;
  final VoidCallback onToggleAnnouncement;

  const _Toolbar({
    required this.isDark,
    required this.isArabic,
    required this.currentType,
    required this.selectedCount,
    required this.onPickImage,
    required this.onPickVideo,
    required this.onToggleLink,
    required this.onToggleAnnouncement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom > 0
            ? MediaQuery.of(context).viewInsets.bottom
            : MediaQuery.of(context).padding.bottom,
        left: 12,
        right: 12,
        top: 10,
      ),
      decoration: BoxDecoration(
        color: isDark ? _kSurface : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.10)
                : _kBorderLight,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            isArabic ? 'أضف للمنشور:' : 'Add to post:',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.38)
                  : Colors.black.withValues(alpha: 0.38),
            ),
          ),
          const SizedBox(width: 4),
          _ToolBtn(
            icon: LucideIcons.image,
            color: const Color(0xFF10B981),
            onTap: onPickImage,
            badge: selectedCount > 0 ? '$selectedCount' : null,
          ),
          _ToolBtn(
            icon: LucideIcons.video,
            color: const Color(0xFFEF4444),
            onTap: onPickVideo,
          ),
          _ToolBtn(
            icon: LucideIcons.link,
            color: const Color(0xFF3B82F6),
            onTap: onToggleLink,
            isActive: currentType == PostType.link,
          ),
          _ToolBtn(
            icon: LucideIcons.megaphone,
            color: const Color(0xFFF59E0B),
            onTap: onToggleAnnouncement,
            isActive: currentType == PostType.announcement,
          ),
          const Spacer(),
          Text(
            '${t.extracted.whats_on_your_mind}'.length > 0 ? '' : '',
            style: const TextStyle(fontSize: 0),
          ),
        ],
      ),
    );
  }
}

class _ToolBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? badge;
  final bool isActive;

  const _ToolBtn({
    required this.icon,
    required this.color,
    required this.onTap,
    this.badge,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              size: 22,
              color: isActive ? color : color.withValues(alpha: 0.6),
            ),
            style: isActive
                ? IconButton.styleFrom(
                    backgroundColor: color.withValues(alpha: 0.12),
                  )
                : null,
          ),
          if (badge != null)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
