// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GradesScreen extends ConsumerWidget {
  const GradesScreen({super.key});

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
            isArabic ? 'الدرجات' : 'Grades',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildGradeSummary(context, isGlass, isArabic),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final courses = isArabic
                  ? [
                      {
                        'name': 'الذكاء الاصطناعي CS402',
                        'grade': 'A',
                        'points': '4.0',
                      },
                      {
                        'name': 'تفاضل متقدم MAT301',
                        'grade': 'A-',
                        'points': '3.7',
                      },
                      {
                        'name': 'أخلاقيات المهنة HUM210',
                        'grade': 'B+',
                        'points': '3.3',
                      },
                    ]
                  : [
                      {
                        'name': 'CS402 Artificial Intelligence',
                        'grade': 'A',
                        'points': '4.0',
                      },
                      {
                        'name': 'MAT301 Advanced Calculus',
                        'grade': 'A-',
                        'points': '3.7',
                      },
                      {
                        'name': 'HUM210 Professional Ethics',
                        'grade': 'B+',
                        'points': '3.3',
                      },
                    ];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildGradeCard(
                  context,
                  courses[index],
                  isGlass,
                  isArabic,
                ),
              );
            }, childCount: 3),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildGradeSummary(BuildContext context, bool isGlass, bool isArabic) {
    final content = Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryStat(
            context,
            '3.92',
            isArabic ? 'المعدل التراكمي' : 'Cumulative GPA',
            isGlass,
          ),
          Container(
            width: 1,
            height: 40,
            color: isGlass ? Colors.white10 : Colors.black12,
          ),
          _buildSummaryStat(
            context,
            '9',
            isArabic ? 'ساعات' : 'Credits',
            isGlass,
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(24),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: content,
          );
  }

  Widget _buildSummaryStat(
    BuildContext context,
    String value,
    String label,
    bool isGlass,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isGlass ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isGlass ? Colors.white60 : Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGradeCard(
    BuildContext context,
    Map<String, String> course,
    bool isGlass,
    bool isArabic,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                Text(
                  '${isArabic ? 'النقاط' : 'Grade Point'}: ${course['points']}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              course['grade']!,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(20),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black12),
            ),
            child: content,
          );
  }
}
