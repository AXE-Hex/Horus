import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/utils/responsive_helper.dart';
import 'package:hue/features/admin/presentation/providers/admin_stats_provider.dart';
import 'package:hue/features/admin/presentation/providers/performance_provider.dart';
import 'package:hue/features/admin/presentation/widgets/admin_widgets.dart';
import 'package:hue/features/admin/presentation/widgets/admin_dashboard_components.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class AdministrationScreen extends ConsumerWidget {
  final bool isStandalone;
  const AdministrationScreen({super.key, this.isStandalone = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final auth = ref.watch(authControllerProvider);
    final statsAsync = ref.watch(adminStatsProvider);
    final perfState = ref.watch(performanceProvider);
    final isWide =
        ResponsiveHelper.isDesktop(context) ||
        ResponsiveHelper.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          AdminBackground(),

          Positioned.fill(
            child: CustomPaint(painter: HolographicGridPainter()),
          ),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _AdminSliverHeader(
                isArabic: isArabic,
                auth: auth,
                isStandalone: isStandalone,
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: _LiveStatCards(
                    statsAsync: statsAsync,
                    isArabic: isArabic,
                    isWide: isWide,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  child: _SystemModulesGrid(isArabic: isArabic),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  child: _SystemPulseSection(
                    isArabic: isArabic,
                    perfState: perfState,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 120),
                  child: _RoleBreakdownSection(
                    statsAsync: statsAsync,
                    isArabic: isArabic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdminSliverHeader extends StatelessWidget {
  final bool isArabic;
  final AuthState auth;
  final bool isStandalone;

  const _AdminSliverHeader({
    required this.isArabic,
    required this.auth,
    required this.isStandalone,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeStr = DateFormat('HH:mm').format(now);
    final dateStr = DateFormat(
      t.admin.eeee_mmmm_dd_yyyy,
      t.admin.en,
    ).format(now);

    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: isStandalone
          ? IconButton(
              icon: Icon(
                isArabic ? LucideIcons.arrowRight : LucideIcons.arrowLeft,
                color: Colors.white70,
              ),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(child: CustomPaint(painter: ScanlinePainter())),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
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
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            t.admin.system_online,
                            style: GoogleFonts.shareTechMono(
                              fontSize: 10,
                              color: Colors.greenAccent,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn().slideX(begin: isArabic ? 0.1 : -0.1),
                    SizedBox(height: 14),

                    Text(
                      t.admin.admin_command_center,
                      style: GoogleFonts.outfit(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: -0.5,
                        height: 1.1,
                      ),
                    ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2),

                    SizedBox(height: 6),

                    Wrap(
                      alignment: isArabic
                          ? WrapAlignment.end
                          : WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Icon(
                          LucideIcons.shieldCheck,
                          size: 13,
                          color:
                              (Theme.of(context).cardTheme.color ??
                              Theme.of(context).cardColor),
                        ),
                        SizedBox(width: 6),
                        Text(
                          auth.fullName ?? (t.admin.admin),
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: Colors.white60,
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          width: 1,
                          height: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.2),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '$timeStr • $dateStr',
                          style: GoogleFonts.shareTechMono(
                            fontSize: 10,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ).animate(delay: 180.ms).fadeIn(),
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

class _LiveStatCards extends ConsumerWidget {
  final AsyncValue<Map<RoleCategory, int>> statsAsync;
  final bool isArabic;
  final bool isWide;

  const _LiveStatCards({
    required this.statsAsync,
    required this.isArabic,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalStudentsAsync = ref.watch(totalStudentCountProvider);
    final totalStaffAsync = ref.watch(totalStaffCountProvider);

    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        SectionLabel(
          label: t.admin.live_statistics,
          icon: LucideIcons.activity,
          color:
              (Theme.of(context).cardTheme.color ??
              Theme.of(context).cardColor),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            LiveCard(
              label: t.admin.students,
              icon: LucideIcons.graduationCap,
              color:
                  (Theme.of(context).cardTheme.color ??
                  Theme.of(context).cardColor),
              valueAsync: totalStudentsAsync,
              onTap: () => context.push('/admin/management/students'),
            ),

            LiveCard(
              label: t.admin.staff,
              icon: LucideIcons.users,
              color:
                  (Theme.of(context).cardTheme.color ??
                  Theme.of(context).cardColor),
              valueAsync: totalStaffAsync,
              onTap: () => context.push('/admin/management/staff'),
            ),

            LiveCard(
              label: t.admin.leadership,
              icon: LucideIcons.crown,
              color:
                  (Theme.of(context).cardTheme.color ??
                  Theme.of(context).cardColor),
              valueAsync: statsAsync.whenData(
                (s) => s[RoleCategory.academicLeadership] ?? 0,
              ),
              onTap: () => context.push('/admin/management/leadership'),
            ),

            LiveCard(
              label: t.admin.admin_it,
              icon: LucideIcons.server,
              color: Colors.redAccent,
              valueAsync: statsAsync.whenData(
                (s) => s[RoleCategory.adminIT] ?? 0,
              ),
              onTap: () => context.push('/admin/management/admin-it'),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.08, end: 0);
  }
}

class _SystemModulesGrid extends StatelessWidget {
  final bool isArabic;
  const _SystemModulesGrid({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final modules = [
      AdminModule(
        LucideIcons.users,
        t.admin.users,
        t.admin.manage_all_accounts,
        const Color(0xFF6366F1),
        '/admin/users',
      ),
      AdminModule(
        LucideIcons.building2,
        t.admin.colleges,
        t.admin.manage_faculties,
        const Color(0xFF0EA5E9),
        '/admin/colleges',
      ),
      AdminModule(
        LucideIcons.layoutGrid,
        t.admin.departments,
        t.admin.academic_departments,
        const Color(0xFF10B981),
        '/admin/departments',
      ),
      AdminModule(
        LucideIcons.shieldAlert,
        t.admin.roles,
        t.admin.permission_management,
        const Color(0xFF8B5CF6),
        '/admin/roles',
      ),
      AdminModule(
        LucideIcons.fileSearch,
        t.admin.audit_logs,
        t.admin.system_activity_log,
        const Color(0xFF06B6D4),
        '/admin/audit-logs',
      ),
      AdminModule(
        LucideIcons.settings2,
        t.admin.system_settings,
        t.admin.platform_configuration,
        Colors.orangeAccent,
        '/admin/system-settings',
      ),
      AdminModule(
        LucideIcons.activity,
        t.admin.performance,
        t.admin.server_health_metrics,
        Colors.pinkAccent,
        '/admin/monitor',
      ),
    ];

    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        SectionLabel(
          label: t.admin.system_modules,
          icon: LucideIcons.layoutGrid,
          color:
              (Theme.of(context).cardTheme.color ??
              Theme.of(context).cardColor),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.5,
          ),
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final m = modules[index];
            return AdminModuleCard(module: m)
                .animate(delay: (index * 60).ms)
                .fadeIn()
                .slideY(begin: 0.06, end: 0);
          },
        ),
      ],
    );
  }
}

class _SystemPulseSection extends StatelessWidget {
  final bool isArabic;
  final PerformanceState perfState;

  const _SystemPulseSection({required this.isArabic, required this.perfState});

  Color get _latencyColor {
    if (perfState.latestLatency < 100) return Colors.greenAccent;
    if (perfState.latestLatency < 300) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        SectionLabel(
          label: t.admin.system_pulse,
          icon: LucideIcons.heartPulse,
          color: Colors.greenAccent,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.greenAccent.withValues(alpha: 0.05),
                Colors.blueAccent.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.greenAccent.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PulseMetric(
                    label: t.admin.server,
                    value: t.admin.online,
                    color: Colors.greenAccent,
                  ),
                  PulseMetric(
                    label: t.admin.latency,
                    value: '${perfState.latestLatency.toInt()}ms',
                    color: _latencyColor,
                  ),
                  PulseMetric(
                    label: t.admin.database,
                    value: t.admin.active,
                    color:
                        (Theme.of(context).cardTheme.color ??
                        Theme.of(context).cardColor),
                  ),
                  PulseMetric(
                    label: t.admin.status,
                    value: perfState.latestLatency < 300 ? '✓' : '⚠',
                    color: _latencyColor,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              SizedBox(
                height: 100,
                child: LivePerformanceChart(
                  color: _latencyColor,
                  data: perfState.latencyHistory,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                t.admin.realtime_latency_ms,
                style: GoogleFonts.shareTechMono(
                  fontSize: 10,
                  color: Colors.white30,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate(delay: 350.ms).fadeIn().slideY(begin: 0.08, end: 0);
  }
}

class _RoleBreakdownSection extends ConsumerWidget {
  final AsyncValue<Map<RoleCategory, int>> statsAsync;
  final bool isArabic;

  const _RoleBreakdownSection({
    required this.statsAsync,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        SectionLabel(
          label: t.admin.role_breakdown,
          icon: LucideIcons.pieChart,
          color:
              (Theme.of(context).cardTheme.color ??
              Theme.of(context).cardColor),
        ),
        const SizedBox(height: 16),
        statsAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e, _) => ErrorCard(isArabic: isArabic, error: e.toString()),
          data: (stats) {
            final total = stats.values.fold(0, (a, b) => a + b);
            final categories = [
              (
                category: RoleCategory.studentRoles,
                label: t.admin.students,
                color:
                    (Theme.of(context).cardTheme.color ??
                    Theme.of(context).cardColor),
                icon: LucideIcons.graduationCap,
              ),
              (
                category: RoleCategory.teachingStaff,
                label: t.admin.teaching_staff,
                color:
                    (Theme.of(context).cardTheme.color ??
                    Theme.of(context).cardColor),
                icon: LucideIcons.bookOpen,
              ),
              (
                category: RoleCategory.academicLeadership,
                label: t.admin.academic_leadership,
                color:
                    (Theme.of(context).cardTheme.color ??
                    Theme.of(context).cardColor),
                icon: LucideIcons.crown,
              ),
              (
                category: RoleCategory.studentAffairs,
                label: t.admin.student_affairs,
                color:
                    (Theme.of(context).cardTheme.color ??
                    Theme.of(context).cardColor),
                icon: LucideIcons.clipboardList,
              ),
              (
                category: RoleCategory.adminIT,
                label: t.admin.admin_it,
                color: Colors.redAccent,
                icon: LucideIcons.server,
              ),
            ];

            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8B5CF6).withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color:
                      (Theme.of(context).cardTheme.color ??
                              Theme.of(context).cardColor)
                          .withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                children: [
                  ...categories.map((cat) {
                    final count = stats[cat.category] ?? 0;
                    final pct = total > 0 ? count / total : 0.0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: RoleBar(
                        label: cat.label,
                        icon: cat.icon,
                        color: cat.color,
                        count: count,
                        percentage: pct,
                        isArabic: isArabic,
                      ),
                    );
                  }),
                  Divider(color: Colors.white10, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.admin.total_users,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        NumberFormat('#,###').format(total),
                        style: GoogleFonts.shareTechMono(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ).animate(delay: 450.ms).fadeIn().slideY(begin: 0.08, end: 0);
  }
}
