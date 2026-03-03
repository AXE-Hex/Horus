import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/data/repositories/institutional_repository.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/features/admin/presentation/providers/users_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:timeago/timeago.dart' as timeago;

class DepartmentDetailsScreen extends ConsumerStatefulWidget {
  final DepartmentModel department;

  const DepartmentDetailsScreen({super.key, required this.department});

  @override
  ConsumerState<DepartmentDetailsScreen> createState() =>
      _DepartmentDetailsScreenState();
}

class _DepartmentDetailsScreenState
    extends ConsumerState<DepartmentDetailsScreen> {
  // Simple mapping for themes based on department ID hash
  Color _getDepartmentTheme(String id) {
    final colors = [
      Colors.cyanAccent,
      Colors.deepOrangeAccent,
      Colors.lightGreenAccent,
      Colors.amberAccent,
      Colors.pinkAccent,
      Colors.deepPurpleAccent,
    ];
    final index = id.hashCode % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final themeColor = _getDepartmentTheme(widget.department.id);

    return Theme(
      data: Theme.of(context).copyWith(primaryColor: themeColor),
      child: GlassScaffold(
        appBar: AppBar(
          title: Text(
            t.admin.department_details,
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(isArabic, themeColor),
              const SizedBox(height: 32),
              _buildHeadSection(isArabic, themeColor),
              const SizedBox(height: 32),
              _buildProjectsSection(isArabic, themeColor),
              const SizedBox(height: 32),
              _buildStaffSection(isArabic, themeColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isArabic, Color themeColor) {
    return GlassContainer(
      padding: const EdgeInsets.all(32),
      borderRadius: BorderRadius.circular(32),
      child: Stack(
        children: [
          Positioned(
            right: isArabic ? null : -20,
            left: isArabic ? -20 : null,
            top: -20,
            child: Icon(
              LucideIcons.component,
              size: 120,
              color: themeColor.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: themeColor.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.network, size: 16, color: themeColor),
                    const SizedBox(width: 8),
                    Text(
                      t.admin.academic_department,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isArabic ? widget.department.nameAr : widget.department.nameEn,
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                (isArabic
                        ? widget.department.descriptionAr
                        : widget.department.descriptionEn) ??
                    (t.admin.no_about_text_available),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.05);
  }

  Widget _buildHeadSection(bool isArabic, Color themeColor) {
    if (widget.department.headId == null) {
      return GlassContainer(
        padding: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(24),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.userX, color: Colors.orangeAccent),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.admin.no_head_assigned,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    t.admin.please_assign_a_head_for_the_d,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _showAssignHeadDialog(isArabic, themeColor),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(t.admin.assign),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05);
    }

    final usersAsync = ref.watch(usersControllerProvider());

    return usersAsync.when(
      data: (users) {
        final head = users.firstWhere(
          (u) => u.id == widget.department.headId,
          orElse: () => UserProfileModel(
            id: 'unknown',
            email: 'unknown',
            fullName: 'Unknown User',
            isActive: false,
            isBanned: false,
            isVerified: false,
            roles: [],
            createdAt: DateTime.now(),
          ),
        );

        return GlassContainer(
          padding: const EdgeInsets.all(24),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: themeColor.withValues(alpha: 0.2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.admin.head_of_department,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        _showAssignHeadDialog(isArabic, themeColor),
                    icon: Icon(
                      LucideIcons.refreshCw,
                      size: 16,
                      color: themeColor,
                    ),
                    label: Text(
                      t.admin.change,
                      style: GoogleFonts.inter(color: themeColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: head.avatarUrl != null
                        ? NetworkImage(head.avatarUrl!)
                        : null,
                    backgroundColor: themeColor.withValues(alpha: 0.2),
                    child: head.avatarUrl == null
                        ? Icon(LucideIcons.user, color: themeColor, size: 30)
                        : null,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          head.fullName,
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.mail,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              head.email,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Text('Error loading head: $e'),
    );
  }

  Widget _buildProjectsSection(bool isArabic, Color themeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.admin.department_projects,
          style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<DepartmentProjectModel>>(
          future: ref
              .read(institutionalRepositoryProvider)
              .getDepartmentProjects(widget.department.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final projects = snapshot.data ?? [];

            if (projects.isEmpty) {
              return GlassContainer(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    t.admin.no_projects_added_yet,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(20),
                    borderRadius: BorderRadius.circular(16),
                    border: Border(
                      left: BorderSide(
                        color: project.status == 'completed'
                            ? Colors.green
                            : project.status == 'active'
                            ? themeColor
                            : Colors.grey,
                        width: 4,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                isArabic ? project.titleAr : project.titleEn,
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                project.status.toUpperCase(),
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          (isArabic
                                  ? project.descriptionAr
                                  : project.descriptionEn) ??
                              '',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.6),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.clock,
                              size: 12,
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              timeago.format(
                                project.createdAt,
                                locale: t.admin.en,
                              ),
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (400 + index * 100).ms).slideX();
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildStaffSection(bool isArabic, Color themeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.admin.teaching_staff,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(LucideIcons.users, color: themeColor),
              onPressed: () {
                // Future: Navigate to filtered staff list
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.admin.coming_soon),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Icon(
                LucideIcons.users,
                size: 32,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  t.admin.you_can_manage_professors_and_,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAssignHeadDialog(bool isArabic, Color themeColor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E2E), // Example dark modern bg
          title: Text(
            t.admin.assign_department_head,
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: _HeadSelectionList(
              department: widget.department,
              themeColor: themeColor,
              onHeadSelected: (headId) async {
                final repo = ref.read(institutionalRepositoryProvider);
                await repo.updateDepartment(widget.department.id, {
                  'head_id': headId,
                });
                if (!context.mounted) return;
                Navigator.pop(context);
                setState(() {}); // Refresh screen to show new head
              },
            ),
          ),
        );
      },
    );
  }
}

class _HeadSelectionList extends ConsumerWidget {
  final DepartmentModel department;
  final Color themeColor;
  final Function(String) onHeadSelected;

  const _HeadSelectionList({
    required this.department,
    required this.themeColor,
    required this.onHeadSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersControllerProvider());

    return usersAsync.when(
      data: (users) {
        // Filter users who might be eligible for Head
        final staffUsers = users
            .where((u) => u.isActive && !u.isBanned)
            .toList();

        return ListView.builder(
          itemCount: staffUsers.length,
          itemBuilder: (context, index) {
            final user = staffUsers[index];
            final isCurrentHead = user.id == department.headId;

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? const Icon(LucideIcons.user, size: 20)
                    : null,
              ),
              title: Text(
                user.fullName,
                style: GoogleFonts.outfit(color: Colors.white),
              ),
              subtitle: Text(
                user.email,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
              trailing: isCurrentHead
                  ? Icon(LucideIcons.checkCircle, color: themeColor)
                  : ElevatedButton(
                      onPressed: () => onHeadSelected(user.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor.withValues(alpha: 0.2),
                        foregroundColor: themeColor,
                        elevation: 0,
                      ),
                      child: Text(t.admin.select),
                    ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(
        child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
