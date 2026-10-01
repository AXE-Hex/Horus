part of 'subject_results_screen.dart';

class _AnalyticalLayout extends StatelessWidget {
  final Map<String, dynamic> subject;
  final bool isArabic;

  const _AnalyticalLayout({
    super.key,
    required this.subject,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final components = subject['components'] as List;

    return Column(
      children: [
        GlassContainer(
          borderRadius: BorderRadius.circular(28),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.academic.performance_distribution,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ...components.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            c['title'],
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            '${c['score']}/${c['max']}',
                            style: GoogleFonts.shareTechMono(
                              color: c['color'],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: c['score'] / c['max'],
                          minHeight: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                          valueColor: AlwaysStoppedAnimation<Color>(c['color']),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildStatsGrid(subject, isArabic),
      ],
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic> subject, bool isAr) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: isAr ? 'المجموع' : 'Total',
            value: '${subject['totalScore'] ?? '—'}%',
            color: subject['color'],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            label: isAr ? 'التقدير' : 'Grade',
            value: subject['grade'],
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
