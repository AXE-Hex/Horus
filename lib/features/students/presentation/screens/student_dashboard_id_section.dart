part of 'student_dashboard_screen.dart';

extension _StudentDashboardIdSection on DashboardScreen {
  Widget _buildDigitalIDCard(
    BuildContext context,
    bool isArabic,
    AuthState auth,
  ) {
    final theme = DigitalIDThemeRepository.getTheme(
      collegeId: 'ai',
      specializationId: 'artificial_cybersecurity',
    );

    return GestureDetector(
      onTap: () {
        context.push(
          '/digital-id',
          extra: {
            'name': auth.profile?.fullName ?? t.students.student,
            'id': auth.user?.id ?? '',
            'college': 'ai',
            'specialization': 'artificial_cybersecurity',
            'gpa': '—',
            'level': '—',
          },
        );
      },
      child: Hero(
        tag: 'digital_id_card',
        child: GlassContainer(
          height: 260,
          borderRadius: BorderRadius.circular(32),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.graduationCap,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        t.students.horus_university,
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      theme.patternIcon,
                      color: theme.secondaryColor,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [theme.primaryColor, theme.secondaryColor],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.primaryColor.withValues(alpha: 0.5),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 38,
                      backgroundColor: Color(0xFF0F172A),
                      child: Icon(
                        LucideIcons.user,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.profile?.fullName ?? t.students.student,
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: theme.secondaryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.secondaryColor.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          child: Text(
                            t.students.artificial_intelligence,
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: theme.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCardStat(
                    'ID',
                    auth.user?.email?.split('@').first ?? '—',
                  ),
                  _buildCardStat('GPA', '—'),
                  _buildCardStat('TERM', '—'),
                  _buildCardStat('EXPIRY', '—'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.4),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return DashboardSectionHeader(title: title);
  }
}
