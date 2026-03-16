import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

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

  Widget _buildSectionHeader(BuildContext context, String title, Color color) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
      ),
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildDeanCard(BuildContext context, Color color, bool isGlass) {
    final deanName = t.colleges.details.staff_member;

    final card = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isGlass ? null : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isGlass
            ? []
            : [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.5)],
              ),
            ),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: isGlass ? Colors.black26 : Colors.white,
              child: Icon(LucideIcons.user, size: 36, color: color),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deanName,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isGlass ? Colors.white : null,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    t.colleges.details.dean_title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isGlass ? Colors.white : color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.award,
            size: 40,
            color: color.withValues(alpha: 0.1),
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(24),
            padding: EdgeInsets.zero,
            child: card,
          )
        : card;
  }

  Widget _buildStaffList(BuildContext context, Color color, bool isGlass) {
    final staff = [
      {'role': t.colleges.details.vice_dean},
      {'role': t.colleges.details.head_of_dept},
      {'role': t.colleges.details.assoc_prof},
    ];

    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: staff.length,
        separatorBuilder: (c, i) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final member = staff[index];
          final card = Container(
            width: 130,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isGlass ? null : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: isGlass
                  ? null
                  : Border.all(color: color.withValues(alpha: 0.05)),
              boxShadow: isGlass
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: color.withValues(alpha: 0.1),
                    child: Icon(LucideIcons.user, size: 24, color: color),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  t.colleges.details.staff_member,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isGlass ? Colors.white : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  member['role']!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isGlass
                        ? Colors.white60
                        : Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          );

          return isGlass
              ? GlassContainer(
                  width: 150,
                  borderRadius: BorderRadius.circular(24),
                  padding: EdgeInsets.zero,
                  child: card,
                )
              : card
                    .animate()
                    .fadeIn(delay: (index * 100).ms)
                    .moveY(begin: 10, end: 0);
        },
      ),
    );
  }

  Widget _buildDepartmentsButton(
    BuildContext context,
    Map<String, dynamic> collegeData,
    Color color,
    bool isGlass,
  ) {
    final buttonContent = Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(LucideIcons.layoutGrid, color: color, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.colleges.details.departments,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  t.colleges.details.explore_majors,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, size: 20),
        ],
      ),
    );

    if (isGlass) {
      return GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: EdgeInsets.zero,
        child: InkWell(
          onTap: () => context.push('/college-departments', extra: collegeData),
          borderRadius: BorderRadius.circular(24),
          child: buttonContent,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: InkWell(
          onTap: () => context.push('/college-departments', extra: collegeData),
          borderRadius: BorderRadius.circular(24),
          child: buttonContent,
        ),
      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2);
    }
  }

  Widget _buildStatsGrid(BuildContext context, Color color, bool isGlass) {
    final stats = collegeData['stats'] as Map<String, dynamic>? ?? {};
    if (stats.isEmpty) return const SizedBox.shrink();

    final statItems = [
      {
        'key': 'students',
        'value': stats['students'] ?? '---',
        'icon': LucideIcons.users,
      },
      {
        'key': 'academic_staff',
        'value': stats['academic_staff'] ?? '---',
        'icon': LucideIcons.userCheck,
      },
      {
        'key': 'teaching_assistants',
        'value': stats['teaching_assistants'] ?? '---',
        'icon': LucideIcons.graduationCap,
      },
      {
        'key': 'published_articles',
        'value': stats['published_articles'] ?? '---',
        'icon': LucideIcons.fileText,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.1,
      ),
      itemCount: statItems.length,
      itemBuilder: (context, index) {
        final item = statItems[index];
        return _buildStatCard(
          context,
          (t['colleges.details.${item['key']}'] as String),
          item['value'] as String,
          item['icon'] as IconData,
          color,
          isGlass,
          index,
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
    bool isGlass,
    int index,
  ) {
    final cardContent = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isGlass ? null : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: isGlass
            ? null
            : Border.all(color: color.withValues(alpha: 0.1), width: 1.2),
        boxShadow: isGlass
            ? []
            : [
                BoxShadow(
                  color: color.withValues(alpha: 0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -8,
            child: Icon(icon, size: 48, color: color.withValues(alpha: 0.05)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isGlass
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isGlass ? Colors.white70 : Theme.of(context).hintColor,
                  letterSpacing: 0.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );

    return (isGlass
            ? GlassContainer(
                borderRadius: BorderRadius.circular(20),
                padding: EdgeInsets.zero,
                child: cardContent,
              )
            : cardContent)
        .animate()
        .fadeIn(delay: (index * 100).ms)
        .moveY(begin: 20, end: 0, curve: Curves.easeOutQuart)
        .scale(begin: const Offset(0.9, 0.9));
  }
}

class _MeshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const gridSize = 40.0;
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
