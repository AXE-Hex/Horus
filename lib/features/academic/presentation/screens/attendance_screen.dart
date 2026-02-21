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

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

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
            isArabic ? 'الحضور والغياب' : 'Attendance',
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
            child: _buildAttendanceSummary(context, isGlass, isArabic),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final attendance = isArabic
                  ? [
                      {
                        'subject': 'الذكاء الاصطناعي',
                        'present': '12',
                        'absent': '2',
                        'ratio': '85%',
                      },
                      {
                        'subject': 'تعلم الآلة',
                        'present': '14',
                        'absent': '0',
                        'ratio': '100%',
                      },
                      {
                        'subject': 'أخلاقيات المهنة',
                        'present': '6',
                        'absent': '1',
                        'ratio': '86%',
                      },
                    ]
                  : [
                      {
                        'subject': 'Artificial Intelligence',
                        'present': '12',
                        'absent': '2',
                        'ratio': '85%',
                      },
                      {
                        'subject': 'Machine Learning',
                        'present': '14',
                        'absent': '0',
                        'ratio': '100%',
                      },
                      {
                        'subject': 'Ethics in IT',
                        'present': '6',
                        'absent': '1',
                        'ratio': '86%',
                      },
                    ];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildAttendanceCard(
                  context,
                  attendance[index],
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

  Widget _buildAttendanceSummary(
    BuildContext context,
    bool isGlass,
    bool isArabic,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            '92%',
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: isGlass ? Colors.white : Theme.of(context).primaryColor,
            ),
          ),
          Text(
            isArabic ? 'نسبة الحضور' : 'Attendance Ratio',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isGlass ? Colors.white60 : Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                '32',
                isArabic ? 'حضور' : 'Present',
                Colors.green,
                isGlass,
              ),
              _buildStatItem(
                context,
                '3',
                isArabic ? 'غياب' : 'Absent',
                Colors.red,
                isGlass,
              ),
              _buildStatItem(
                context,
                '1',
                isArabic ? 'تأخير' : 'Late',
                Colors.orange,
                isGlass,
              ),
            ],
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(28),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15)],
            ),
            child: content,
          );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    Color color,
    bool isGlass,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: isGlass ? Colors.white60 : Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceCard(
    BuildContext context,
    Map<String, String> item,
    bool isGlass,
    bool isArabic,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['subject']!,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${isArabic ? 'حضور' : 'Present'}: ${item['present']} | ${isArabic ? 'غياب' : 'Absent'}: ${item['absent']}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            item['ratio']!,
            style: GoogleFonts.shareTechMono(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
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
