part of 'subject_results_screen.dart';

class _MinimalLayout extends StatelessWidget {
  final Map<String, dynamic> subject;
  final bool isArabic;

  const _MinimalLayout({
    super.key,
    required this.subject,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final color = subject['color'] as Color;
    final components = subject['components'] as List;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject['name'],
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              subject['grade'],
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.4,
          ),
          itemCount: components.length,
          itemBuilder: (context, index) {
            final c = components[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    c['title'],
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: Colors.white38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${c['score']}/${c['max']}',
                    style: GoogleFonts.shareTechMono(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: c['color'],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
