
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SubjectResultsScreen extends ConsumerWidget {
  const SubjectResultsScreen({super.key});

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
            isArabic ? 'نتائج المقرر' : 'Subject Results',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final subjects = isArabic
                  ? [
                      {
                        'name': 'الذكاء الاصطناعي CS402',
                        'total': '92/100',
                        'mid': '18/20',
                        'final': '54/60',
                        'activities': '20/20',
                      },
                      {
                        'name': 'تفاضل متقدم MAT301',
                        'total': '88/100',
                        'mid': '15/20',
                        'final': '53/60',
                        'activities': '20/20',
                      },
                    ]
                  : [
                      {
                        'name': 'CS402 Artificial Intelligence',
                        'total': '92/100',
                        'mid': '18/20',
                        'final': '54/60',
                        'activities': '20/20',
                      },
                      {
                        'name': 'MAT301 Advanced Calculus',
                        'total': '88/100',
                        'mid': '15/20',
                        'final': '53/60',
                        'activities': '20/20',
                      },
                    ];
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildSubjectResultCard(
                  context,
                  subjects[index],
                  isGlass,
                  isArabic,
                ),
              );
            }, childCount: 2),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildSubjectResultCard(
    BuildContext context,
    Map<String, String> subject,
    bool isGlass,
    bool isArabic,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subject['name']!,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  subject['total']!,
                  style: GoogleFonts.shareTechMono(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildMarkRow(
            context,
            isArabic ? 'أعمال السنة/نصفي' : 'Midterm',
            subject['mid']!,
            isGlass,
          ),
          const SizedBox(height: 12),
          _buildMarkRow(
            context,
            isArabic ? 'النهائي' : 'Final',
            subject['final']!,
            isGlass,
          ),
          const SizedBox(height: 12),
          _buildMarkRow(
            context,
            isArabic ? 'الأنشطة' : 'Activities',
            subject['activities']!,
            isGlass,
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: content,
          );
  }

  Widget _buildMarkRow(
    BuildContext context,
    String label,
    String value,
    bool isGlass,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: isGlass ? Colors.white70 : Theme.of(context).hintColor,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isGlass
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
