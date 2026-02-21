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

class ActionPlanScreen extends ConsumerWidget {
  const ActionPlanScreen({super.key});

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
            isArabic ? 'خطة العمل' : 'Action Plan',
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
              final years = [
                {
                  'title': isArabic ? 'السنة الأولى' : 'Year 1',
                  'status': 'completed',
                },
                {
                  'title': isArabic ? 'السنة الثانية' : 'Year 2',
                  'status': 'completed',
                },
                {
                  'title': isArabic ? 'السنة الثالثة' : 'Year 3',
                  'status': 'in_progress',
                },
                {
                  'title': isArabic ? 'السنة الرابعة' : 'Year 4',
                  'status': 'remaining',
                },
              ];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildYearPlanCard(
                  context,
                  years[index],
                  isGlass,
                  index,
                  isArabic,
                ),
              );
            }, childCount: 4),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildYearPlanCard(
    BuildContext context,
    Map<String, String> year,
    bool isGlass,
    int index,
    bool isArabic,
  ) {
    final status = year['status']!;
    final isCompleted = status == 'completed';
    final isInProgress = status == 'in_progress';

    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.withValues(alpha: 0.1)
                  : (isInProgress
                        ? Colors.blue.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1)),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted
                  ? LucideIcons.check
                  : (isInProgress ? LucideIcons.play : LucideIcons.lock),
              color: isCompleted
                  ? Colors.green
                  : (isInProgress ? Colors.blue : Colors.grey),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year['title']!,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  isCompleted
                      ? (isArabic ? 'مكتمل' : 'Completed')
                      : (isInProgress
                            ? (isArabic ? 'قيد التنفيذ' : 'In Progress')
                            : (isArabic ? 'متبقي' : 'Remaining')),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.chevronDown, size: 18),
            onPressed: () {},
            color: Theme.of(context).hintColor,
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
              )
              .animate()
              .fadeIn(delay: (index * 100).ms)
              .slideX(begin: 0.1, end: 0);
  }
}
