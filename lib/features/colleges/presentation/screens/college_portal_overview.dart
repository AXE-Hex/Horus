part of 'college_portal_screen.dart';

extension _CollegePortalOverview on _CollegePortalScreenState {
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
        onPressed: () => context.backToHorus(),
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
    final statsAsync = ref.watch(legacyCollegeStatsProvider(college.id));

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
                stats['students']?.toString() ?? '—',
                LucideIcons.users,
                color,
                isGlass,
                itemWidth,
                0,
              ),
              _buildStatItem(
                'academic_staff',
                stats['faculty']?.toString() ?? '—',
                LucideIcons.userCheck,
                color,
                isGlass,
                itemWidth,
                1,
              ),
              _buildStatItem(
                'teaching_assistants',
                stats['assistants']?.toString() ?? '—',
                LucideIcons.graduationCap,
                color,
                isGlass,
                itemWidth,
                2,
              ),
              _buildStatItem(
                'published_articles',
                stats['research']?.toString() ?? '—',
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
                '—',
                LucideIcons.users,
                color,
                isGlass,
                itemWidth,
                0,
              ),
              _buildStatItem(
                'academic_staff',
                '—',
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
}
