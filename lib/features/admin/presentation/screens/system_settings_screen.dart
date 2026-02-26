import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SystemSettingsScreen extends ConsumerWidget {
  const SystemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          isArabic ? 'إعدادات النظام' : 'System Settings',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsSection(
            context,
            title: isArabic ? 'العام الأكاديمي' : 'Academic Year',
            icon: LucideIcons.calendar,
            children: [
              _buildSettingItem(
                context,
                label: isArabic
                    ? 'إدارة الأعوام الدراسية'
                    : 'Manage Academic Years',
              ),
              _buildSettingItem(
                context,
                label: isArabic ? 'الفصول الدراسية النشطة' : 'Active Semesters',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            context,
            title: isArabic ? 'سياسات التقييم' : 'Grading Policies',
            icon: LucideIcons.barChart,
            children: [
              _buildSettingItem(
                context,
                label: isArabic ? 'إعدادات GPA' : 'GPA Settings',
              ),
              _buildSettingItem(
                context,
                label: isArabic ? 'حدود النجاح والرسوب' : 'Passing Thresholds',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildSettingItem(BuildContext context, {required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(fontSize: 14)),
            const Icon(LucideIcons.chevronRight, size: 16),
          ],
        ),
      ),
    );
  }
}
