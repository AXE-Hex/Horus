import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/security/axe_fingerprint.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/academic/data/models/professor_profile_models.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class ProfessorProfileScreen extends ConsumerWidget {
  final ProfessorProfile profile;

  const ProfessorProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final color = theme.primaryColor;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildGlassSliverAppBar(context, isGlass, color),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildQuickActions(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildUrgentAnnouncements(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildTAsSection(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildGroupsSection(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildSharedFilesSection(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildOfficeHoursSection(context, isGlass, color, isArabic),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );

    return Semantics(
      identifier: AxeFingerprint.axeSignature,
      container: true,
      child: isGlass
          ? GlassScaffold(body: content)
          : Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              body: content,
            ),
    );
  }

  Widget _buildGlassSliverAppBar(
    BuildContext context,
    bool isGlass,
    Color color,
  ) {
    return GlassSliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: isGlass ? Colors.transparent : color,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(LucideIcons.chevronLeft, color: Colors.white),
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color, color.withValues(alpha: 0.6)],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'staff_${profile.name}',
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white24,
                      child: const Icon(
                        LucideIcons.user,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.name,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${profile.role} • ${profile.department}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildMiniTag(
                        LucideIcons.star,
                        '${profile.generalRating}',
                        Colors.amber,
                      ),
                      const SizedBox(width: 8),
                      _buildMiniTag(
                        LucideIcons.mapPin,
                        profile.officeSymbol,
                        Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniTag(IconData icon, String text, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildActionBtn(
            context,
            t.professor.message,
            LucideIcons.messageSquare,
            isGlass,
            color,
            isArabic,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionBtn(
            context,
            t.professor.stats.office_hours,
            LucideIcons.calendarClock,
            isGlass,
            Colors.teal,
            isArabic,
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildActionBtn(
    BuildContext context,
    String title,
    IconData icon,
    bool isGlass,
    Color baseColor,
    bool isArabic,
  ) {
    final block = Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isGlass ? null : baseColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: isGlass ? Colors.white : baseColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: isGlass ? Colors.white : baseColor,
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${isArabic ? "تم النقر:" : "Clicked:"} $title'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: isGlass
          ? GlassContainer(padding: EdgeInsets.zero, child: block)
          : block,
    );
  }

  Widget _buildUrgentAnnouncements(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.announcements.isEmpty) return const SizedBox.shrink();

    final urgentAnns = profile.announcements.where((a) => a.isUrgent).toList();
    if (urgentAnns.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          t.professor.profile.urgent_announcements,
          isGlass,
          context,
        ),
        const SizedBox(height: 12),
        ...urgentAnns.map((ann) {
          final block = Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  LucideIcons.alertCircle,
                  color: Colors.redAccent,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ann.title,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ann.content,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: isGlass ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMM dd, hh:mm a').format(ann.date),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: isGlass
                ? GlassContainer(
                    padding: EdgeInsets.zero,
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.3),
                    ),
                    child: block,
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.redAccent,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: block,
                  ),
          );
        }),
      ],
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildTAsSection(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.teachingAssistants.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          t.professor.profile.teaching_assistants,
          isGlass,
          context,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: profile.teachingAssistants.length,
            itemBuilder: (context, index) {
              final ta = profile.teachingAssistants[index];
              final block = Container(
                width: 130,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isGlass ? null : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isGlass
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                          ),
                        ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: color.withValues(alpha: 0.1),
                      child: Icon(LucideIcons.user, color: color),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ta.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isGlass ? Colors.white : null,
                      ),
                    ),
                    Text(
                      ta.role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: isGlass ? Colors.white60 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          t.professor.action_clicked(action: ta.name),
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: isGlass
                      ? GlassContainer(padding: EdgeInsets.zero, child: block)
                      : block,
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fadeIn();
  }

  Widget _buildGroupsSection(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.groups.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(t.professor.stats.groups, isGlass, context),
        const SizedBox(height: 12),
        ...profile.groups.map((group) {
          final block = ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(LucideIcons.users, color: color, size: 20),
            ),
            title: Text(
              group.name,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
            subtitle: Text(
              t.professor.total_students_count(count: group.studentCount),
              style: GoogleFonts.inter(
                fontSize: 12,
                color: isGlass ? Colors.white60 : Colors.grey,
              ),
            ),
            trailing: group.isJoined
                ? const Icon(LucideIcons.checkCircle2, color: Colors.green)
                : OutlinedButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${isArabic ? "تم الانضمام:" : "Joined:"} ${group.name}',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isGlass ? Colors.white : color,
                      side: BorderSide(color: isGlass ? Colors.white30 : color),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(t.professor.join),
                  ),
          );

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: isGlass
                ? GlassContainer(padding: EdgeInsets.zero, child: block)
                : Card(child: block),
          );
        }),
      ],
    ).animate().fadeIn();
  }

  Widget _buildSharedFilesSection(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.sharedFiles.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          t.professor.profile.shared_resources,
          isGlass,
          context,
        ),
        const SizedBox(height: 12),
        ...profile.sharedFiles.map((file) {
          final block = ListTile(
            onTap: () {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${t.professor.quick_actions.action_clicked}: ${file.title}',
                  ),
                ),
              );
            },
            leading: Icon(
              file.fileType == 'pdf' ? LucideIcons.fileText : LucideIcons.file,
              color: file.fileType == 'pdf'
                  ? Colors.redAccent
                  : Colors.blueAccent,
            ),
            title: Text(
              file.title,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isGlass ? Colors.white : null,
              ),
            ),
            subtitle: Text(
              '${file.fileType.toUpperCase()} • ${file.size}',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: isGlass ? Colors.white60 : Colors.grey,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                LucideIcons.download,
                color: isGlass ? Colors.white70 : Colors.black54,
              ),
              onPressed: () {
                HapticFeedback.selectionClick();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.professor.downloading),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: isGlass
                ? GlassContainer(padding: EdgeInsets.zero, child: block)
                : Card(child: block),
          );
        }),
      ],
    ).animate().fadeIn();
  }

  Widget _buildOfficeHoursSection(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.officeHours.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(t.professor.profile.office_hours, isGlass, context),
        const SizedBox(height: 12),
        ...profile.officeHours.map((oh) {
          final block = Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        oh.dayOfWeek,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isGlass ? Colors.white : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        oh.timeRange,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.mapPin,
                            size: 12,
                            color: isGlass ? Colors.white60 : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            oh.location,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: isGlass ? Colors.white60 : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (oh.isWalkIn)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      t.professor.walk_in,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          );

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: isGlass
                ? GlassContainer(padding: EdgeInsets.zero, child: block)
                : Card(child: block),
          );
        }),
      ],
    ).animate().fadeIn();
  }

  Widget _buildSectionTitle(String title, bool isGlass, BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isGlass ? Colors.white : Theme.of(context).primaryColor,
      ),
    );
  }
}
