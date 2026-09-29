part of 'create_post_screen.dart';

class _AnnouncementBanner extends StatelessWidget {
  final bool isArabic;
  const _AnnouncementBanner({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF59E0B).withValues(alpha: 0.15),
            const Color(0xFFF97316).withValues(alpha: 0.05),
          ],
        ),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFF59E0B), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.megaphone, color: Color(0xFFF59E0B), size: 16),
          const SizedBox(width: 8),
          Text(
            isArabic ? 'أنت تنشر إعلاناً رسمياً' : 'Posting as Announcement',
            style: GoogleFonts.outfit(
              color: const Color(0xFFF59E0B),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1, end: 0);
  }
}

// ─── Author Header ────────────────────────────────────────────────────────────
class _AuthorHeader extends StatelessWidget {
  final AuthState authState;
  final bool canPostAsCollege;
  final bool postAsCollege;
  final bool isDark;
  final bool isArabic;
  final VoidCallback onToggleCollege;

  const _AuthorHeader({
    required this.authState,
    required this.canPostAsCollege,
    required this.postAsCollege,
    required this.isDark,
    required this.isArabic,
    required this.onToggleCollege,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: authState.profile?.avatarUrl != null
              ? NetworkImage(authState.profile!.avatarUrl!)
              : null,
          backgroundColor: _kPrimary.withValues(alpha: 0.1),
          child: authState.profile?.avatarUrl == null
              ? Icon(LucideIcons.user, color: _kPrimary, size: 22)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authState.profile?.fullName ?? 'User',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: isDark ? Colors.white : _kBg,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                children: [
                  _BadgeChip(
                    icon: LucideIcons.globe,
                    label: isArabic ? 'عام' : 'Public',
                    isDark: isDark,
                    color: _kPrimary,
                  ),
                  if (canPostAsCollege)
                    GestureDetector(
                      onTap: onToggleCollege,
                      child: _BadgeChip(
                        icon: LucideIcons.building,
                        label: isArabic ? 'باسم الكلية' : 'As College',
                        isDark: isDark,
                        color: postAsCollege
                            ? _kPrimary
                            : (isDark
                                  ? Colors.white.withValues(alpha: 0.54)
                                  : Colors.black.withValues(alpha: 0.45)),
                        isActive: postAsCollege,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Color color;
  final bool isActive;

  const _BadgeChip({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.color,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? _kPrimary.withValues(alpha: 0.12)
            : (isDark
                  ? Colors.white.withValues(alpha: 0.10)
                  : Colors.black.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(8),
        border: isActive
            ? Border.all(color: _kPrimary.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Mentions Row ─────────────────────────────────────────────────────────────
