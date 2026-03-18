import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TranscriptScreen extends HookConsumerWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final transcriptData = [
      {
        'semester': t.academic.fall_2023,
        'gpa': 3.85,
        'credits': 15,
        'courses': [
          {
            'code': 'CS101',
            'name': t.academic.intro_to_programming,
            'grade': 'A',
            'credits': 3,
            'color': const Color(0xFF6366F1),
          },
          {
            'code': 'MA101',
            'name': t.academic.calculus_i,
            'grade': 'A-',
            'credits': 4,
            'color': const Color(0xFFEC4899),
          },
          {
            'code': 'PHY101',
            'name': t.academic.general_physics,
            'grade': 'B+',
            'credits': 4,
            'color': const Color(0xFF10B981),
          },
          {
            'code': 'ENG101',
            'name': t.academic.english_composition,
            'grade': 'A',
            'credits': 4,
            'color': const Color(0xFFF59E0B),
          },
        ],
      },
      {
        'semester': t.academic.spring_2024,
        'gpa': 3.92,
        'credits': 17,
        'courses': [
          {
            'code': 'CS202',
            'name': t.academic.data_structures,
            'grade': 'A',
            'credits': 3,
            'color': const Color(0xFF8B5CF6),
          },
          {
            'code': 'MA202',
            'name': t.academic.linear_algebra,
            'grade': 'A',
            'credits': 3,
            'color': const Color(0xFF3B82F6),
          },
          {
            'code': 'CS205',
            'name': t.academic.logic_design,
            'grade': 'A-',
            'credits': 4,
            'color': const Color(0xFF10B981),
          },
          {
            'code': 'HU102',
            'name': t.academic.psychology,
            'grade': 'B+',
            'credits': 3,
            'color': const Color(0xFFF97316),
          },
          {
            'code': 'CS208',
            'name': t.academic.comp_organization,
            'grade': 'A',
            'credits': 4,
            'color': const Color(0xFF6366F1),
          },
        ],
      },
    ];

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
            t.academic.academic_journey,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: _AcademicSummary(
              cumulativeGpa: 3.84,
              earnedCredits: 32,
              totalRequired: 132,
              level: t.academic.sophomore,
              isArabic: isArabic,
            ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _SemesterTimelineNode(
                data: transcriptData[index],
                isLast: index == transcriptData.length - 1,
                isArabic: isArabic,
                index: index,
              ),
              childCount: transcriptData.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }
}

class _AcademicSummary extends StatelessWidget {
  final double cumulativeGpa;
  final int earnedCredits;
  final int totalRequired;
  final String level;
  final bool isArabic;

  const _AcademicSummary({
    required this.cumulativeGpa,
    required this.earnedCredits,
    required this.totalRequired,
    required this.level,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final progress = earnedCredits / totalRequired;

    return GlassContainer(
      borderRadius: BorderRadius.circular(32),
      padding: const EdgeInsets.all(28),
      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF6366F1),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.academic.academic_standing_excellent,
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  t.academic.active,
                  style: GoogleFonts.shareTechMono(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLargeStat(cumulativeGpa.toStringAsFixed(2), t.academic.gpa),
              Container(width: 1, height: 40, color: Colors.white10),
              _buildLargeStat(earnedCredits.toString(), t.academic.credits_1),
              Container(width: 1, height: 40, color: Colors.white10),
              _buildLargeStat(
                '${(progress * 100).toInt()}%',
                t.academic.progress,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.academic.graduation_progress,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: Colors.white38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$earnedCredits / $totalRequired',
                    style: GoogleFonts.shareTechMono(
                      fontSize: 12,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withValues(alpha: 0.05),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF6366F1),
                  ),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLargeStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            color: Colors.white38,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _SemesterTimelineNode extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isLast;
  final bool isArabic;
  final int index;

  const _SemesterTimelineNode({
    required this.data,
    required this.isLast,
    required this.isArabic,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final courses = data['courses'] as List<Map<String, dynamic>>;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.white.withValues(alpha: 0.1),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['semester'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        _buildSmallBadge(
                          data['gpa'].toString(),
                          const Color(0xFF6366F1),
                        ),
                        const SizedBox(width: 8),
                        _buildSmallBadge(
                          '${data['credits']}h',
                          Colors.white.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ...List.generate(courses.length, (i) {
                  return _TranscriptCourseCard(
                        course: courses[i],
                        isArabic: isArabic,
                        index: i,
                      )
                      .animate(delay: (i * 50).ms)
                      .fadeIn()
                      .slideX(begin: 0.05, end: 0);
                }),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: GoogleFonts.shareTechMono(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color == Colors.white.withValues(alpha: 0.1)
              ? Colors.white60
              : color,
        ),
      ),
    );
  }
}

class _TranscriptCourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isArabic;
  final int index;

  const _TranscriptCourseCard({
    required this.course,
    required this.isArabic,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = course['color'] as Color;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(20),
        padding: const EdgeInsets.all(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['code'] as String,
                    style: GoogleFonts.shareTechMono(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course['name'] as String,
                    style: GoogleFonts.outfit(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  course['grade'] as String,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${course['credits']} Cr',
                  style: GoogleFonts.outfit(
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
