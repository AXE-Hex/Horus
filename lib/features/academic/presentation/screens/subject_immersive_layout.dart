part of 'subject_results_screen.dart';

class _ImmersiveLayout extends StatelessWidget {
  final Map<String, dynamic> subject;
  final bool isArabic;

  const _ImmersiveLayout({
    super.key,
    required this.subject,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final color = subject['color'] as Color;
    return Column(
      children: [
        GlassContainer(
          borderRadius: BorderRadius.circular(32),
          padding: const EdgeInsets.all(32),
          border: Border.all(color: color.withValues(alpha: 0.2)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject['code'],
                        style: GoogleFonts.shareTechMono(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subject['name'],
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  _buildGradeBadge(subject['grade'], color),
                ],
              ),
              const SizedBox(height: 32),
              _buildCircularProgress(
                subject['totalScore'],
                subject['maxScore'],
                color,
                isArabic,
              ),
              const SizedBox(height: 32),
              _buildInsights(isArabic),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate((subject['components'] as List).length, (index) {
          return _ComponentCard(
            component: subject['components'][index],
            isArabic: isArabic,
            index: index,
          );
        }),
      ],
    );
  }

  Widget _buildGradeBadge(String grade, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        grade,
        style: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }

  Widget _buildCircularProgress(int? score, int max, Color color, bool isAr) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CircularProgressIndicator(
            value: score == null ? 0 : score / max,
            strokeWidth: 10,
            backgroundColor: Colors.white.withValues(alpha: 0.05),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        Column(
          children: [
            Text(
              score?.toString() ?? '—',
              style: GoogleFonts.shareTechMono(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              isAr ? 'من $max' : 'OUT OF $max',
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: Colors.white38,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsights(bool isAr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Icon(LucideIcons.trendingUp, size: 14, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              '—',
              style: GoogleFonts.outfit(fontSize: 12, color: Colors.white60),
            ),
          ],
        ),
        Container(width: 1, height: 16, color: Colors.white10),
        Row(
          children: [
            Icon(LucideIcons.award, size: 14, color: Colors.amber),
            const SizedBox(width: 8),
            Text(
              '—',
              style: GoogleFonts.outfit(fontSize: 12, color: Colors.white60),
            ),
          ],
        ),
      ],
    );
  }
}
