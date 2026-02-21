// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TranscriptScreen extends ConsumerWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 120,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: Text(
            isArabic ? "السجل الأكاديمي" : "Academic Transcript",
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),

        // GPA OVERVIEW
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: _buildGPAOverview(context, isGlass, isArabic),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // SEMESTER LIST
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _buildSemesterSection(
                    context,
                    index,
                    isGlass,
                    isArabic,
                  ),
                );
              },
              childCount: 2, // Mocking 2 semesters
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildGPAOverview(BuildContext context, bool isGlass, bool isArabic) {
    final cardContent = Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '3.84',
                style: GoogleFonts.outfit(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: isGlass
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
              ),
              Text(
                isArabic ? "المعدل التراكمي" : "Cumulative GPA",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isGlass ? Colors.white60 : Theme.of(context).hintColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 40,
            color: isGlass
                ? Colors.white10
                : Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
          Column(
            children: [
              Text(
                '128',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isGlass
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                isArabic ? "الساعات المكتسبة" : "Earned Credits",
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: isGlass ? Colors.white60 : Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isArabic ? "نشط" : "ACTIVE",
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isArabic ? "حالة الطالب" : "Academic Standing",
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: isGlass ? Colors.white60 : Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(30),
            padding: EdgeInsets.zero,
            child: cardContent,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: cardContent,
          );
  }

  Widget _buildSemesterSection(
    BuildContext context,
    int index,
    bool isGlass,
    bool isArabic,
  ) {
    final isSpring = index == 1;
    final semesterName = isSpring
        ? (isArabic ? 'ربيع' : 'Spring')
        : (isArabic ? 'خريف' : 'Fall');
    final year = isSpring ? '2024' : '2023';

    final courses = isSpring
        ? [
            {
              'name': isArabic
                  ? 'الذكاء الاصطناعي CS402'
                  : 'CS402 Artificial Intelligence',
              'grade': 'A',
              'credits': '3',
            },
            {
              'name': isArabic
                  ? 'تفاضل متقدم MAT301'
                  : 'MAT301 Advanced Calculus',
              'grade': 'A-',
              'credits': '4',
            },
            {
              'name': isArabic
                  ? 'أخلاقيات المهنة HUM210'
                  : 'HUM210 Professional Ethics',
              'grade': 'B+',
              'credits': '2',
            },
          ]
        : [
            {
              'name': isArabic ? 'هياكل بيانات CS301' : 'CS301 Data Structures',
              'grade': 'A',
              'credits': '3',
            },
            {
              'name': isArabic ? 'نظم تشغيل CS305' : 'CS305 Operating Systems',
              'grade': 'B',
              'credits': '3',
            },
            {
              'name': isArabic ? 'جبر خطي MAT202' : 'MAT202 Linear Algebra',
              'grade': 'A-',
              'credits': '4',
            },
            {
              'name': isArabic ? 'فيزياء 2 PHY101' : 'PHY101 Physics II',
              'grade': 'B+',
              'credits': '4',
            },
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$semesterName $year',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: courses.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, courseIndex) {
            final course = courses[courseIndex];
            return _buildCourseCard(
              context,
              course,
              isGlass,
              courseIndex,
              isArabic,
            );
          },
        ),
      ],
    ).animate().fadeIn(delay: (index * 200).ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildCourseCard(
    BuildContext context,
    Map<String, String> course,
    bool isGlass,
    int index,
    bool isArabic,
  ) {
    final cardContent = Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                course['grade']!,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
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
                  course['name']!,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isGlass ? Colors.white : null,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      LucideIcons.clock,
                      size: 12,
                      color: Theme.of(context).hintColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${course['credits']} ${isArabic ? "ساعات" : "Credits"}',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      LucideIcons.checkCircle2,
                      size: 12,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isArabic ? "مكتمل" : "Completed",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(20),
            padding: EdgeInsets.zero,
            child: cardContent,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.05),
              ),
            ),
            child: cardContent,
          );
  }
}
