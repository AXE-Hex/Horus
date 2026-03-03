import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

class CollegeDetailsScreen extends ConsumerStatefulWidget {
  final CollegeModel college;

  const CollegeDetailsScreen({super.key, required this.college});

  @override
  ConsumerState<CollegeDetailsScreen> createState() =>
      _CollegeDetailsScreenState();
}

class _CollegeDetailsScreenState extends ConsumerState<CollegeDetailsScreen> {
  // Simple mapping for themes based on college ID hash
  Color _getCollegeTheme(String id) {
    final colors = [
      Colors.blueAccent,
      Colors.purpleAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.tealAccent,
      Colors.pinkAccent,
      Colors.indigoAccent,
    ];
    final index = id.hashCode % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final themeColor = _getCollegeTheme(widget.college.id);

    return Theme(
      data: Theme.of(context).copyWith(primaryColor: themeColor),
      child: GlassScaffold(
        appBar: AppBar(
          title: Text(
            t.admin.college_details,
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
              _buildDeanSection(isArabic, themeColor),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.admin.academic_departments_1,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.plusCircle, color: themeColor),
                    onPressed: () {
                      context.push(
                        '/admin/departments',
                        extra: {'collegeId': widget.college.id},
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDepartmentsList(isArabic, themeColor),
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
              LucideIcons.building2,
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
                    Icon(
                      LucideIcons.graduationCap,
                      size: 16,
                      color: themeColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t.admin.college,
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
                isArabic ? widget.college.nameAr : widget.college.nameEn,
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                (isArabic
                        ? widget.college.descriptionAr
                        : widget.college.descriptionEn) ??
                    (t.admin.no_description_available),
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

  Widget _buildDeanSection(bool isArabic, Color themeColor) {
    if (widget.college.deanId == null) {
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
                    t.admin.no_dean_assigned,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    t.admin.please_assign_a_dean_for_the_c,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _showAssignDeanDialog(isArabic, themeColor),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(t.admin.assign_dean),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05);
    }

    final usersAsync = ref.watch(usersControllerProvider());

    return usersAsync.when(
      data: (users) {
        final dean = users.firstWhere(
          (u) => u.id == widget.college.deanId,
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
                    t.admin.college_dean,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        _showAssignDeanDialog(isArabic, themeColor),
                    icon: Icon(
                      LucideIcons.refreshCw,
                      size: 16,
                      color: themeColor,
                    ),
                    label: Text(
                      t.admin.change_dean,
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
                    backgroundImage: dean.avatarUrl != null
                        ? NetworkImage(dean.avatarUrl!)
                        : null,
                    backgroundColor: themeColor.withValues(alpha: 0.2),
                    child: dean.avatarUrl == null
                        ? Icon(LucideIcons.user, color: themeColor, size: 30)
                        : null,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dean.fullName,
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
                              dean.email,
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
      error: (e, s) => Text('Error loading dean: $e'),
    );
  }

  Widget _buildDepartmentsList(bool isArabic, Color themeColor) {
    return FutureBuilder<List<DepartmentModel>>(
      future: ref
          .read(institutionalRepositoryProvider)
          .getDepartments(collegeId: widget.college.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final departments = snapshot.data ?? [];

        if (departments.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(
                    LucideIcons.layoutGrid,
                    size: 64,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.admin.no_departments_in_this_college,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: departments.length,
          itemBuilder: (context, index) {
            final dept = departments[index];
            return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassContainer(
                    onTap: () {
                      context.push('/admin/departments/details', extra: dept);
                    },
                    padding: const EdgeInsets.all(20),
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: themeColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(LucideIcons.component, color: themeColor),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isArabic ? dept.nameAr : dept.nameEn,
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                (isArabic
                                        ? dept.descriptionAr
                                        : dept.descriptionEn) ??
                                    '',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Colors.white.withValues(alpha: 0.5),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isArabic
                              ? LucideIcons.chevronLeft
                              : LucideIcons.chevronRight,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: (400 + index * 100).ms)
                .slideY(begin: 0.1);
          },
        );
      },
    );
  }

  void _showAssignDeanDialog(bool isArabic, Color themeColor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E2E), // Example dark modern bg
          title: Text(
            t.admin.assign_dean,
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: _DeanSelectionList(
              college: widget.college,
              themeColor: themeColor,
              onDeanSelected: (deanId) async {
                final repo = ref.read(institutionalRepositoryProvider);
                await repo.updateCollege(widget.college.id, {
                  'dean_id': deanId,
                });
                if (!context.mounted) return;
                Navigator.pop(context);
                setState(() {}); // Refresh screen to show new dean
              },
            ),
          ),
        );
      },
    );
  }
}

class _DeanSelectionList extends ConsumerWidget {
  final CollegeModel college;
  final Color themeColor;
  final Function(String) onDeanSelected;

  const _DeanSelectionList({
    required this.college,
    required this.themeColor,
    required this.onDeanSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersControllerProvider());

    return usersAsync.when(
      data: (users) {
        // Filter users who might be eligible for Dean (simplified logic, usually would check roles)
        final staffUsers = users
            .where((u) => u.isActive && !u.isBanned)
            .toList();

        return ListView.builder(
          itemCount: staffUsers.length,
          itemBuilder: (context, index) {
            final user = staffUsers[index];
            final isCurrentDean = user.id == college.deanId;

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
              trailing: isCurrentDean
                  ? Icon(LucideIcons.checkCircle, color: themeColor)
                  : ElevatedButton(
                      onPressed: () => onDeanSelected(user.id),
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
