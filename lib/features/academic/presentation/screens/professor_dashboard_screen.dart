// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/academic/data/models/professor_profile_models.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfessorDashboardScreen extends ConsumerWidget {
  final ProfessorProfile profile;

  const ProfessorDashboardScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final color = Colors.indigo; // Different theme for management side
    final isArabic = t.$meta.locale.languageCode == 'ar';

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildGlassSliverAppBar(context, isGlass, color, isArabic),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildStatsRow(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildQuickActions(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildManageSection(
                context,
                isArabic ? 'إدارة المعيدين' : 'Manage TAs',
                LucideIcons.users,
                isGlass,
                color,
                '${profile.teachingAssistants.length} ${isArabic ? 'معيد حالي' : 'Active TAs'}',
                isArabic,
              ),
              const SizedBox(height: 16),
              _buildManageSection(
                context,
                isArabic ? 'المجموعات الطلابية' : 'Student Groups',
                LucideIcons.network,
                isGlass,
                color,
                '${profile.groups.fold(0, (sum, g) => sum + g.studentCount)} ${isArabic ? 'إجمالي الطلاب' : 'Total Students'}',
                isArabic,
              ),
              const SizedBox(height: 16),
              _buildManageSection(
                context,
                isArabic ? 'الملفات المشتركة' : 'Shared Files',
                LucideIcons.folderKey,
                isGlass,
                color,
                '${profile.sharedFiles.length} ${isArabic ? 'ملف مرفوع' : 'Uploaded Files'}',
                isArabic,
              ),
              const SizedBox(height: 16),
              _buildManageSection(
                context,
                isArabic ? 'الساعات المكتبية' : 'Office Hours',
                LucideIcons.clock,
                isGlass,
                color,
                '${profile.officeHours.length} ${isArabic ? 'مواعيد أسبوعية' : 'Weekly Slots'}',
                isArabic,
              ),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );

    return isGlass
        ? GlassScaffold(body: content)
        : Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: content,
          );
  }

  Widget _buildGlassSliverAppBar(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    return GlassSliverAppBar(
      expandedHeight: 160,
      pinned: true,
      backgroundColor: isGlass ? Colors.transparent : color,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(LucideIcons.chevronLeft, color: Colors.white),
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color, color.withValues(alpha: 0.7)],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Professor Dashboard',
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Welcome back, ${profile.name.split(' ').first}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            isArabic ? 'المجموعات' : 'Groups',
            profile.groups.length.toString(),
            LucideIcons.layoutGrid,
            isGlass,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            isArabic ? 'إجمالي الطلاب' : 'Total Students',
            profile.groups.fold(0, (sum, g) => sum + g.studentCount).toString(),
            LucideIcons.users,
            isGlass,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            isArabic ? 'التقييم' : 'Rating',
            profile.generalRating.toString(),
            LucideIcons.star,
            isGlass,
            Colors.amber,
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    bool isGlass,
    Color iconColor,
  ) {
    final block = Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isGlass ? null : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isGlass
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                ),
              ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: isGlass ? Colors.white : null,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: isGlass ? Colors.white60 : Colors.grey,
            ),
          ),
        ],
      ),
    );
    return isGlass
        ? GlassContainer(padding: EdgeInsets.zero, child: block)
        : block;
  }

  Widget _buildQuickActions(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    final block = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            context,
            isArabic ? 'عاجل' : 'Urgent',
            LucideIcons.megaphone,
            Colors.redAccent,
            isGlass,
            isArabic,
          ),
          _buildActionButton(
            context,
            isArabic ? 'رفع' : 'Upload',
            LucideIcons.uploadCloud,
            Colors.blueAccent,
            isGlass,
            isArabic,
          ),
          _buildActionButton(
            context,
            isArabic ? 'مراسلة' : 'Message',
            LucideIcons.messageCircle,
            Colors.teal,
            isGlass,
            isArabic,
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            padding: EdgeInsets.zero,
            child: block,
          ).animate().fadeIn()
        : block.animate().fadeIn();
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        if (label == 'Message' || label == 'مراسلة') {
          context.push('/professor-chat', extra: profile);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${isArabic ? "تم النقر:" : "Clicked:"} $label'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isGlass
                ? Colors.white12
                : color.withValues(alpha: 0.1),
            child: Icon(icon, color: isGlass ? color : color),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isGlass ? Colors.white : color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageSection(
    BuildContext context,
    String title,
    IconData icon,
    bool isGlass,
    Color color,
    String subtitle,
    bool isArabic,
  ) {
    final block = ListTile(
      onTap: () {
        HapticFeedback.mediumImpact();
        if (title == 'Manage TAs' || title == 'إدارة المعيدين') {
          context.push('/manage-tas', extra: profile);
        } else if (title == 'Student Groups' || title == 'المجموعات الطلابية') {
          context.push('/manage-groups', extra: profile);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${isArabic ? "تفعيل:" : "Activating:"} $title'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isGlass ? Colors.white12 : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: isGlass ? Colors.white : color),
      ),
      title: Text(
        title,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: isGlass ? Colors.white : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: isGlass ? Colors.white60 : Colors.grey,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isGlass ? Colors.white12 : Colors.grey.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          LucideIcons.chevronRight,
          size: 16,
          color: isGlass ? Colors.white70 : Colors.black54,
        ),
      ),
    );

    return isGlass
        ? GlassContainer(
            padding: EdgeInsets.zero,
            child: block,
          ).animate().fadeIn()
        : Card(child: block).animate().fadeIn();
  }
}
