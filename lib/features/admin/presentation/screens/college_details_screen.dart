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
  late CollegeModel _college;
  List<DepartmentModel> _departments = [];
  bool _isLoadingDepts = true;

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
  void initState() {
    super.initState();
    _college = widget.college;
    _loadDepartments();
  }

  Future<void> _loadDepartments() async {
    setState(() => _isLoadingDepts = true);
    try {
      final repo = ref.read(institutionalRepositoryProvider);
      final depts = await repo.getDepartments(collegeId: _college.id);
      if (mounted) {
        setState(() {
          _departments = depts;
          _isLoadingDepts = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingDepts = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final themeColor = _getCollegeTheme(_college.id);

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
        body: RefreshIndicator(
          onRefresh: _loadDepartments,
          color: themeColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(isArabic, themeColor),
                const SizedBox(height: 32),
                _buildDeanSection(isArabic, themeColor),
                const SizedBox(height: 32),
                _buildFacultyStaffSection(isArabic, themeColor),
                const SizedBox(height: 32),
                _buildDepartmentsHeader(isArabic, themeColor),
                const SizedBox(height: 16),
                _buildDepartmentsList(isArabic, themeColor),
              ],
            ),
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
                        Icon(
                          LucideIcons.graduationCap,
                          size: 16,
                          color: themeColor,
                        ),
                        SizedBox(width: 8),
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
                  if (_college.code != null) ...[
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
                        _college.code!,
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
                isArabic ? _college.nameAr : _college.nameEn,
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 12),
              Text(
                (isArabic ? _college.descriptionAr : _college.descriptionEn) ??
                    (t.admin.no_description_available),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Stats row
              Row(
                children: [
                  _buildStatChip(
                    LucideIcons.layoutGrid,
                    '${_departments.length}',
                    t.extracted.departments,
                    themeColor,
                  ),
                  const SizedBox(width: 12),
                  _buildStatChip(
                    LucideIcons.users,
                    '${_college.studentCount}',
                    t.extracted.students,
                    Colors.cyanAccent,
                  ),
                  if (_college.established != null) ...[
                    const SizedBox(width: 12),
                    _buildStatChip(
                      LucideIcons.calendar,
                      '${_college.established}',
                      t.extracted.est,
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

  Widget _buildDeanSection(bool isArabic, Color themeColor) {
    if (_college.deanId == null) {
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
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
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
          (u) => u.id == _college.deanId,
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
              SizedBox(height: 16),
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
                  SizedBox(width: 20),
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
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.mail,
                              size: 14,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                dean.email,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
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
      error: (e, s) => Text('Error loading dean: $e'),
    );
  }

  Widget _buildFacultyStaffSection(bool isArabic, Color themeColor) {
    return FutureBuilder<List<UserProfileModel>>(
      future: ref
          .read(institutionalRepositoryProvider)
          .getStaffByCollege(_college.id),
      builder: (context, snapshot) {
        final staffCount =
            snapshot.connectionState == ConnectionState.done && snapshot.hasData
            ? snapshot.data!.length
            : 0;

        return GlassContainer(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(LucideIcons.users, color: Colors.cyanAccent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.admin.teaching_staff,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$staffCount ${t.extracted.faculty_members}',
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$staffCount',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.05);
      },
    );
  }

  Widget _buildDepartmentsHeader(bool isArabic, Color themeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              t.admin.academic_departments_1,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${_departments.length}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(LucideIcons.plusCircle, color: themeColor),
              onPressed: () => _showAddDepartmentDialog(isArabic, themeColor),
              tooltip: t.extracted.add_department,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDepartmentsList(bool isArabic, Color themeColor) {
    if (_isLoadingDepts) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_departments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(
                LucideIcons.layoutGrid,
                size: 64,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
              ),
              SizedBox(height: 16),
              Text(
                t.admin.no_departments_in_this_college,
                style: GoogleFonts.inter(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _showAddDepartmentDialog(isArabic, themeColor),
                icon: const Icon(LucideIcons.plus, size: 18),
                label: Text(t.extracted.add_department),
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
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _departments.length,
      itemBuilder: (context, index) {
        final dept = _departments[index];
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
                SizedBox(width: 16),
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
                      SizedBox(height: 4),
                      Row(
                        children: [
                          if (dept.code != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                dept.code!,
                                style: GoogleFonts.firaCode(
                                  fontSize: 10,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Text(
                              (isArabic
                                      ? dept.descriptionAr
                                      : dept.descriptionEn) ??
                                  '',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (dept.headId != null)
                      Icon(
                        LucideIcons.checkCircle2,
                        size: 16,
                        color: Colors.greenAccent.withValues(alpha: 0.7),
                      )
                    else
                      Icon(
                        LucideIcons.alertCircle,
                        size: 16,
                        color: Colors.orangeAccent.withValues(alpha: 0.7),
                      ),
                    SizedBox(height: 4),
                    Icon(
                      isArabic
                          ? LucideIcons.chevronLeft
                          : LucideIcons.chevronRight,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: (400 + index * 100).ms).slideY(begin: 0.1);
      },
    );
  }

  // ─── Dialogs ───────────────────────────────────────────────

  void _showAssignDeanDialog(bool isArabic, Color themeColor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            t.admin.assign_dean,
            style: GoogleFonts.outfit(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: _DeanSelectionList(
              college: _college,
              themeColor: themeColor,
              onDeanSelected: (deanId) async {
                final repo = ref.read(institutionalRepositoryProvider);
                await repo.updateCollege(_college.id, {'dean_id': deanId});
                if (!context.mounted) return;
                Navigator.pop(context);
                // Reload college data
                final updated = await repo.getCollegeById(_college.id);
                setState(() => _college = updated);
              },
            ),
          ),
        );
      },
    );
  }

  void _showAddDepartmentDialog(bool isArabic, Color themeColor) {
    final nameEnController = TextEditingController();
    final nameArController = TextEditingController();
    final codeController = TextEditingController();
    final descController = TextEditingController();

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
              Icon(LucideIcons.layoutGrid, color: themeColor, size: 22),
              SizedBox(width: 10),
              Text(
                t.extracted.add_new_department,
                style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  nameEnController,
                  t.extracted.department_name_en,
                  LucideIcons.type,
                  themeColor,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  nameArController,
                  t.extracted.department_name_ar,
                  LucideIcons.type,
                  themeColor,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  codeController,
                  t.extracted.department_code,
                  LucideIcons.hash,
                  themeColor,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  descController,
                  t.extracted.description,
                  LucideIcons.alignLeft,
                  themeColor,
                  maxLines: 3,
                ),
              ],
            ),
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
                if (nameEnController.text.isEmpty ||
                    nameArController.text.isEmpty ||
                    codeController.text.isEmpty) {
                  return;
                }
                final repo = ref.read(institutionalRepositoryProvider);
                await repo.createDepartment({
                  'college_id': _college.id,
                  'name': nameEnController.text,
                  'name_en': nameEnController.text,
                  'name_ar': nameArController.text,
                  'code': codeController.text,
                  'description': descController.text,
                  'description_ar': descController.text,
                });
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
                _loadDepartments();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(t.extracted.add),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    Color themeColor, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.inter(color: Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(color: Colors.white54, fontSize: 13),
        prefixIcon: Icon(icon, size: 18, color: themeColor),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeColor),
        ),
      ),
    );
  }
}

// ─── Dean Selection List ─────────────────────────────────────

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
