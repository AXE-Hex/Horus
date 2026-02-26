import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hue/core/auth/roles.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/features/admin/presentation/widgets/admin_widgets.dart';
import 'package:hue/features/admin/presentation/providers/admin_stats_provider.dart';
import 'package:hue/features/admin/presentation/providers/performance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdministrationScreen extends ConsumerWidget {
  const AdministrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final statsAsync = ref.watch(adminStatsProvider);
    final perfState = ref.watch(performanceProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: statsAsync.when(
        data: (stats) => _buildContent(context, stats, isArabic, perfState),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Map<RoleCategory, int> stats,
    bool isArabic,
    PerformanceState perfState,
  ) {
    final staffCount = stats[RoleCategory.teachingStaff] ?? 0;
    final studentCount = stats[RoleCategory.studentRoles] ?? 0;
    final leadershipCount = stats[RoleCategory.academicLeadership] ?? 0;
    final adminCount = stats[RoleCategory.adminIT] ?? 0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminSectionHeader(
            title: isArabic ? 'نظرة عامة على النظام' : 'System Overview',
            subtitle: isArabic
                ? 'إحصائيات فورية حية'
                : 'Live system performance',
          ).animate().fadeIn(),

          const SizedBox(height: 24),

          // Main Stats Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.05,
                children: [
                  AdminStatCard(
                    icon: LucideIcons.graduationCap,
                    title: isArabic ? 'أعضاء التدريس' : 'Faculty',
                    value: staffCount.toString(),
                    color: Colors.blueAccent,
                    onTap: () => context.push('/admin/professors'),
                  ),
                  AdminStatCard(
                    icon: LucideIcons.users,
                    title: isArabic ? 'الطلاب' : 'Students',
                    value: studentCount.toString(),
                    color: Colors.orangeAccent,
                    onTap: () => _navigateToUsers(
                      context,
                      RoleCategory.studentRoles,
                      isArabic ? 'الطلاب' : 'Students',
                    ),
                  ),
                  AdminStatCard(
                    icon: LucideIcons.shieldCheck,
                    title: isArabic ? 'القيادة الأكاديمية' : 'Leadership',
                    value: leadershipCount.toString(),
                    color: Colors.purpleAccent,
                    onTap: () => _navigateToUsers(
                      context,
                      RoleCategory.academicLeadership,
                      isArabic ? 'القيادة' : 'Leadership',
                    ),
                  ),
                  AdminStatCard(
                    icon: LucideIcons.settings,
                    title: isArabic ? 'المسؤولون' : 'Admins',
                    value: adminCount.toString(),
                    color: Colors.tealAccent,
                    onTap: () => _navigateToUsers(
                      context,
                      RoleCategory.adminIT,
                      isArabic ? 'المسؤولون' : 'Admins',
                    ),
                  ),
                ],
              );
            },
          ).animate().slideY(begin: 0.1, end: 0).fadeIn(delay: 100.ms),

          const SizedBox(height: 40),

          AdminSectionHeader(
            title: isArabic ? 'إدارة المؤسسة' : 'Institutional Control',
          ),

          const SizedBox(height: 16),

          _buildManagementActionRow(
            context,
            isArabic,
          ).animate().slideX(begin: 0.1, end: 0).fadeIn(delay: 200.ms),

          const SizedBox(height: 40),

          AdminSectionHeader(
            title: isArabic ? 'حالة النظام والتدقيق' : 'Health & Auditing',
            subtitle: isArabic
                ? 'مراقبة العمليات الحية'
                : 'Monitor live operations',
          ),

          const SizedBox(height: 16),

          _buildSystemStatusList(
            context,
            isArabic,
            perfState.latestLatency,
          ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: 40),

          AdminSectionHeader(
            title: isArabic ? 'أداء المحرك' : 'Engine Performance',
            subtitle: isArabic
                ? 'تحليل سرعة الاستجابة'
                : 'Latency & Throughput',
          ),

          const SizedBox(height: 16),

          GlassContainer(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isArabic ? 'استجابة Supabase' : 'Supabase Latency',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${perfState.latestLatency.toInt()}ms',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LivePerformanceChart(
                  color: Colors.greenAccent,
                  data: perfState.latencyHistory,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  void _navigateToUsers(
    BuildContext context,
    RoleCategory category,
    String title,
  ) {
    context.push('/admin/users', extra: {'category': category, 'title': title});
  }

  Widget _buildManagementActionRow(BuildContext context, bool isArabic) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                LucideIcons.building,
                isArabic ? 'إدارة الكليات' : 'Colleges',
                'Colleges & Deans',
                Colors.indigoAccent,
                () => context.push('/admin/colleges'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                context,
                LucideIcons.layout,
                isArabic ? 'إدارة الأقسام' : 'Departments',
                'Programs & Heads',
                Colors.amberAccent,
                () => context.push('/admin/departments'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          context,
          LucideIcons.userCheck,
          isArabic ? 'إدارة أعضاء التدريس' : 'Doctors Management',
          'Faculty details & assignments',
          Colors.lightBlueAccent,
          () => context.push('/admin/professors'),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          context,
          LucideIcons.scrollText,
          isArabic ? 'سجلات النظام' : 'Audit Logs',
          'Track every administrative action',
          Colors.redAccent,
          () => context.push('/admin/audit-logs'),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return GlassContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            size: 18,
            color: Colors.white.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatusList(
    BuildContext context,
    bool isArabic,
    double latency,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildStatusTile(
            context,
            LucideIcons.database,
            isArabic ? 'قاعدة البيانات (Supabase)' : 'Supabase Engine',
            isArabic ? 'مستقر' : 'Stable',
            true,
          ),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
          _buildStatusTile(
            context,
            LucideIcons.shield,
            isArabic ? 'جدار الحماية' : 'HUE Firewall',
            isArabic ? 'نشط' : 'Active',
            true,
          ),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
          _buildStatusTile(
            context,
            LucideIcons.activity,
            isArabic ? 'سرعة النظام' : 'Latency',
            '${latency.toInt()}ms',
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTile(
    BuildContext context,
    IconData icon,
    String title,
    String status,
    bool isOk,
  ) {
    return ListTile(
      leading: Icon(icon, size: 20, color: Colors.white54),
      title: Text(
        title,
        style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isOk ? Colors.greenAccent : Colors.orangeAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOk ? Colors.greenAccent : Colors.orangeAccent,
              boxShadow: [
                BoxShadow(
                  color: (isOk ? Colors.greenAccent : Colors.orangeAccent)
                      .withValues(alpha: 0.4),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
