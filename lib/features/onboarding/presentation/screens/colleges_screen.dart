import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hue/core/constants/colleges_data.dart';

class CollegesScreen extends ConsumerStatefulWidget {
  final bool isOnboarding;

  const CollegesScreen({super.key, this.isOnboarding = true});

  @override
  ConsumerState<CollegesScreen> createState() => _CollegesScreenState();
}

class _CollegesScreenState extends ConsumerState<CollegesScreen> {
  @override
  Widget build(BuildContext context) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.onboarding.faculties_directory.title,
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ).animate().fadeIn().slideX(begin: -0.2),
                const SizedBox(height: 8),
                Text(
                  t.onboarding.faculties_directory.subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: isGlass ? Colors.white70 : Colors.grey,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final college = allColleges[index];
              return _buildCollegeCard(
                context,
                college,
                index,
                isGlass,
                isArabic,
              );
            }, childCount: allColleges.length),
          ),
        ),
      ],
    );

    if (widget.isOnboarding) {
      return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
    }
    return content;
  }

  void _onCollegeTap(StaticCollegeData college) {
    context.push('/college-portal', extra: college);
  }

  Widget _buildCollegeCard(
    BuildContext context,
    StaticCollegeData college,
    int index,
    bool isGlass,
    bool isArabic,
  ) {
    final color = college.themeColor;
    final title = isArabic ? college.nameAr : college.nameEn;

    final cardContent = Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: Center(
              child: Opacity(
                opacity: 0.2,
                child: Icon(LucideIcons.school, size: 60, color: color),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  isGlass
                      ? Colors.black.withValues(alpha: 0.8)
                      : Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );

    final wrapper = isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(30),
            padding: EdgeInsets.zero,
            child: cardContent,
          )
        : Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: cardContent,
          );

    return GestureDetector(onTap: () => _onCollegeTap(college), child: wrapper)
        .animate()
        .fadeIn(delay: Duration(milliseconds: 50 * index))
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
        );
  }
}
