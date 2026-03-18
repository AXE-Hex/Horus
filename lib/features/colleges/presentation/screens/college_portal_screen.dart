import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/constants/colleges_data.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/features/admin/data/repositories/institutional_repository.dart';
import 'package:hue/core/auth/roles.dart';

class CollegePortalScreen extends ConsumerStatefulWidget {
  final StaticCollegeData college;

  const CollegePortalScreen({super.key, required this.college});

  @override
  ConsumerState<CollegePortalScreen> createState() =>
      _CollegePortalScreenState();
}

class _CollegePortalScreenState extends ConsumerState<CollegePortalScreen> {
  @override
  Widget build(BuildContext context) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final college = widget.college;
    final title = isArabic ? college.nameAr : college.nameEn;
    final color = college.themeColor;

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildSliverAppBar(context, college, title, color, isGlass),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatsGrid(college, color, isGlass, isArabic),
                const SizedBox(height: 32),
                _buildAboutSection(college, color, isGlass, isArabic),
                const SizedBox(height: 32),
                _buildDeanSection(college, color, isGlass, isArabic),
                const SizedBox(height: 32),
                _buildStaffSection(college, color, isGlass, isArabic),
                const SizedBox(height: 32),
                _buildDepartmentsSection(college, color, isGlass, isArabic),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    StaticCollegeData college,
    String title,
    Color color,
    bool isGlass,
  ) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      stretch: true,
      backgroundColor: isGlass ? Colors.transparent : color,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.chevronLeft,
            color: Colors.white,
            size: 20,
          ),
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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color,
                    color.withValues(alpha: 0.7),
                    color.withValues(alpha: 0.9),
                  ],
                ),
              ),
              child: Opacity(
                opacity: 0.1,
                child: Icon(LucideIcons.school, size: 200, color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'EST. ${college.established}',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(
    StaticCollegeData college,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    final statsAsync = ref.watch(collegeRealTimeStatsProvider(college.id));

    return statsAsync.when(
      data: (stats) => LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 12) / 2;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildStatItem(
                'students',
                stats['students']?.toString() ?? '0',
                LucideIcons.users,
                color,
                isGlass,
                itemWidth,
                0,
              ),
              _buildStatItem(
                'academic_staff',
                stats['faculty']?.toString() ?? '0',
                LucideIcons.userCheck,
                color,
                isGlass,
                itemWidth,
                1,
              ),
              _buildStatItem(
                'teaching_assistants',
                stats['assistants']?.toString() ?? '0',
                LucideIcons.graduationCap,
                color,
                isGlass,
                itemWidth,
                2,
              ),
              _buildStatItem(
                'published_articles',
                stats['research']?.toString() ?? '0',
                LucideIcons.fileText,
                color,
                isGlass,
                itemWidth,
                3,
              ),
            ],
          );
        },
      ),
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 12) / 2;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildStatItem(
                'students',
                '0',
                LucideIcons.users,
                color,
                isGlass,
                itemWidth,
                0,
              ),
              _buildStatItem(
                'academic_staff',
                '0',
                LucideIcons.userCheck,
                color,
                isGlass,
                itemWidth,
                1,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem(
    String key,
    String value,
    IconData icon,
    Color color,
    bool isGlass,
    double width,
    int index,
  ) {
    final label = t['colleges.details.$key'];

    final cardContent = Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isGlass ? null : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: isGlass
            ? null
            : Border.all(color: color.withValues(alpha: 0.1)),
        boxShadow: isGlass
            ? []
            : [
                BoxShadow(
                  color: color.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isGlass
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: isGlass ? Colors.white70 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );

    return (isGlass
            ? GlassContainer(
                borderRadius: BorderRadius.circular(24),
                padding: EdgeInsets.zero,
                child: cardContent,
              )
            : cardContent)
        .animate()
        .fadeIn(delay: (index * 100).ms)
        .slideY(begin: 0.2);
  }

  Widget _buildAboutSection(
    StaticCollegeData college,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.info, color: color, size: 24),
            const SizedBox(width: 12),
            Text(
              t.extracted.about_college,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildExpandableCard(
          t.extracted.origins_roots,
          isArabic ? college.about.originsAr : college.about.originsEn,
          color,
          isGlass,
          0,
        ),
        const SizedBox(height: 12),
        _buildExpandableCard(
          t.extracted.vision_mission,
          '${isArabic ? college.about.visionAr : college.about.visionEn}\n\n${isArabic ? college.about.missionAr : college.about.missionEn}',
          color,
          isGlass,
          1,
        ),
        const SizedBox(height: 12),
        _buildExpandableCard(
          t.extracted.strategic_goals,
          (isArabic ? college.about.goalsAr : college.about.goalsEn).join(
            '\n• ',
          ),
          color,
          isGlass,
          2,
        ),
      ],
    );
  }

  Widget _buildExpandableCard(
    String title,
    String content,
    Color color,
    bool isGlass,
    int index,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isGlass ? null : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: isGlass
            ? null
            : Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: isGlass
          ? GlassContainer(
              borderRadius: BorderRadius.circular(20),
              padding: EdgeInsets.zero,
              child: ExpansionTile(
                title: Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                textColor: color,
                iconColor: color,
                collapsedTextColor: Colors.white,
                collapsedIconColor: Colors.white70,
                childrenPadding: const EdgeInsets.all(16),
                children: [
                  Text(
                    content,
                    style: GoogleFonts.outfit(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            )
          : ExpansionTile(
              title: Text(
                title,
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
              ),
              textColor: color,
              iconColor: color,
              childrenPadding: const EdgeInsets.all(16),
              children: [Text(content, style: GoogleFonts.outfit(height: 1.5))],
            ),
    ).animate().fadeIn(delay: (index * 150).ms).slideX(begin: 0.1);
  }

  Widget _buildDeanSection(
    StaticCollegeData college,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    final dean = college.dean;
    final deanName = isArabic ? dean.nameAr : dean.nameEn;
    final deanTitle = isArabic ? dean.titleAr : dean.titleEn;
    final deanBio = isArabic ? dean.bioAr : dean.bioEn;

    final cardContent = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isGlass ? null : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
        border: isGlass
            ? null
            : Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: color.withValues(alpha: 0.1),
                child: Icon(LucideIcons.user, size: 40, color: color),
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
                    Text(
                      deanTitle,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            deanBio,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: isGlass ? Colors.white70 : Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.award, color: color, size: 24),
            const SizedBox(width: 12),
            Text(
              t.extracted.faculty_management,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        isGlass
            ? GlassContainer(
                borderRadius: BorderRadius.circular(28),
                padding: EdgeInsets.zero,
                child: cardContent,
              )
            : cardContent,
      ],
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildStaffSection(
    StaticCollegeData college,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    final staffAsync = ref.watch(collegeStaffListProvider(college.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.users, color: color, size: 24),
            const SizedBox(width: 12),
            Text(
              t.extracted.faculty_staff,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        staffAsync.when(
          data: (staff) {
            if (staff.isEmpty) {
              return Center(
                child: Text(
                  t.extracted.no_staff_registered_yet,
                  style: GoogleFonts.outfit(color: Colors.grey),
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: staff.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final member = staff[index];
                final name = isArabic && member.fullNameAr != null
                    ? member.fullNameAr!
                    : member.fullName;

                final role = member.roles.isNotEmpty
                    ? member.roles.first.displayName()
                    : '';

                final item = Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isGlass ? null : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: isGlass
                        ? null
                        : Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: color.withValues(alpha: 0.1),
                        backgroundImage: member.avatarUrl != null
                            ? NetworkImage(member.avatarUrl!)
                            : null,
                        child: member.avatarUrl == null
                            ? Icon(LucideIcons.user, color: color)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                color: isGlass ? Colors.white : null,
                              ),
                            ),
                            Text(
                              role,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                color: color,
                                fontWeight: FontWeight.w500,
                              ),
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
                        child: item,
                      )
                    : item;
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2);
  }

  Widget _buildDepartmentsSection(
    StaticCollegeData college,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    final depts = isArabic ? college.departmentsAr : college.departmentsEn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.grid, color: color, size: 24),
            const SizedBox(width: 12),
            Text(
              t.extracted.scientific_departments,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: depts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final dept = depts[index];
            final item = Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isGlass ? null : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: isGlass
                    ? null
                    : Border.all(color: Colors.grey.withValues(alpha: 0.05)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      dept,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: isGlass ? Colors.white : null,
                      ),
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight,
                    size: 16,
                    color: isGlass ? Colors.white38 : Colors.grey[400],
                  ),
                ],
              ),
            );

            return isGlass
                ? GlassContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: EdgeInsets.zero,
                    child: item,
                  )
                : item;
          },
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2);
  }
}
