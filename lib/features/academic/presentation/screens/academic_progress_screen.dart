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

class AcademicProgressScreen extends ConsumerWidget {
  const AcademicProgressScreen({super.key});

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
            isArabic ? "التقدم الأكاديمي" : "Academic Progress",
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
            child: _buildCompletionSection(context, isGlass, isArabic),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryCard(
                  context,
                  isArabic ? 'متطلبات الجامعة' : 'University Requirements',
                  12,
                  18,
                  Colors.blueAccent,
                  isGlass,
                  isArabic,
                ),
                const SizedBox(height: 12),
                _buildCategoryCard(
                  context,
                  isArabic ? 'متطلبات الكلية' : 'Faculty Requirements',
                  32,
                  45,
                  Colors.greenAccent,
                  isGlass,
                  isArabic,
                ),
                const SizedBox(height: 12),
                _buildCategoryCard(
                  context,
                  isArabic ? 'متطلبات التخصص' : 'Major Requirements',
                  50,
                  65,
                  Colors.orangeAccent,
                  isGlass,
                  isArabic,
                ),
                const SizedBox(height: 12),
                _buildCategoryCard(
                  context,
                  isArabic ? 'المواد الاختيارية' : 'Electives',
                  6,
                  12,
                  Colors.purpleAccent,
                  isGlass,
                  isArabic,
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildCompletionSection(
    BuildContext context,
    bool isGlass,
    bool isArabic,
  ) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: 0.72,
                  strokeWidth: 12,
                  backgroundColor: isGlass
                      ? Colors.white10
                      : Theme.of(context).dividerColor.withValues(alpha: 0.05),
                  color: Theme.of(context).primaryColor,
                  strokeCap: StrokeCap.round,
                ),
              ).animate().rotate(duration: 1200.ms, curve: Curves.easeOutQuart),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '72%',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: isGlass
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    isArabic ? "مكتمل" : "Completed",
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: isGlass
                          ? Colors.white60
                          : Theme.of(context).hintColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                '100',
                isArabic ? 'مكتمل' : 'Completed',
                isGlass,
              ),
              _buildStatItem(
                context,
                '40',
                isArabic ? 'متبقي' : 'Remaining',
                isGlass,
              ),
            ],
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(32),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: content,
          );
  }

  Widget _buildStatItem(
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isGlass
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface,
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

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    int current,
    int total,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    final progress = current / total;

    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isGlass
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                '$current / $total',
                style: GoogleFonts.shareTechMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: isGlass
                  ? Colors.white10
                  : color.withValues(alpha: 0.1),
              color: color,
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
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.05),
              ),
            ),
            child: content,
          );
  }
}
