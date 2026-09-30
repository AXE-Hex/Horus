part of 'professor_profile_screen.dart';

extension _ProfessorProfileHeader on ProfessorProfileScreen {
  Widget _buildGlassSliverAppBar(
    BuildContext context,
    bool isGlass,
    Color color,
  ) {
    return GlassSliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: isGlass ? Colors.transparent : color,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(LucideIcons.chevronLeft, color: Colors.white),
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color, color.withValues(alpha: 0.6)],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'staff_${profile.name}',
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white24,
                      child: const Icon(
                        LucideIcons.user,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${profile.role} • ${profile.department}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildMiniTag(
                        LucideIcons.star,
                        '${profile.generalRating}',
                        Colors.amber,
                      ),
                      const SizedBox(width: 8),
                      _buildMiniTag(
                        LucideIcons.mapPin,
                        profile.officeSymbol,
                        Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniTag(IconData icon, String text, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildActionBtn(
            context,
            t.professor.message,
            LucideIcons.messageSquare,
            isGlass,
            color,
            isArabic,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionBtn(
            context,
            t.professor.stats.office_hours,
            LucideIcons.calendarClock,
            isGlass,
            Colors.teal,
            isArabic,
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildActionBtn(
    BuildContext context,
    String title,
    IconData icon,
    bool isGlass,
    Color baseColor,
    bool isArabic,
  ) {
    final block = Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isGlass ? null : baseColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: isGlass ? Colors.white : baseColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isGlass ? Colors.white : baseColor,
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${t.academic.clicked} $title'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: isGlass
          ? GlassContainer(padding: EdgeInsets.zero, child: block)
          : block,
    );
  }
}
