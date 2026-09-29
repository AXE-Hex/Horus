part of 'digital_id_screen.dart';

class _FrontCard extends StatelessWidget {
  final Map<String, dynamic> studentData;
  final Offset tilt;

  const _FrontCard({required this.studentData, required this.tilt});

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final seed =
        int.tryParse(
          studentData['id']?.toString().replaceAll(RegExp(r'[^0-9]'), '') ??
              '0',
        ) ??
        0;
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
            color: theme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 50,
            spreadRadius: -10,
            offset: Offset(tilt.dx * 100, tilt.dy * 100),
          ),
        ],
      ),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(32),
        blur: 40,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor.withValues(alpha: 0.4),
            const Color(0xFF0F172A).withValues(alpha: 0.8),
          ],
        ),
        child: Stack(
          children: [
            _buildHolographicSweep(theme, tilt),
            _buildGridPattern(theme, seed),
            _buildContent(theme, isArabic, seed),
          ],
        ),
      ),
    );
  }

  Widget _buildHolographicSweep(DigitalIDTheme theme, Offset tilt) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            begin: Alignment(tilt.dx - 1, tilt.dy - 1),
            end: Alignment(tilt.dx + 1, tilt.dy + 1),
            colors: [
              Colors.transparent,
              Colors.white.withValues(
                alpha: theme.designStyle == DigitalIDDesignStyle.cyber
                    ? 0.15
                    : 0.05,
              ),
              theme.secondaryColor.withValues(alpha: 0.15),
              Colors.white.withValues(
                alpha: theme.designStyle == DigitalIDDesignStyle.cyber
                    ? 0.15
                    : 0.05,
              ),
              Colors.transparent,
            ],
            stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildGridPattern(DigitalIDTheme theme, int seed) {
    if (theme.designStyle == DigitalIDDesignStyle.cyber) {
      return Positioned.fill(
        child: CustomPaint(
          painter: _CircuitPainter(
            theme.secondaryColor.withValues(alpha: 0.1),
            seed: seed,
          ),
        ),
      );
    }

    if (theme.designStyle == DigitalIDDesignStyle.organic) {
      return Positioned.fill(
        child: Opacity(opacity: 0.05, child: _OrganicPattern(seed: seed)),
      );
    }

    return Positioned.fill(
      child: Opacity(
        opacity: 0.05,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: theme.designStyle == DigitalIDDesignStyle.classic
                ? 10
                : 20,
          ),
          itemBuilder: (context, index) {
            final isVisible = (math.Random(seed + index).nextDouble() > 0.2);
            if (!isVisible) return const SizedBox();

            return Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.2),
                shape: theme.designStyle == DigitalIDDesignStyle.elegant
                    ? BoxShape.circle
                    : BoxShape.rectangle,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(DigitalIDTheme theme, bool isArabic, int seed) {
    final collegeTheme = DigitalIDThemeRepository.getTheme(
      collegeId: studentData['college']?.toString() ?? '',
    );

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBrand(isArabic, collegeTheme.name),
              _buildUniqueSignature(theme, seed),
              _buildSecurityChip(theme),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildAvatar(theme),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentData['name'] ?? 'Ahmed Mohamed',
                      style:
                          (isArabic
                                  ? GoogleFonts.tajawal()
                                  : GoogleFonts.outfit())
                              .copyWith(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                                shadows:
                                    theme.designStyle ==
                                        DigitalIDDesignStyle.cyber
                                    ? [
                                        Shadow(
                                          color: theme.primaryColor.withValues(
                                            alpha: 0.5,
                                          ),
                                          blurRadius: 10,
                                        ),
                                      ]
                                    : null,
                              ),
                    ),
                    const SizedBox(height: 8),
                    if (studentData['specialization'] != null)
                      _buildDeptBadge(theme, isArabic),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildInfoBar(isArabic, theme),
        ],
      ),
    );
  }

  Widget _buildUniqueSignature(DigitalIDTheme theme, int seed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(8, (i) {
          final random = math.Random(seed + i);
          return Container(
            width: 2,
            height: random.nextDouble() * 10 + 2,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(
                alpha: 0.5 + random.nextDouble() * 0.5,
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBrand(bool isArabic, String collegeName) {
    return Row(
      children: [
        const Icon(LucideIcons.graduationCap, color: Colors.white, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.students.horus_university_1,
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.cinzel())
                  .copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: isArabic ? 0 : 2,
                  ),
            ),
            Text(
              collegeName.toUpperCase(),
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                  .copyWith(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecurityChip(DigitalIDTheme theme) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        shape: BoxShape.circle,
        border: Border.all(color: theme.secondaryColor.withValues(alpha: 0.3)),
      ),
      child: Icon(theme.patternIcon, color: theme.secondaryColor, size: 20),
    ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds);
  }

  Widget _buildAvatar(DigitalIDTheme theme) {
    return Container(
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
      child: CircleAvatar(
        radius: 40,
        backgroundColor: const Color(0xFF0F172A),
        child: Icon(
          theme.designStyle == DigitalIDDesignStyle.cyber
              ? LucideIcons.userCheck
              : LucideIcons.user,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildDeptBadge(DigitalIDTheme theme, bool isArabic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.secondaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(
          theme.designStyle == DigitalIDDesignStyle.organic ? 20 : 8,
        ),
        border: Border.all(color: theme.secondaryColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        theme.name.toUpperCase(),
        style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
            .copyWith(
              color: theme.secondaryColor,
              fontSize: 8,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  Widget _buildInfoBar(bool isArabic, DigitalIDTheme theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(
          theme.designStyle == DigitalIDDesignStyle.cyber ? 8 : 16,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoItem(
            t.students.id_no,
            studentData['id'] ?? '---',
            isArabic,
            theme: theme,
          ),
          _buildInfoItem(
            t.students.gpa,
            studentData['gpa'] ?? '---',
            isArabic,
            theme: theme,
          ),
          _buildInfoItem(
            t.students.level,
            studentData['level'] ?? '---',
            isArabic,
            theme: theme,
          ),
          _buildInfoItem(
            t.students.status,
            t.students.active,
            isArabic,
            theme: theme,
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    bool isArabic, {
    required DigitalIDTheme theme,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
                color: Colors.white38,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
                color: color ?? Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                shadows: theme.designStyle == DigitalIDDesignStyle.cyber
                    ? [
                        Shadow(
                          color: (color ?? Colors.white).withValues(alpha: 0.5),
                          blurRadius: 5,
                        ),
                      ]
                    : null,
              ),
        ),
      ],
    );
  }
}
