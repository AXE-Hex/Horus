import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GradesScreen extends HookConsumerWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final selectedSemester = useState(0);

    final semesters = [
      t.academic.fall_2023,
      t.academic.spring_2024,
      t.academic.summer_2024,
    ];

    final allGrades = [
      [
        {
          'name': t.academic.computer_programming,
          'code': 'CS101',
          'grade': 'A',
          'points': 4.0,
          'credits': 3,
          'score': 95,
          'color': const Color(0xFF6366F1),
          'icon': LucideIcons.code,
        },
        {
          'name': t.academic.advanced_mathematics,
          'code': 'MA102',
          'grade': 'B+',
          'points': 3.3,
          'credits': 4,
          'score': 84,
          'color': const Color(0xFFEC4899),
          'icon': LucideIcons.functionSquare,
        },
        {
          'name': t.academic.network_security,
          'code': 'CS305',
          'grade': 'A-',
          'points': 3.7,
          'credits': 3,
          'score': 91,
          'color': const Color(0xFF10B981),
          'icon': LucideIcons.shieldCheck,
        },
      ],

      [
        {
          'name': t.academic.artificial_intelligence,
          'code': 'CS402',
          'grade': 'A',
          'points': 4.0,
          'credits': 3,
          'score': 98,
          'color': const Color(0xFF8B5CF6),
          'icon': LucideIcons.brain,
        },
        {
          'name': t.academic.database_systems,
          'code': 'CS202',
          'grade': 'A-',
          'points': 3.7,
          'credits': 3,
          'score': 89,
          'color': const Color(0xFFF59E0B),
          'icon': LucideIcons.database,
        },
      ],

      [
        {
          'name': t.academic.ethics_in_it,
          'code': 'HU201',
          'grade': 'A',
          'points': 4.0,
          'credits': 2,
          'score': 92,
          'color': const Color(0xFF06B6D4),
          'icon': LucideIcons.graduationCap,
        },
      ],
    ];

    final currentGrades = allGrades[selectedSemester.value];

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 100,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: Text(
            t.academic.academic_results,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
            child:
                _GPAHeader(
                      gpa: 3.92,
                      totalCredits: 32,
                      rank: 5,
                      isArabic: isArabic,
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .scale(begin: const Offset(0.9, 0.9)),
          ),
        ),
        SliverToBoxAdapter(
          child: _SemesterSelector(
            semesters: semesters,
            selectedIndex: selectedSemester.value,
            onChanged: (index) => selectedSemester.value = index,
            isArabic: isArabic,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final grade = currentGrades[index];
              return _GradeCard(grade: grade, isArabic: isArabic, index: index);
            }, childCount: currentGrades.length),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }
}

class _GPAHeader extends StatelessWidget {
  final double gpa;
  final int totalCredits;
  final int rank;
  final bool isArabic;

  const _GPAHeader({
    required this.gpa,
    required this.totalCredits,
    required this.rank,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.05),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            t.academic.cumulative_gpa,
            style: GoogleFonts.outfit(
              color: const Color(0xFF6366F1),
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            gpa.toStringAsFixed(2),
            style: GoogleFonts.shareTechMono(
              fontSize: 64,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMiniStat(totalCredits.toString(), t.academic.credits_1),
              Container(width: 1, height: 20, color: Colors.white10),
              _buildMiniStat('#$rank', t.academic.rank),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _SemesterSelector extends StatelessWidget {
  final List<String> semesters;
  final int selectedIndex;
  final Function(int) onChanged;
  final bool isArabic;

  const _SemesterSelector({
    required this.semesters,
    required this.selectedIndex,
    required this.onChanged,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(semesters.length, (index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: 300.ms,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6366F1)
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF6366F1,
                            ).withValues(alpha: 0.3),
                            blurRadius: 15,
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  semesters[index],
                  style: GoogleFonts.outfit(
                    color: isSelected ? Colors.white : Colors.white60,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _GradeCard extends StatelessWidget {
  final Map<String, dynamic> grade;
  final bool isArabic;
  final int index;

  const _GradeCard({
    required this.grade,
    required this.isArabic,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = grade['color'] as Color;
    final score = grade['score'] as int;
    final points = grade['points'] as double;
    final credits = grade['credits'] as int;

    return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.05),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(28),
              padding: const EdgeInsets.all(24),
              border: Border.all(color: color.withValues(alpha: 0.15)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: color.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Icon(
                          grade['icon'] as IconData,
                          color: color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              grade['name'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              grade['code'] as String,
                              style: GoogleFonts.shareTechMono(
                                fontSize: 12,
                                color: Colors.white38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildGradeBadge(grade['grade'] as String, color),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  t.academic.completion_rate,
                                  style: GoogleFonts.outfit(
                                    fontSize: 11,
                                    color: Colors.white38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '$score%',
                                  style: GoogleFonts.shareTechMono(
                                    fontSize: 11,
                                    color: color,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: score / 100,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.05,
                                ),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  color,
                                ),
                                minHeight: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailItem(
                        t.academic.points,
                        points.toStringAsFixed(1),
                      ),
                      _buildDetailItem(t.academic.credits, credits.toString()),
                      _buildDetailItem(t.academic.score, '$score/100'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        .animate(delay: (index * 100).ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.1, end: 0);
  }

  Widget _buildGradeBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 9,
            color: Colors.white24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            fontSize: 14,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
