part of 'digital_id_screen.dart';

class _BackCard extends StatelessWidget {
  final Map<String, dynamic> studentData;
  final Offset tilt;

  const _BackCard({required this.studentData, required this.tilt});

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final theme = DigitalIDThemeRepository.getTheme(
      collegeId: studentData['college']?.toString() ?? '',
      specializationId: studentData['specialization']?.toString(),
    );

    return Container(
      height: 290,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 40,
            offset: Offset(tilt.dx * 50, tilt.dy * 50),
          ),
        ],
      ),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(32),
        blur: 40,
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            const Color(0xFF0F172A),
            theme.primaryColor.withValues(alpha: 0.5),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQR(theme),
                  const SizedBox(height: 24),
                  Text(
                    t.students.scan_for_secure_access,
                    style:
                        (isArabic
                                ? GoogleFonts.tajawal()
                                : GoogleFonts.outfit())
                            .copyWith(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    LucideIcons.shieldCheck,
                    color: Colors.white24,
                    size: 20,
                  ),
                  Text(
                    'ENCRYPTED VERIFICATION SYSTEM',
                    style: GoogleFonts.outfit(
                      color: Colors.white10,
                      fontSize: 8,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQR(DigitalIDTheme theme) {
    return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.secondaryColor.withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(LucideIcons.qrCode, color: Colors.black, size: 120),
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: 3.seconds,
          color: theme.secondaryColor.withValues(alpha: 0.2),
        );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
