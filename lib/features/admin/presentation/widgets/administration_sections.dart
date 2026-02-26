import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StructuralManagementSection extends StatelessWidget {
  const StructuralManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdministrationSectionHeader(
          title: 'الإدارة الهيكلية',
          titleEn: 'Structural Management',
        ),
        _AdminActionButton(
          icon: LucideIcons.plus,
          label: 'إنشاء/تعديل الكليات',
          labelEn: 'Colleges Management',
          onTap: () => context.push('/admin/colleges'),
        ),
        _AdminActionButton(
          icon: LucideIcons.layout,
          label: 'إدارة الأقسام للأقسام العلمية',
          labelEn: 'Departments Management',
          onTap: () => context.push('/admin/departments'),
        ),
        _AdminActionButton(
          icon: LucideIcons.userCheck,
          label: 'تعيين القيادات الأكاديمية',
          labelEn: 'Appoint Leadership',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.history,
          label: 'سجل التعيينات الإدارية',
          labelEn: 'Appointment History',
          onTap: () {},
        ),
      ],
    );
  }
}

class RBACSection extends StatelessWidget {
  const RBACSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdministrationSectionHeader(
          title: 'الصلاحيات والأدوار (الوصول المنطقي)',
          titleEn: 'RBAC (Logical Access)',
        ),
        _AdminActionButton(
          icon: LucideIcons.shield,
          label: 'مصفوفة الصلاحيات',
          labelEn: 'Permissions Matrix',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.userPlus,
          label: 'تعديل أدوار مستخدم محدد',
          labelEn: 'Customize User Role',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.clock,
          label: 'إدارة الوصول المؤقت للموظفين',
          labelEn: 'Temporary Access Management',
          onTap: () {},
        ),
      ],
    );
  }
}

class AcademicOperationsSection extends StatelessWidget {
  const AcademicOperationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdministrationSectionHeader(
          title: 'العمليات الأكاديمية (التمكين)',
          titleEn: 'Academic Operations (Enabling)',
        ),
        _AdminActionButton(
          icon: LucideIcons.graduationCap,
          label: 'توزيع الأعباء الدراسية',
          labelEn: 'Workload Distribution',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.calendar,
          label: 'إدارة جداول المحاضرات',
          labelEn: 'Lectures Schedule Management',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.clipboardCheck,
          label: 'اعتماد النتائج النهائية',
          labelEn: 'Final Results Approval',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.bellRing,
          label: 'التنبيهات الأكاديمية التلقائية',
          labelEn: 'Auto Academic Alerts',
          onTap: () {},
        ),
      ],
    );
  }
}

class FinancialManagementSection extends StatelessWidget {
  const FinancialManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdministrationSectionHeader(
          title: 'الإدارة المالية (النزاهة)',
          titleEn: 'Financial Management',
        ),
        _AdminActionButton(
          icon: LucideIcons.banknote,
          label: 'إدارة الرسوم الدراسية والمنح',
          labelEn: 'Fees & Scholarships Management',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.fileSpreadsheet,
          label: 'مراقبة المدفوعات والطلاب المتعثرين',
          labelEn: 'Payments & Arrears Monitoring',
          onTap: () {},
        ),
      ],
    );
  }
}

class SecurityAuditingSection extends StatelessWidget {
  const SecurityAuditingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdministrationSectionHeader(
          title: 'الأمن والتدقيق (المرونة)',
          titleEn: 'Security & Auditing',
        ),
        _AdminActionButton(
          icon: LucideIcons.searchCode,
          label: 'سجلات الأحداث (Audit Logs)',
          labelEn: 'Audit Logs',
          onTap: () => context.push('/admin/audit-logs'),
        ),
        _AdminActionButton(
          icon: LucideIcons.eye,
          label: 'مراقبة الجلسات المفتوحة',
          labelEn: 'Session Monitoring',
          onTap: () => context.push('/sessions'),
        ),
        _AdminActionButton(
          icon: LucideIcons.database,
          label: 'إدارة النسخ الاحتياطية',
          labelEn: 'Backups Management',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.fingerprint,
          label: 'تشفير البيانات الحساسة',
          labelEn: 'Sensative Data Encryption',
          onTap: () {},
        ),
        _AdminActionButton(
          icon: LucideIcons.shieldAlert,
          label: 'تنبيهات محاولات الدخول الفاشلة',
          labelEn: 'Login Attempt Alerts',
          onTap: () {},
        ),
      ],
    );
  }
}

class SystemControlSection extends StatelessWidget {
  const SystemControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdministrationSectionHeader(
          title: 'التحكم العام (التنظيم)',
          titleEn: 'General Control',
        ),
        _AdminActionButton(
          icon: LucideIcons.settings,
          label: 'إعدادات العام الدراسي والفصول',
          labelEn: 'Semester & Academic Year Config',
          onTap: () => context.push('/admin/settings'),
        ),
        _AdminActionButton(
          icon: LucideIcons.barChart,
          label: 'إدارة سياسة التقديرات (GPA)',
          labelEn: 'GPA Policy Management',
          onTap: () => context.push('/admin/settings'),
        ),
      ],
    );
  }
}

class AdministrationSectionHeader extends StatelessWidget {
  final String title;
  final String titleEn;

  const AdministrationSectionHeader({
    required this.title,
    required this.titleEn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? title : titleEn,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String labelEn;
  final VoidCallback onTap;

  const _AdminActionButton({
    required this.icon,
    required this.label,
    required this.labelEn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassContainer(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isArabic ? label : labelEn,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const Icon(Icons.chevron_right, size: 16),
          ],
        ),
      ),
    );
  }
}
