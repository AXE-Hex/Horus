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

class DepartmentDetailsScreen extends ConsumerStatefulWidget {
  final DepartmentModel department;

  const DepartmentDetailsScreen({super.key, required this.department});

  @override
  ConsumerState<DepartmentDetailsScreen> createState() =>
      _DepartmentDetailsScreenState();
}

class _DepartmentDetailsScreenState
    extends ConsumerState<DepartmentDetailsScreen> {
  late DepartmentModel _department;
  List<UserProfileModel> _staffList = [];
  bool _isLoadingStaff = true;

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
  void initState() {
    super.initState();
    _department = widget.department;
    _loadStaff();
  }

  Future<void> _loadStaff() async {
    setState(() => _isLoadingStaff = true);
    try {
      final repo = ref.read(institutionalRepositoryProvider);
      final staff = await repo.getStaffByDepartment(_department.id);
      if (mounted) {
        setState(() {
          _staffList = staff;
          _isLoadingStaff = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingStaff = false);
    }
  }

  Future<void> _reloadDepartment() async {
    try {
      final repo = ref.read(institutionalRepositoryProvider);
      final dept = await repo.getDepartmentById(_department.id);
      if (mounted) setState(() => _department = dept);
    } catch (_) {}
    await _loadStaff();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final themeColor = _getDepartmentTheme(_department.id);

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
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.refreshCw, size: 20),
              onPressed: _reloadDepartment,
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _reloadDepartment,
          color: themeColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(isArabic, themeColor),
                const SizedBox(height: 32),
                _buildHeadSection(isArabic, themeColor),
                const SizedBox(height: 24),
                _buildAssistantHeadSection(isArabic, themeColor),
                const SizedBox(height: 32),
                _buildStaffSection(isArabic, themeColor),
                const SizedBox(height: 32),
                _buildProjectsSection(isArabic, themeColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Header ─────────────────────────────────────────────────

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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: themeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: themeColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.network, size: 16, color: themeColor),
                        SizedBox(width: 8),
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
                  if (_department.code != null) ...[
                    SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _department.code!,
                        style: GoogleFonts.firaCode(
                          fontSize: 11,
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 20),
              Text(
                isArabic ? _department.nameAr : _department.nameEn,
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 12),
              Text(
                (isArabic
                        ? _department.descriptionAr
                        : _department.descriptionEn) ??
                    (t.admin.no_about_text_available),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildStatChip(
                    LucideIcons.users,
                    '${_staffList.length}',
                    t.extracted.staff,
                    themeColor,
                  ),
                  const SizedBox(width: 12),
                  _buildStatChip(
                    LucideIcons.graduationCap,
                    '${_department.studentCount}',
                    t.extracted.students,
                    Colors.cyanAccent,
                  ),
                  if (_department.building != null) ...[
                    const SizedBox(width: 12),
                    _buildStatChip(
                      LucideIcons.building,
                      _department.building!,
                      t.extracted.building,
                      Colors.amberAccent,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.05);
  }

  Widget _buildStatChip(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: color.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Head of Department ─────────────────────────────────────

  Widget _buildHeadSection(bool isArabic, Color themeColor) {
    return _buildLeaderCard(
      title: t.admin.head_of_department,
      emptyTitle: t.admin.no_head_assigned,
      emptySubtitle: t.admin.please_assign_a_head_for_the_d,
      assignLabel: t.admin.assign,
      changeLabel: t.admin.change,
      userId: _department.headId,
      themeColor: themeColor,
      isArabic: isArabic,
      icon: LucideIcons.crown,
      onAssign: (userId) async {
        final repo = ref.read(institutionalRepositoryProvider);
        await repo.updateDepartment(_department.id, {'hod_id': userId});
        await _reloadDepartment();
      },
    );
  }

  // ─── Assistant Head ─────────────────────────────────────────

  Widget _buildAssistantHeadSection(bool isArabic, Color themeColor) {
    return _buildLeaderCard(
      title: t.extracted.assistant_head,
      emptyTitle: t.extracted.no_assistant_assigned,
      emptySubtitle: t.extracted.please_assign_an_assistant_head_for_the_,
      assignLabel: t.admin.assign,
      changeLabel: t.admin.change,
      userId: _department.assistantHeadId,
      themeColor: Colors.tealAccent,
      isArabic: isArabic,
      icon: LucideIcons.shield,
      onAssign: (userId) async {
        final repo = ref.read(institutionalRepositoryProvider);
        await repo.updateDepartment(_department.id, {
          'assistant_hod_id': userId,
        });
        await _reloadDepartment();
      },
    );
  }

  /// Reusable card for head/assistant head
  Widget _buildLeaderCard({
    required String title,
    required String emptyTitle,
    required String emptySubtitle,
    required String assignLabel,
    required String changeLabel,
    required String? userId,
    required Color themeColor,
    required bool isArabic,
    required IconData icon,
    required Future<void> Function(String) onAssign,
  }) {
    if (userId == null) {
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
              child: Icon(LucideIcons.userX, color: Colors.orangeAccent),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    emptyTitle,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    emptySubtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _showUserSelectionDialog(
                title: title,
                themeColor: themeColor,
                currentUserId: null,
                onSelected: onAssign,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(assignLabel),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05);
    }

    final usersAsync = ref.watch(usersControllerProvider());

    return usersAsync.when(
      data: (users) {
        final leader = users.firstWhere(
          (u) => u.id == userId,
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
                  Row(
                    children: [
                      Icon(icon, size: 16, color: themeColor),
                      SizedBox(width: 8),
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => _showUserSelectionDialog(
                      title: title,
                      themeColor: themeColor,
                      currentUserId: userId,
                      onSelected: onAssign,
                    ),
                    icon: Icon(
                      LucideIcons.refreshCw,
                      size: 16,
                      color: themeColor,
                    ),
                    label: Text(
                      changeLabel,
                      style: GoogleFonts.inter(color: themeColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: leader.avatarUrl != null
                        ? NetworkImage(leader.avatarUrl!)
                        : null,
                    backgroundColor: themeColor.withValues(alpha: 0.2),
                    child: leader.avatarUrl == null
                        ? Icon(LucideIcons.user, color: themeColor, size: 28)
                        : null,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leader.fullName,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.mail,
                              size: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                leader.email,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                                overflow: TextOverflow.ellipsis,
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
      error: (e, s) => Text('Error: $e'),
    );
  }

  // ─── Staff Section ──────────────────────────────────────────

  Widget _buildStaffSection(bool isArabic, Color themeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  t.admin.teaching_staff,
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: themeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_staffList.length}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(LucideIcons.userPlus, color: themeColor),
              onPressed: () => _showAddStaffDialog(themeColor),
              tooltip: t.extracted.add_staff,
            ),
          ],
        ),
        SizedBox(height: 16),
        if (_isLoadingStaff)
          Center(child: CircularProgressIndicator())
        else if (_staffList.isEmpty)
          GlassContainer(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    LucideIcons.users,
                    size: 48,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.1),
                  ),
                  SizedBox(height: 12),
                  Text(
                    t.extracted.no_faculty_members_assigned,
                    style: GoogleFonts.inter(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showAddStaffDialog(themeColor),
                    icon: const Icon(LucideIcons.plus, size: 16),
                    label: Text(t.extracted.add_faculty),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _staffList.length,
            itemBuilder: (context, index) {
              final staff = _staffList[index];
              final isHead = staff.id == _department.headId;
              final isAssistant = staff.id == _department.assistantHeadId;

              return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(16),
                      borderRadius: BorderRadius.circular(16),
                      border: isHead || isAssistant
                          ? Border.all(color: themeColor.withValues(alpha: 0.3))
                          : null,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: staff.avatarUrl != null
                                ? NetworkImage(staff.avatarUrl!)
                                : null,
                            backgroundColor: themeColor.withValues(alpha: 0.15),
                            child: staff.avatarUrl == null
                                ? Icon(
                                    LucideIcons.user,
                                    size: 20,
                                    color: themeColor,
                                  )
                                : null,
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        staff.fullName,
                                        style: GoogleFonts.outfit(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isHead) ...[
                                      SizedBox(width: 8),
                                      _buildRoleBadge(
                                        t.extracted.head,
                                        themeColor,
                                      ),
                                    ],
                                    if (isAssistant) ...[
                                      SizedBox(width: 8),
                                      _buildRoleBadge(
                                        t.extracted.asst,
                                        Colors.tealAccent,
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 2),
                                Text(
                                  staff.email,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.5),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          if (!isHead && !isAssistant)
                            IconButton(
                              icon: Icon(
                                LucideIcons.userMinus,
                                size: 18,
                                color: Colors.redAccent.withValues(alpha: 0.7),
                              ),
                              onPressed: () =>
                                  _confirmRemoveStaff(staff, themeColor),
                              tooltip: t.extracted.remove,
                            ),
                        ],
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: (300 + index * 80).ms)
                  .slideX(begin: 0.05);
            },
          ),
      ],
    );
  }

  Widget _buildRoleBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // ─── Projects Section ───────────────────────────────────────

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
              .getDepartmentProjects(_department.id),
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
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
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
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                project.status.toUpperCase(),
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if ((isArabic
                                    ? project.descriptionAr
                                    : project.descriptionEn) !=
                                null &&
                            (isArabic
                                    ? project.descriptionAr
                                    : project.descriptionEn)!
                                .isNotEmpty) ...[
                          SizedBox(height: 8),
                          Text(
                            (isArabic
                                ? project.descriptionAr
                                : project.descriptionEn)!,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                              height: 1.4,
                            ),
                          ),
                        ],
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

  // ─── Dialogs ────────────────────────────────────────────────

  void _showUserSelectionDialog({
    required String title,
    required Color themeColor,
    required String? currentUserId,
    required Future<void> Function(String) onSelected,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            title,
            style: GoogleFonts.outfit(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: _UserSelectionList(
              themeColor: themeColor,
              currentUserId: currentUserId,
              onSelected: (userId) async {
                await onSelected(userId);
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
              },
            ),
          ),
        );
      },
    );
  }

  void _showAddStaffDialog(Color themeColor) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Row(
            children: [
              Icon(LucideIcons.userPlus, color: themeColor, size: 22),
              SizedBox(width: 10),
              Text(
                t.extracted.add_faculty_member,
                style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: _UserSelectionList(
              themeColor: themeColor,
              currentUserId: null,
              excludeIds: _staffList.map((s) => s.id).toList(),
              onSelected: (userId) async {
                final repo = ref.read(institutionalRepositoryProvider);
                await repo.assignStaffToDepartment(
                  userId,
                  _department.id,
                  _department.collegeId,
                );
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
                await _loadStaff();
              },
            ),
          ),
        );
      },
    );
  }

  void _confirmRemoveStaff(UserProfileModel staff, Color themeColor) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            t.extracted.confirm_removal,
            style: GoogleFonts.outfit(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          content: Text(
            t.extracted.remove_stafffullname_from_this_department,
            style: GoogleFonts.inter(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                t.extracted.cancel,
                style: const TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final repo = ref.read(institutionalRepositoryProvider);
                await repo.removeStaffFromDepartment(staff.id);
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
                await _loadStaff();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(t.extracted.remove),
            ),
          ],
        );
      },
    );
  }
}

// ─── User Selection List ─────────────────────────────────────

class _UserSelectionList extends ConsumerWidget {
  final Color themeColor;
  final String? currentUserId;
  final List<String> excludeIds;
  final Function(String) onSelected;

  const _UserSelectionList({
    required this.themeColor,
    required this.currentUserId,
    this.excludeIds = const [],
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersControllerProvider());

    return usersAsync.when(
      data: (users) {
        final eligibleUsers = users
            .where(
              (u) => u.isActive && !u.isBanned && !excludeIds.contains(u.id),
            )
            .toList();

        if (eligibleUsers.isEmpty) {
          return Center(
            child: Text(
              t.$meta.locale.languageCode == 'ar'
                  ? 'لا يوجد مستخدمين متاحين'
                  : 'No available users',
              style: GoogleFonts.inter(color: Colors.white54),
            ),
          );
        }

        return ListView.builder(
          itemCount: eligibleUsers.length,
          itemBuilder: (context, index) {
            final user = eligibleUsers[index];
            final isCurrent = user.id == currentUserId;

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? Icon(LucideIcons.user, size: 20)
                    : null,
              ),
              title: Text(
                user.fullName,
                style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                user.email,
                style: GoogleFonts.inter(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
              trailing: isCurrent
                  ? Icon(LucideIcons.checkCircle, color: themeColor)
                  : ElevatedButton(
                      onPressed: () => onSelected(user.id),
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
