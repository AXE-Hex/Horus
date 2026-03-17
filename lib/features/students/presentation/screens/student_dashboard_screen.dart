import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/students/data/digital_id_theme_repository.dart';
import 'package:lucide_icons/lucide_icons.dart';

// ──────────────────────────────────────────────────────────────────────────────
// StudentDashboardScreen — Student-Only Dashboard
// Shows academic, enrollment, and utility sections for student roles.
// ──────────────────────────────────────────────────────────────────────────────

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

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

            // ── Header: Digital ID Card ──
            _buildDigitalIDCard(context, isArabic, auth)
                .animate()
                .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOut)
                .shimmer(
                  duration: 1200.ms,
                  color: Colors.white.withValues(alpha: 0.2),
                ),

            const SizedBox(height: 32),

            // ═══════════════ ACADEMIC ═══════════════
            _buildSectionHeader(context, t.students.academic)
                .animate()
                .fadeIn(delay: d)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            _buildAcademicGrid(
              context,
              role,
              isArabic,
            ).animate().fadeIn(delay: d * 2).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 24),

            // ═══════════════ ENROLLMENT & FINANCE ═══════════════
            _buildSectionHeader(context, t.students.enrollment_finance)
                .animate()
                .fadeIn(delay: d * 3)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            _buildEnrollmentGrid(
              context,
              role,
              isArabic,
            ).animate().fadeIn(delay: d * 4).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 24),

            // ═══════════════ UTILITIES ═══════════════
            _buildSectionHeader(context, t.students.utilities)
                .animate()
                .fadeIn(delay: d * 5)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            _buildUtilitiesRow(
              context,
              role,
              isArabic,
            ).animate().fadeIn(delay: d * 6).slideX(begin: 0.2, end: 0),

            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  SECTION BUILDERS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildAcademicGrid(
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
      childAspectRatio: 1.3,
      padding: EdgeInsets.zero,
      children: [
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.fileText,
          title: t.students.transcript,
          onTap: () => context.push('/transcript'),
          color: Colors.blueAccent,
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.trendingUp,
          title: t.students.courses,
          onTap: () => context.push('/progress'),
          color: Colors.greenAccent,
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.target,
          title: t.students.action_plan,
          onTap: () => context.push('/action-plan'),
          color: Colors.purpleAccent,
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.award,
          title: t.students.subject_results,
          onTap: () => context.push('/subject-result'),
          color: Colors.orangeAccent,
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.viewProfile,
          icon: LucideIcons.graduationCap,
          title: t.students.digital_id,
          onTap: () => context.push('/digital-id'),
          color: Colors.indigoAccent,
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.viewSchedule,
          icon: LucideIcons.calendar,
          title: t.students.daily_schedule,
          onTap: () => context.push('/schedule'),
          color: Colors.deepPurpleAccent,
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.viewAttendance,
          icon: LucideIcons.clipboardCheck,
          title: t.students.attendance,
          onTap: () => context.push('/attendance'),
          color: Colors.redAccent,
        ),
        _gatedGrid(
          context,
          role: role,
          permission: RolePermission.viewSchedule,
          icon: LucideIcons.fileSpreadsheet,
          title: t.students.exam_schedule,
          onTap: () => context.push('/exam-schedule'),
          color: Colors.amberAccent,
        ),
      ],
    );
  }

  Widget _buildEnrollmentGrid(
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
          permission: RolePermission.enrollCourses,
          icon: LucideIcons.fileText,
          title: t.students.registration,
          onTap: () => context.push('/registration'),
          color: Colors.tealAccent,
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.alertCircle,
          title: t.students.invoices,
          onTap: () => context.push('/invoices'),
          color: Colors.deepOrangeAccent,
        ),
        _gatedHorizontal(
          context,
          role: role,
          permission: RolePermission.enrollCourses,
          icon: LucideIcons.creditCard,
          title: t.students.payment,
          onTap: () => context.push('/payment'),
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

  // ═══════════════════════════════════════════════════════════════════════════
  //  GATED CARD HELPERS — shorthand for permission-checked cards
  // ═══════════════════════════════════════════════════════════════════════════

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

  // ═══════════════════════════════════════════════════════════════════════════
  //  HEADER WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildDigitalIDCard(

    BuildContext context,
    bool isArabic,
    AuthState auth,
  ) {
    final theme = DigitalIDThemeRepository.getTheme(
      collegeId: 'ai',
      specializationId: 'artificial_cybersecurity',
    );

    return GestureDetector(
      onTap: () {
        context.push(
          '/digital-id',
          extra: {
            'name': auth.fullName ?? t.students.student,
            'id': auth.user?.id ?? '',
            'college': 'ai',
            'specialization': 'artificial_cybersecurity',
            'gpa': '—',
            'level': '—',
          },
        );
      },
      child: Hero(
        tag: 'digital_id_card',
        child: GlassContainer(
          height: 260,
          borderRadius: BorderRadius.circular(32),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.graduationCap,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        t.students.horus_university,
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      theme.patternIcon,
                      color: theme.secondaryColor,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [theme.primaryColor, theme.secondaryColor],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.primaryColor.withValues(alpha: 0.5),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 38,
                      backgroundColor: Color(0xFF0F172A),
                      child: Icon(
                        LucideIcons.user,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.fullName ?? t.students.student,
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: theme.secondaryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.secondaryColor.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          child: Text(
                            t.students.artificial_intelligence,
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: theme.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCardStat(
                    'ID',
                    auth.user?.email?.split('@').first ?? '—',
                  ),
                  _buildCardStat('GPA', '—'),
                  _buildCardStat('TERM', '—'),
                  _buildCardStat('EXPIRY', '—'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.4),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  CARD WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

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
                    (t.extracted.you_do_not_have_permission_to_access_this_section),
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
