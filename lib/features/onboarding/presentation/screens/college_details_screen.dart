import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

part 'college_details_sections.dart';
part 'college_details_painter.dart';

class CollegeDetailsScreen extends ConsumerWidget {
  final Map<String, dynamic> collegeData;

  const CollegeDetailsScreen({super.key, required this.collegeData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final color = collegeData['color'] as Color? ?? Colors.blue;
    final title = (collegeData['title'] as String Function(Translations))(t);

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 210,
          pinned: true,
          stretch: true,
          backgroundColor: isGlass ? Colors.transparent : color,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.chevronLeft, color: Colors.white),
            ),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
            ],
            background: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    collegeData['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                ),
                if (isGlass)
                  Opacity(
                    opacity: 0.15,
                    child: CustomPaint(painter: _MeshPainter()),
                  ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        LucideIcons.school,
                        size: 48,
                        color: Colors.white,
                      ),
                    ).animate().scale(
                      curve: Curves.easeOutBack,
                      duration: 600.ms,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.2, end: 0),
                  ],
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader(context, t.colleges.details.dean, color),
                const SizedBox(height: 12),
                _buildDeanCard(context, color, isGlass),

                const SizedBox(height: 24),

                _buildSectionHeader(
                  context,
                  t.colleges.details.academic_statistics,
                  color,
                ),
                const SizedBox(height: 12),
                _buildStatsGrid(context, color, isGlass),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionHeader(
                      context,
                      t.colleges.details.staff,
                      color,
                    ),
                    TextButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        context.push('/academic-staff', extra: collegeData);
                      },
                      child: Text(
                        t.colleges.details.view_all,
                        style: GoogleFonts.inter(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildStaffList(context, color, isGlass),

                const SizedBox(height: 24),

                _buildDepartmentsButton(context, collegeData, color, isGlass),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
  }
}
