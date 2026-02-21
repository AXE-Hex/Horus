// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdministrationScreen extends StatelessWidget {
  const AdministrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    const staggerDelay = Duration(milliseconds: 100);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickOverview(
            context,
            isArabic,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 32),

          _buildSectionHeader(context, t.administration.title)
              .animate()
              .fadeIn(delay: staggerDelay)
              .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
          const SizedBox(height: 12),
          GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _buildAdminCard(
                    context,
                    LucideIcons.userPlus,
                    isArabic ? 'إدارة الموظفين' : 'Staff Management',
                    isArabic ? '124 موظف' : '124 Staff',
                    Colors.blueAccent,
                  ),
                  _buildAdminCard(
                    context,
                    LucideIcons.users,
                    isArabic ? 'إدارة الطلاب' : 'Student Management',
                    isArabic ? '4,250 طالب' : '4,250 Students',
                    Colors.orangeAccent,
                  ),
                  _buildAdminCard(
                    context,
                    LucideIcons.building,
                    isArabic ? 'الأقسام' : 'Departments',
                    isArabic ? '12 قسم' : '12 Depts',
                    Colors.purpleAccent,
                  ),
                  _buildAdminCard(
                    context,
                    LucideIcons.barChart,
                    isArabic ? 'الإحصائيات' : 'Statistics',
                    isArabic ? 'تقارير حية' : 'Live Reports',
                    Colors.greenAccent,
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: staggerDelay * 2)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 32),

          _buildSectionHeader(context, t.administration.title)
              .animate()
              .fadeIn(delay: staggerDelay * 3)
              .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
          const SizedBox(height: 12),
          _buildSystemStatusList(context, isArabic)
              .animate()
              .fadeIn(delay: staggerDelay * 4)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildQuickOverview(BuildContext context, bool isArabic) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isArabic ? 'نظرة عامة' : 'Quick Overview',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      LucideIcons.activity,
                      size: 14,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isArabic ? 'نشط' : 'Active',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOverviewStat(
                context,
                '142',
                isArabic ? 'طلبات معلقة' : 'Pending Req',
              ),
              _buildOverviewStat(
                context,
                '28',
                isArabic ? 'تنبيهات النظام' : 'Sys Alerts',
                isAlert: true,
              ),
              _buildOverviewStat(
                context,
                '98%',
                isArabic ? 'جاهزية السيرفر' : 'Server Uptime',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat(
    BuildContext context,
    String value,
    String label, {
    bool isAlert = false,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isAlert ? Colors.redAccent : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildAdminCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(16),
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatusList(BuildContext context, bool isArabic) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildStatusTile(
            context,
            LucideIcons.server,
            isArabic ? 'قاعدة البيانات' : 'Core Database',
            isArabic ? 'متصل' : 'Connected',
            true,
          ),
          const Divider(height: 1),
          _buildStatusTile(
            context,
            LucideIcons.globe,
            isArabic ? 'بوابة الدفع' : 'Payment Gateway',
            isArabic ? 'نشط' : 'Active',
            true,
          ),
          const Divider(height: 1),
          _buildStatusTile(
            context,
            LucideIcons.mail,
            isArabic ? 'خادم البريد' : 'Mail Server',
            isArabic ? 'متوقف مؤقتاً' : 'Delayed',
            false,
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
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isOk ? Colors.green : Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 4,
            backgroundColor: isOk ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }
}
