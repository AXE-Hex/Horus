part of 'professor_dashboard_screen.dart';

class _BentoStatsGrid extends StatelessWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _BentoStatsGrid({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final totalStudents = profile.groups.fold<int>(
      0,
      (sum, g) => sum + g.studentCount,
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _BentoCard(
                title: t.academic.total_students,
                value: totalStudents.toString(),
                icon: LucideIcons.users,
                color: const Color(0xFF6366F1),
                subtitle: t.academic.across_all_groups,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _BentoCard(
                title: t.academic.rating,
                value: profile.generalRating.toString(),
                icon: LucideIcons.star,
                color: Colors.amber,
                isSmall: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _BentoCard(
                title: t.academic.tas,
                value: profile.teachingAssistants.length.toString(),
                icon: LucideIcons.graduationCap,
                color: const Color(0xFF10B981),
                isSmall: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: _BentoCard(
                title: t.academic.office_hours,
                value: profile.officeHours.length.toString(),
                icon: LucideIcons.clock,
                color: const Color(0xFFEC4899),
                subtitle: t.academic.sessions_this_week,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}

class _BentoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final bool isSmall;

  const _BentoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(20),
      border: Border.all(color: color.withValues(alpha: 0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.shareTechMono(
              fontSize: isSmall ? 28 : 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: GoogleFonts.outfit(fontSize: 10, color: Colors.white38),
            ),
          ],
        ],
      ),
    );
  }
}

class _GroupsBentoList extends StatelessWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _GroupsBentoList({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: profile.groups.map((group) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      group.name.substring(0, 1),
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${group.studentCount} ${t.academic.students}',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isArabic ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
                  color: Colors.white24,
                  size: 20,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }
}
