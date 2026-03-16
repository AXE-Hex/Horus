import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/academic/data/models/professor_profile_models.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/enrollment/presentation/providers/advisor_provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class ProfessorDashboardScreen extends HookConsumerWidget {
  final ProfessorProfile profile;

  const ProfessorDashboardScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(professorProfileProvider);
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return const Center(child: Text('Profile not found'));
        }

        final body = CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _ImmersiveHeader(profile: profile, isArabic: isArabic),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 24),
                  _BentoStatsGrid(profile: profile, isArabic: isArabic),
                  if (profile.announcements.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _SectionHeader(
                      title: 'Announcements',
                      onTap: () {},
                      isArabic: isArabic,
                    ),
                    const SizedBox(height: 16),
                    _AnnouncementsList(profile: profile, isArabic: isArabic),
                  ],
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: t.academic.course_management,
                    onTap: () => context.push('/manage-groups', extra: profile),
                    isArabic: isArabic,
                  ),
                  const SizedBox(height: 16),
                  _GroupsBentoList(profile: profile, isArabic: isArabic),
                  const SizedBox(height: 32),
                  _QuickActionsPanel(profile: profile, isArabic: isArabic),
                  const SizedBox(height: 32),
                  _ManagementGrid(profile: profile, isArabic: isArabic),
                ]),
              ),
            ),
          ],
        );

        return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

class _ImmersiveHeader extends StatelessWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _ImmersiveHeader({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6366F1),
                    const Color(0xFF4F46E5),
                    const Color(0xFF4338CA),
                  ],
                ),
              ),
            ),
            Positioned(
              right: isArabic ? null : -50,
              left: isArabic ? -50 : null,
              top: -50,
              child: Opacity(
                opacity: 0.1,
                child: Icon(LucideIcons.brain, size: 300, color: Colors.white),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.greenAccent.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Colors.greenAccent,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .scale(
                                    begin: const Offset(1, 1),
                                    end: const Offset(1.5, 1.5),
                                    duration: 800.ms,
                                    curve: Curves.easeInOut,
                                  )
                                  .then()
                                  .scale(
                                    begin: const Offset(1.5, 1.5),
                                    end: const Offset(1, 1),
                                  ),
                              const SizedBox(width: 6),
                              Text(
                                t.academic.live_now,
                                style: GoogleFonts.shareTechMono(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      t.professor.welcome_back_name(
                        name: profile.name.split(' ').first,
                      ),
                      style: GoogleFonts.outfit(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      profile.department,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BentoStatsGrid extends StatelessWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _BentoStatsGrid({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final totalStudents = profile.groups.fold<int>(
      0,
      (sum, g) => sum + g.studentCount,
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _BentoCard(
                title: t.academic.total_students,
                value: totalStudents.toString(),
                icon: LucideIcons.users,
                color: const Color(0xFF6366F1),
                subtitle: t.academic.across_all_groups,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _BentoCard(
                title: t.academic.rating,
                value: profile.generalRating.toString(),
                icon: LucideIcons.star,
                color: Colors.amber,
                isSmall: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _BentoCard(
                title: t.academic.tas,
                value: profile.teachingAssistants.length.toString(),
                icon: LucideIcons.graduationCap,
                color: const Color(0xFF10B981),
                isSmall: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: _BentoCard(
                title: t.academic.office_hours,
                value: profile.officeHours.length.toString(),
                icon: LucideIcons.clock,
                color: const Color(0xFFEC4899),
                subtitle: t.academic.sessions_this_week,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}

class _BentoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final bool isSmall;

  const _BentoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(20),
      border: Border.all(color: color.withValues(alpha: 0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.shareTechMono(
              fontSize: isSmall ? 28 : 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: GoogleFonts.outfit(fontSize: 10, color: Colors.white38),
            ),
          ],
        ],
      ),
    );
  }
}

class _GroupsBentoList extends StatelessWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _GroupsBentoList({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: profile.groups.map((group) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      group.name.substring(0, 1),
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${group.studentCount} ${t.academic.students}',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isArabic ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
                  color: Colors.white24,
                  size: 20,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }
}

class _AnnouncementsList extends StatelessWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _AnnouncementsList({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: profile.announcements.take(2).map((announcement) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        announcement.title,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (announcement.isUrgent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.redAccent.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          t.academic.urgent_news,
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  announcement.content,
                  style: GoogleFonts.outfit(fontSize: 14, color: Colors.white70),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(LucideIcons.calendar, size: 14, color: Colors.white38),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat(
                        t.extracted.mmm_dd_yyyy,
                      ).format(announcement.date),
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _QuickActionsPanel extends HookConsumerWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _QuickActionsPanel({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.academic.quick_actions,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.megaphone,
                label: t.academic.urgent_news,
                color: Colors.redAccent,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.uploadCloud,
                label: t.academic.upload_files,
                color: Colors.blueAccent,
                onTap: () => _showUploadDialog(context, ref, profile),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.messageCircle,
                label: t.academic.messages,
                color: Colors.tealAccent,
                onTap: () => context.push('/professor-chat', extra: profile),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showUploadDialog(
    BuildContext context,
    WidgetRef ref,
    ProfessorProfile profile,
  ) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          t.academic.upload_new_file,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: t.academic.file_title,
                labelStyle: const TextStyle(color: Colors.white60),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white10),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6366F1)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t.academic.file_will_be_uploaded_to_cloud,
              style: GoogleFonts.outfit(fontSize: 12, color: Colors.white24),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              t.academic.cancel,
              style: const TextStyle(color: Colors.white60),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              if (titleController.text.isEmpty) return;
              await ref
                  .read(professorRepositoryProvider)
                  .uploadSharedFile(
                    professorId: profile.id,
                    title: titleController.text,
                    filePath: 'mock_path.pdf',
                    fileName: 'document.pdf',
                  );
              if (!context.mounted) return;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF6366F1),
                  content: Text(t.academic.uploaded_successfully),
                ),
              );
            },
            child: Text(
              t.academic.upload,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ManagementGrid extends ConsumerWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _ManagementGrid({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final role = auth.role;
    final roles = auth.user?.userMetadata?['roles'] as List<dynamic>? ?? [];
    final collegeId = auth.user?.userMetadata?['college_id'] as String? ?? '';
    
    final isAdvisor = roles.contains('academic_advisor');
    final isDean = role == UserRole.dean || role == UserRole.superAdmin;

    final pendingRequestsCount = ref.watch(pendingRequestCountProvider);
    final unassignedStudentsCount = ref.watch(unassignedStudentsCountProvider(collegeId));

    return Column(
      children: [
        if (isAdvisor) ...[
          _ManagementRow(
            icon: LucideIcons.checkSquare,
            title: t.academic.registration_requests,
            count: pendingRequestsCount.value ?? 0,
            color: Colors.greenAccent,
            onTap: () => context.push('/advisor-approval'),
            isArabic: isArabic,
            hideCount: false,
          ),
          const SizedBox(height: 12),
        ],
        if (isDean) ...[
          _ManagementRow(
            icon: LucideIcons.userPlus,
            title: t.academic.advisor_assignment,
            count: unassignedStudentsCount.value ?? 0,
            color: Colors.orangeAccent,
            onTap: () => context.push('/dean-assignment'),
            isArabic: isArabic,
            hideCount: false,
          ),
          const SizedBox(height: 12),
        ],

        _ManagementRow(
          icon: LucideIcons.users,
          title: t.academic.manage_tas,
          count: profile.teachingAssistants.length,
          color: const Color(0xFF6366F1),
          onTap: () => context.push('/manage-tas', extra: profile),
          isArabic: isArabic,
        ),
        const SizedBox(height: 12),
        _ManagementRow(
          icon: LucideIcons.folderKey,
          title: t.academic.shared_files,
          count: profile.sharedFiles.length,
          color: const Color(0xFFF59E0B),
          onTap: () {},
          isArabic: isArabic,
        ),
      ],
    );
  }
}

class _ManagementRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final Color color;
  final VoidCallback onTap;
  final bool isArabic;
  final bool hideCount;

  const _ManagementRow({
    required this.icon,
    required this.title,
    required this.count,
    required this.color,
    required this.onTap,
    required this.isArabic,
    this.hideCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            if (!hideCount)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count.toString(),
                  style: GoogleFonts.shareTechMono(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            const SizedBox(width: 12),

            Icon(
              isArabic ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
              color: Colors.white24,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isArabic;

  const _SectionHeader({
    required this.title,
    required this.onTap,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            t.academic.view_all,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6366F1),
            ),
          ),
        ),
      ],
    );
  }
}
