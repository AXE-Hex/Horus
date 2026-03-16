import 'dart:ui' as ui;
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
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

// ──────────────────────────────────────────────────────────────────────────────
// AdministrationScreen — Complete Rebuild
// Premium futuristic design with 6 major sections, fully Supabase-connected
// ──────────────────────────────────────────────────────────────────────────────

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
          // ── Animated dark background gradient
          _AdminBackground(),

          // ── Holographic grid overlay
          Positioned.fill(
            child: CustomPaint(painter: _HolographicGridPainter()),
          ),

          // ── Main scrollable content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // 1. Immersive SliverAppBar header
              _AdminSliverHeader(
                isArabic: isArabic,
                auth: auth,
                isStandalone: isStandalone,
              ),

              // 2. Live stat cards row — Supabase connected
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

              // 3. System Modules Grid
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  child: _SystemModulesGrid(isArabic: isArabic),
                ),
              ),

              // 5. System Pulse Monitor — live latency
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  child: _SystemPulseSection(
                    isArabic: isArabic,
                    perfState: perfState,
                  ),
                ),
              ),

              // 6. Recent Activity + Role Breakdown
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

// ──────────────────────────────────────────────────────────────────────────────
// Background — animated gradient layers
// ──────────────────────────────────────────────────────────────────────────────
class _AdminBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0E1A), Color(0xFF0D1627), Color(0xFF08122B)],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Top-left orb
          Positioned(
            left: -100,
            top: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6366F1).withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Bottom-right orb
          Positioned(
            right: -80,
            bottom: 200,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0EA5E9).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Holographic Grid Painter
// ──────────────────────────────────────────────────────────────────────────────
class _HolographicGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 0.5;

    const spacing = 40.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ──────────────────────────────────────────────────────────────────────────────
// 1. Sliver App Bar — Immersive header
// ──────────────────────────────────────────────────────────────────────────────
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
      backgroundColor: const Color(0xFF0A0E1A),
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
            // Diagonal scanline
            Positioned.fill(child: CustomPaint(painter: _ScanlinePainter())),
            // Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    // Status badge
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
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
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
                    const SizedBox(height: 14),

                    // Title
                    Text(
                      t.admin.admin_command_center,
                      style: GoogleFonts.outfit(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                        height: 1.1,
                      ),
                    ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2),

                    const SizedBox(height: 6),

                    // Subtitle with admin name
                    Row(
                      mainAxisAlignment: isArabic
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Icon(
                          LucideIcons.shieldCheck,
                          size: 13,
                          color: const Color(0xFF6366F1),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          auth.fullName ?? (t.admin.admin),
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: Colors.white60,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 1,
                          height: 12,
                          color: Colors.white.withValues(alpha: 0.2),
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

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.015)
      ..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ──────────────────────────────────────────────────────────────────────────────
// 2. Live Stat Cards — Supabase connected via adminStatsProvider
// ──────────────────────────────────────────────────────────────────────────────
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
        const SizedBox(height: 8),
        _SectionLabel(
          label: t.admin.live_statistics,
          icon: LucideIcons.activity,
          color: const Color(0xFF6366F1),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              // Students
              _LiveCard(
                label: t.admin.students,
                icon: LucideIcons.graduationCap,
                color: const Color(0xFF10B981),
                valueAsync: totalStudentsAsync,
                onTap: () => context.push('/admin/management/students'),
              ),
              const SizedBox(width: 14),
              // Staff
              _LiveCard(
                label: t.admin.staff,
                icon: LucideIcons.users,
                color: const Color(0xFF6366F1),
                valueAsync: totalStaffAsync,
                onTap: () => context.push('/admin/management/staff'),
              ),
              const SizedBox(width: 14),
              // Academic Staff
              _LiveCard(
                label: t.admin.faculty,
                icon: LucideIcons.bookOpen,
                color: const Color(0xFF0EA5E9),
                valueAsync: statsAsync.whenData(
                  (s) => s[RoleCategory.teachingStaff] ?? 0,
                ),
                onTap: () => context.push('/admin/management/faculty'),
              ),
              const SizedBox(width: 14),
              // Leadership
              _LiveCard(
                label: t.admin.leadership,
                icon: LucideIcons.crown,
                color: const Color(0xFFF59E0B),
                valueAsync: statsAsync.whenData(
                  (s) => s[RoleCategory.academicLeadership] ?? 0,
                ),
                onTap: () => context.push('/admin/management/leadership'),
              ),
              const SizedBox(width: 14),
              // Admin IT
              _LiveCard(
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
        ),
      ],
    ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.08, end: 0);
  }
}

class _LiveCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final AsyncValue<int> valueAsync;
  final VoidCallback onTap;

  const _LiveCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.valueAsync,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 155,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.03),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                valueAsync.when(
                  data: (val) => Text(
                    NumberFormat('#,###').format(val),
                    style: GoogleFonts.shareTechMono(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  loading: () => const SizedBox(
                    width: 50,
                    height: 28,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                  error: (_, _) => Text(
                    '—',
                    style: GoogleFonts.outfit(fontSize: 26, color: Colors.red),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: Colors.white54,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 3. System Modules Grid — 8 modules with holographic cards
// ──────────────────────────────────────────────────────────────────────────────
class _SystemModulesGrid extends StatelessWidget {
  final bool isArabic;
  const _SystemModulesGrid({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final crossAxisCount = isDesktop ? 4 : (isTablet ? 3 : 2);

    final modules = [
      _Module(
        LucideIcons.users,
        t.admin.users,
        t.admin.manage_all_accounts,
        const Color(0xFF6366F1),
        '/admin/users',
      ),
      _Module(
        LucideIcons.building2,
        t.admin.colleges,
        t.admin.manage_faculties,
        const Color(0xFF0EA5E9),
        '/admin/colleges',
      ),
      _Module(
        LucideIcons.layoutGrid,
        t.admin.departments,
        t.admin.academic_departments,
        const Color(0xFF10B981),
        '/admin/departments',
      ),
      _Module(
        LucideIcons.graduationCap,
        t.admin.professors,
        t.admin.faculty_members,
        const Color(0xFFF59E0B),
        '/admin/professors',
      ),
      _Module(
        LucideIcons.shieldAlert,
        t.admin.roles,
        t.admin.permission_management,
        const Color(0xFF8B5CF6),
        '/admin/roles',
      ),
      _Module(
        LucideIcons.fileSearch,
        t.admin.audit_logs,
        t.admin.system_activity_log,
        const Color(0xFF06B6D4),
        '/admin/audit-logs',
      ),
      _Module(
        LucideIcons.settings2,
        t.admin.system_settings,
        t.admin.platform_configuration,
        Colors.orangeAccent,
        '/admin/system-settings',
      ),
      _Module(
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
        _SectionLabel(
          label: t.admin.system_modules,
          icon: LucideIcons.layoutGrid,
          color: const Color(0xFF0EA5E9),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: isDesktop ? 1.8 : 1.3,
          ),
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final m = modules[index];
            return _ModuleCard(module: m)
                .animate(delay: (index * 60).ms)
                .fadeIn()
                .slideY(begin: 0.06, end: 0);
          },
        ),
      ],
    );
  }
}

class _Module {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String route;
  _Module(this.icon, this.title, this.subtitle, this.color, this.route);
}

class _ModuleCard extends StatelessWidget {
  final _Module module;
  const _ModuleCard({required this.module});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(module.route),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              module.color.withValues(alpha: 0.1),
              module.color.withValues(alpha: 0.03),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: module.color.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: module.color.withValues(alpha: 0.07),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: module.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(module.icon, color: module.color, size: 18),
                ),
                Icon(
                  Directionality.of(context) == ui.TextDirection.rtl
                      ? LucideIcons.chevronLeft
                      : LucideIcons.chevronRight,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module.title,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  module.subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: Colors.white38,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 5. System Pulse Monitor — live latency chart
// ──────────────────────────────────────────────────────────────────────────────
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
        _SectionLabel(
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
              // Status row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _PulseMetric(
                    label: t.admin.server,
                    value: t.admin.online,
                    color: Colors.greenAccent,
                  ),
                  _PulseMetric(
                    label: t.admin.latency,
                    value: '${perfState.latestLatency.toInt()}ms',
                    color: _latencyColor,
                  ),
                  _PulseMetric(
                    label: t.admin.database,
                    value: t.admin.active,
                    color: const Color(0xFF06B6D4),
                  ),
                  _PulseMetric(
                    label: t.admin.status,
                    value: perfState.latestLatency < 300 ? '✓' : '⚠',
                    color: _latencyColor,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Live chart
              SizedBox(
                height: 100,
                child: LivePerformanceChart(
                  color: _latencyColor,
                  data: perfState.latencyHistory,
                ),
              ),
              const SizedBox(height: 12),
              // Chart label
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

class _PulseMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _PulseMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 10, color: Colors.white38),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 6. Role Breakdown Section — visual breakdown of user categories
// ──────────────────────────────────────────────────────────────────────────────
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
        _SectionLabel(
          label: t.admin.role_breakdown,
          icon: LucideIcons.pieChart,
          color: const Color(0xFF8B5CF6),
        ),
        const SizedBox(height: 16),
        statsAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e, _) => _ErrorCard(isArabic: isArabic, error: e.toString()),
          data: (stats) {
            final total = stats.values.fold(0, (a, b) => a + b);
            final categories = [
              (
                category: RoleCategory.studentRoles,
                label: t.admin.students,
                color: const Color(0xFF10B981),
                icon: LucideIcons.graduationCap,
              ),
              (
                category: RoleCategory.teachingStaff,
                label: t.admin.teaching_staff,
                color: const Color(0xFF0EA5E9),
                icon: LucideIcons.bookOpen,
              ),
              (
                category: RoleCategory.academicLeadership,
                label: t.admin.academic_leadership,
                color: const Color(0xFFF59E0B),
                icon: LucideIcons.crown,
              ),
              (
                category: RoleCategory.studentAffairs,
                label: t.admin.student_affairs,
                color: const Color(0xFF8B5CF6),
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
                    const Color(0xFF8B5CF6).withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                children: [
                  ...categories.map((cat) {
                    final count = stats[cat.category] ?? 0;
                    final pct = total > 0 ? count / total : 0.0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _RoleBar(
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
                          color: Colors.white,
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

class _RoleBar extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final int count;
  final double percentage;
  final bool isArabic;

  const _RoleBar({
    required this.label,
    required this.icon,
    required this.color,
    required this.count,
    required this.percentage,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              NumberFormat('#,###').format(count),
              style: GoogleFonts.shareTechMono(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(percentage * 100).toStringAsFixed(1)}%',
              style: GoogleFonts.outfit(fontSize: 11, color: Colors.white38),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Helpers
// ──────────────────────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _SectionLabel({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final bool isArabic;
  final String error;

  const _ErrorCard({required this.isArabic, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          const Icon(
            LucideIcons.serverCrash,
            color: Colors.redAccent,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            t.admin.failed_to_load_data,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            error,
            style: GoogleFonts.outfit(fontSize: 11, color: Colors.white38),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
