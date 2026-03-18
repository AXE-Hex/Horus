import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StaffDashboardScreen extends ConsumerWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final auth = ref.watch(authControllerProvider);
    final role = auth.role;
    const d = Duration(milliseconds: 100);

    return GlassScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            _buildRoleBadge(context, isArabic, auth)
                .animate()
                .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

            const SizedBox(height: 32),

            if (role.isTeachingStaff ||
                role.isLeadership ||
                role == UserRole.superAdmin) ...[
              _buildSectionHeader(context, t.extracted.teaching)
                  .animate()
                  .fadeIn(delay: d)
                  .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
              const SizedBox(height: 12),
              _buildTeachingGrid(
                context,
                ref,
                role,
                isArabic,
              ).animate().fadeIn(delay: d * 2).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
            ],

            if (role.isLeadership || role == UserRole.superAdmin) ...[
              _buildSectionHeader(context, t.extracted.academic_leadership)
                  .animate()
                  .fadeIn(delay: d * 3)
                  .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
              const SizedBox(height: 12),
              _buildLeadershipGrid(
                context,
                role,
                isArabic,
              ).animate().fadeIn(delay: d * 4).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
            ],

            if (role == UserRole.registrarOfficer ||
                role == UserRole.academicAdvisor ||
                role == UserRole.librarian ||
                role == UserRole.superAdmin) ...[
              _buildSectionHeader(context, t.extracted.student_affairs)
                  .animate()
                  .fadeIn(delay: d * 5)
                  .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
              const SizedBox(height: 12),
              _buildStudentAffairsGrid(
                context,
                role,
                isArabic,
              ).animate().fadeIn(delay: d * 6).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
            ],

            if (role.isAdmin || role == UserRole.superAdmin) ...[
              _buildSectionHeader(context, t.extracted.administration)
                  .animate()
                  .fadeIn(delay: d * 7)
                  .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
              const SizedBox(height: 12),
              _buildAdminGrid(
                context,
                role,
                isArabic,
              ).animate().fadeIn(delay: d * 8).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
            ],

            _buildSectionHeader(context, t.students.utilities)
                .animate()
                .fadeIn(delay: d * 9)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            _buildUtilitiesRow(
              context,
              role,
              isArabic,
            ).animate().fadeIn(delay: d * 10).slideX(begin: 0.2, end: 0),

            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildTeachingGrid(
    BuildContext context,
    WidgetRef ref,
    UserRole role,
    bool isArabic,
  ) {
    final profileAsync = ref.watch(professorProfileProvider);
    final profile = profileAsync.value;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      padding: EdgeInsets.zero,
      children: [
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.manageGrades,
          icon: LucideIcons.clipboardList,
          title: t.extracted.manage_grades,
          onTap: () => context.push('/grades'),
          color: const Color(0xFF6366F1),
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.manageAttendance,
          icon: LucideIcons.userCheck,
          title: t.extracted.manage_attendance,
          onTap: () => context.push('/attendance'),
          color: const Color(0xFF10B981),
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.manageTAs,
          icon: LucideIcons.users,
          title: t.extracted.manage_tas,
          onTap: () {
            if (profile != null) {
              context.push('/manage-tas', extra: profile);
            } else {
              _showAccessDenied(context, t.extracted.loading_profile);
            }
          },
          color: const Color(0xFF8B5CF6),
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.manageGroups,
          icon: LucideIcons.layoutGrid,
          title: t.extracted.manage_groups,
          onTap: () {
            if (profile != null) {
              context.push('/manage-groups', extra: profile);
            } else {
              _showAccessDenied(context, t.extracted.loading_profile);
            }
          },
          color: const Color(0xFF0EA5E9),
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.uploadMaterials,
          icon: LucideIcons.upload,
          title: t.extracted.upload_materials,
          onTap: () {},
          color: const Color(0xFFF59E0B),
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.accessForums,
          icon: LucideIcons.messageCircle,
          title: t.extracted.professor_chat,
          onTap: () {
            if (profile != null) {
              context.push('/professor-chat', extra: profile);
            } else {
              _showAccessDenied(context, t.extracted.loading_profile);
            }
          },
          color: const Color(0xFFEC4899),
        ),
      ],
    );
  }

  Widget _buildLeadershipGrid(
    BuildContext context,
    UserRole role,
    bool isArabic,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      padding: EdgeInsets.zero,
      children: [
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageCourses,
          icon: LucideIcons.bookOpen,
          title: t.extracted.manage_courses,
          onTap: () => context.push('/courses'),
          color: const Color(0xFF6366F1),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageSchedules,
          icon: LucideIcons.calendarClock,
          title: t.extracted.manage_schedules,
          onTap: () => context.push('/schedule'),
          color: const Color(0xFF0EA5E9),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.approveEnrollments,
          icon: LucideIcons.checkSquare,
          title: t.extracted.approve_enrollments,
          onTap: () => context.push('/advisor-approval'),
          color: const Color(0xFF10B981),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.createAnnouncements,
          icon: LucideIcons.megaphone,
          title: t.extracted.announcements,
          onTap: () {},
          color: const Color(0xFFF59E0B),
        ),
      ],
    );
  }

  Widget _buildStudentAffairsGrid(
    BuildContext context,
    UserRole role,
    bool isArabic,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      padding: EdgeInsets.zero,
      children: [
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageEnrollments,
          icon: LucideIcons.fileText,
          title: t.extracted.manage_enrollments,
          onTap: () => context.push('/registration'),
          color: Colors.tealAccent,
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.adviseStudents,
          icon: LucideIcons.compass,
          title: t.extracted.academic_advising,
          onTap: () => context.push('/advisor-approval'),
          color: const Color(0xFF6366F1),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageLibrary,
          icon: LucideIcons.bookMarked,
          title: t.extracted.manage_library,
          onTap: () {},
          color: const Color(0xFF10B981),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.barChart2,
          title: t.extracted.student_records,
          onTap: () => context.push('/transcript'),
          color: Colors.orangeAccent,
        ),
      ],
    );
  }

  Widget _buildAdminGrid(BuildContext context, UserRole role, bool isArabic) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      padding: EdgeInsets.zero,
      children: [
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageUsers,
          icon: LucideIcons.users,
          title: t.extracted.manage_users,
          onTap: () => context.push('/admin/users'),
          color: const Color(0xFF6366F1),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageColleges,
          icon: LucideIcons.building2,
          title: t.extracted.manage_colleges,
          onTap: () => context.push('/admin/colleges'),
          color: const Color(0xFF0EA5E9),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageDepartments,
          icon: LucideIcons.layers,
          title: t.extracted.manage_departments,
          onTap: () => context.push('/admin/departments'),
          color: const Color(0xFF10B981),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.viewAuditLogs,
          icon: LucideIcons.fileSearch,
          title: t.extracted.audit_logs,
          onTap: () => context.push('/admin/audit-logs'),
          color: const Color(0xFFF59E0B),
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageUsers,
          icon: LucideIcons.shield,
          title: t.extracted.manage_roles,
          onTap: () => context.push('/admin/roles'),
          color: Colors.redAccent,
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.manageFinances,
          icon: LucideIcons.wallet,
          title: t.extracted.finances,
          onTap: () => context.push('/invoices'),
          color: Colors.pinkAccent,
        ),
      ],
    );
  }

  Widget _buildUtilitiesRow(
    BuildContext context,
    UserRole role,
    bool isArabic,
  ) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: [
          _buildSquareItem(
            context,
            LucideIcons.helpCircle,
            t.students.tutorials,
            () => context.push('/tutorials'),
            Colors.blueGrey,
          ),
          const SizedBox(width: 12),
          _buildSquareItem(
            context,
            LucideIcons.fingerprint,
            t.students.security,
            () => context.push('/biometrics'),
            Colors.redAccent,
            role: role,
            permission: RolePermission.viewProfile,
          ),
          const SizedBox(width: 12),
          _buildSquareItem(
            context,
            LucideIcons.bell,
            t.students.notifications,
            () => context.push('/notifications'),
            Colors.amberAccent,
            role: role,
            permission: RolePermission.viewNotifications,
          ),
          const SizedBox(width: 12),
          _buildSquareItem(
            context,
            LucideIcons.messageSquare,
            t.students.forums,
            () => context.push('/forums'),
            Colors.cyanAccent,
            role: role,
            permission: RolePermission.accessForums,
          ),
          const SizedBox(width: 12),
          _buildSquareItem(
            context,
            LucideIcons.lifeBuoy,
            t.students.support,
            () => context.push('/support'),
            Colors.indigoAccent,
            role: role,
            permission: RolePermission.submitSupportTicket,
          ),
        ],
      ),
    );
  }

  Widget _gatedGrid(
    BuildContext context, {
    required UserRole role,
    required RolePermission permission,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    final locked = !role.hasPermission(permission);
    return _buildGridItem(context, icon, title, onTap, color, locked: locked);
  }

  Widget _gatedHorizontal(
    BuildContext context, {
    required UserRole role,
    required RolePermission permission,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    final locked = !role.hasPermission(permission);
    return _buildHorizontalItem(
      context,
      icon,
      title,
      onTap,
      color,
      locked: locked,
    );
  }

  Widget _buildRoleBadge(BuildContext context, bool isArabic, AuthState auth) {
    final role = auth.role;
    final roleColor = _getRoleColor(role);

    return GlassContainer(
      borderRadius: BorderRadius.circular(32),
      padding: const EdgeInsets.all(28),
      border: Border.all(color: roleColor.withValues(alpha: 0.3)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          roleColor.withValues(alpha: 0.15),
          roleColor.withValues(alpha: 0.05),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: roleColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: roleColor.withValues(alpha: 0.3),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(_getRoleIcon(role), color: roleColor, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  auth.fullName ?? '—',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: roleColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: roleColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    role.displayName(isArabic: isArabic),
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: roleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.shieldCheck,
            color: Colors.greenAccent.withValues(alpha: 0.6),
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    Color accentColor, {
    bool locked = false,
  }) {
    return InkWell(
      onTap: locked ? () => _showAccessDenied(context) : onTap,
      borderRadius: BorderRadius.circular(24),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: const EdgeInsets.all(16),
        border: Border.all(
          color: locked
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.4),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: locked
              ? [
                  Colors.grey.withValues(alpha: 0.08),
                  Colors.grey.withValues(alpha: 0.03),
                ]
              : [
                  accentColor.withValues(alpha: 0.2),
                  accentColor.withValues(alpha: 0.05),
                ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: locked
                        ? Colors.grey.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                    boxShadow: locked
                        ? null
                        : [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Icon(
                    icon,
                    color: locked ? Colors.grey : accentColor,
                    size: 24,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                            color: locked
                                ? Colors.grey
                                : Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        locked ? LucideIcons.lock : LucideIcons.chevronRight,
                        size: 14,
                        color: locked
                            ? Colors.grey.withValues(alpha: 0.5)
                            : Theme.of(
                                context,
                              ).hintColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (locked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black.withValues(alpha: 0.15),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    Color accentColor, {
    bool locked = false,
  }) {
    return InkWell(
      onTap: locked ? () => _showAccessDenied(context) : onTap,
      borderRadius: BorderRadius.circular(24),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: EdgeInsets.zero,
        border: Border.all(
          color: locked
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.3),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: locked
              ? [
                  Colors.grey.withValues(alpha: 0.06),
                  Colors.grey.withValues(alpha: 0.02),
                ]
              : [
                  accentColor.withValues(alpha: 0.15),
                  accentColor.withValues(alpha: 0.05),
                ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                icon,
                size: 100,
                color: (locked ? Colors.grey : accentColor).withValues(
                  alpha: 0.05,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: locked
                          ? Colors.grey.withValues(alpha: 0.15)
                          : Colors.white.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                      boxShadow: locked
                          ? null
                          : [
                              BoxShadow(
                                color: accentColor.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: Icon(
                      icon,
                      color: locked ? Colors.grey : accentColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: locked
                              ? Colors.grey
                              : Theme.of(context).textTheme.bodyLarge?.color,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      locked ? LucideIcons.lock : LucideIcons.arrowRight,
                      size: 14,
                      color: locked
                          ? Colors.grey.withValues(alpha: 0.5)
                          : Theme.of(context).hintColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    Color accentColor, {
    UserRole? role,
    RolePermission? permission,
  }) {
    final locked =
        role != null && permission != null && !role.hasPermission(permission);

    return InkWell(
      onTap: locked ? () => _showAccessDenied(context) : onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 100,
        child: GlassContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (locked ? Colors.grey : accentColor).withValues(
                    alpha: 0.1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  locked ? LucideIcons.lock : icon,
                  color: locked ? Colors.grey : accentColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: locked
                        ? Colors.grey
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    if (role.isAdmin) return const Color(0xFFEF4444);
    if (role.isLeadership) return const Color(0xFFF59E0B);
    if (role.isTeachingStaff) return const Color(0xFF6366F1);
    if (role == UserRole.registrarOfficer ||
        role == UserRole.academicAdvisor ||
        role == UserRole.librarian) {
      return const Color(0xFF10B981);
    }
    return const Color(0xFF0EA5E9);
  }

  IconData _getRoleIcon(UserRole role) {
    if (role.isAdmin) return LucideIcons.shield;
    if (role.isLeadership) return LucideIcons.crown;
    if (role.isTeachingStaff) return LucideIcons.presentation;
    if (role == UserRole.registrarOfficer) return LucideIcons.clipboardList;
    if (role == UserRole.academicAdvisor) return LucideIcons.compass;
    if (role == UserRole.librarian) return LucideIcons.bookMarked;
    return LucideIcons.user;
  }

  void _showAccessDenied(BuildContext context, [String? message]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(LucideIcons.shieldOff, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message ??
                    (t
                        .extracted
                        .you_do_not_have_permission_to_access_this_section),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.redAccent.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
