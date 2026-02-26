import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
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
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:flutter_riverpod/legacy.dart';

final selectedGroupIdProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

class ProfessorDashboardScreen extends ConsumerWidget {
  final ProfessorProfile profile;

  const ProfessorDashboardScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(professorProfileProvider);
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final color = Colors.indigo;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return const Center(child: Text('Profile not found'));
        }

        final selectedGroupId = ref.watch(selectedGroupIdProvider);
        final filteredGroups = selectedGroupId == null
            ? profile.groups
            : profile.groups.where((g) => g.id == selectedGroupId).toList();

        final studentCount = filteredGroups.fold<int>(
          0,
          (sum, g) => sum + g.studentCount,
        );

        Widget content = CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildGlassSliverAppBar(context, isGlass, color, isArabic, profile),
            SliverToBoxAdapter(
              child: _buildGroupSelector(
                context,
                ref,
                profile,
                isGlass,
                isArabic,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildStatsRow(
                    context,
                    isGlass,
                    color,
                    isArabic,
                    profile,
                    studentCount: studentCount,
                    groupCount: filteredGroups.length,
                  ),
                  const SizedBox(height: 24),
                  _buildQuickActions(
                    context,
                    isGlass,
                    color,
                    isArabic,
                    profile,
                  ),
                  const SizedBox(height: 24),
                  _buildManageSection(
                    context,
                    t.roles.names.teaching_assistant,
                    LucideIcons.users,
                    isGlass,
                    color,
                    t.professor.active_tas_count(
                      count: profile.teachingAssistants.length,
                    ),
                    isArabic,
                    profile,
                  ),
                  const SizedBox(height: 16),
                  _buildManageSection(
                    context,
                    t.professor.stats.groups,
                    LucideIcons.network,
                    isGlass,
                    color,
                    t.professor.total_students_count(count: studentCount),
                    isArabic,
                    profile,
                  ),
                  const SizedBox(height: 16),
                  _buildManageSection(
                    context,
                    t.professor.stats.shared_files,
                    LucideIcons.folderKey,
                    isGlass,
                    color,
                    t.professor.uploaded_files_count(
                      count: profile.sharedFiles.length,
                    ),
                    isArabic,
                    profile,
                  ),
                  const SizedBox(height: 16),
                  _buildManageSection(
                    context,
                    t.professor.stats.office_hours,
                    LucideIcons.clock,
                    isGlass,
                    color,
                    t.professor.weekly_slots_count(
                      count: profile.officeHours.length,
                    ),
                    isArabic,
                    profile,
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
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildGroupSelector(
    BuildContext context,
    WidgetRef ref,
    ProfessorProfile profile,
    bool isGlass,
    bool isArabic,
  ) {
    final selectedId = ref.watch(selectedGroupIdProvider);

    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildGroupChip(
            context,
            ref,
            null,
            isArabic ? 'الكل' : 'All',
            selectedId == null,
            isGlass,
          ),
          ...profile.groups.map(
            (g) => _buildGroupChip(
              context,
              ref,
              g.id,
              g.name,
              selectedId == g.id,
              isGlass,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupChip(
    BuildContext context,
    WidgetRef ref,
    String? id,
    String label,
    bool isSelected,
    bool isGlass,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) =>
            ref.read(selectedGroupIdProvider.notifier).state = id,
        selectedColor: Colors.indigo.withValues(alpha: 0.2),
        backgroundColor: isGlass
            ? Colors.white10
            : Colors.grey.withValues(alpha: 0.1),
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? Colors.indigo
              : (isGlass ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget _buildGlassSliverAppBar(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
    ProfessorProfile profile,
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
                      t.professor.dashboard_title,
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.professor.welcome_back_name(
                        name: profile.name.split(' ').first,
                      ),
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
    ProfessorProfile profile, {
    int? studentCount,
    int? groupCount,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            t.professor.stats.groups,
            (groupCount ?? profile.groups.length).toString(),
            LucideIcons.layoutGrid,
            isGlass,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            t.professor.stats.students,
            (studentCount).toString(),
            LucideIcons.users,
            isGlass,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            t.professor.stats.rating,
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
    ProfessorProfile profile,
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
            t.professor.quick_actions.urgent,
            LucideIcons.megaphone,
            Colors.redAccent,
            isGlass,
            isArabic,
            profile,
          ),
          _buildActionButton(
            context,
            t.professor.quick_actions.upload,
            LucideIcons.uploadCloud,
            Colors.blueAccent,
            isGlass,
            isArabic,
            profile,
          ),
          _buildActionButton(
            context,
            t.professor.quick_actions.message,
            LucideIcons.messageCircle,
            Colors.teal,
            isGlass,
            isArabic,
            profile,
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
    ProfessorProfile profile,
  ) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        if (label == t.professor.quick_actions.message) {
          context.push('/professor-chat', extra: profile);
        } else if (label == t.professor.quick_actions.upload) {
          _showUploadDialog(context, profile);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.professor.action_clicked(action: label)),
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

  void _showUploadDialog(BuildContext context, ProfessorProfile profile) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, child) => AlertDialog(
          title: Text(isArabic ? 'رفع ملف جديد' : 'Upload New File'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: isArabic ? 'عنوان الملف' : 'File Title',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isArabic
                    ? 'سيتم رفع الملف إلى التخزين السحابي'
                    : 'File will be uploaded to cloud storage',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(isArabic ? 'إلغاء' : 'Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty) return;

                await ref
                    .read(professorRepositoryProvider)
                    .uploadSharedFile(
                      professorId: profile.id,
                      title: titleController.text,
                      filePath: 'mock_path.pdf',
                      fileName: 'document.pdf',
                    );

                if (!context.mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isArabic ? 'تم الرفع بنجاح' : 'Uploaded successfully',
                    ),
                  ),
                );
              },
              child: Text(isArabic ? 'رفع' : 'Upload'),
            ),
          ],
        ),
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
    ProfessorProfile profile,
  ) {
    final block = ListTile(
      onTap: () {
        HapticFeedback.mediumImpact();
        if (title == 'Manage TAs' ||
            title == 'إدارة المعيدين' ||
            title == t.roles.names.teaching_assistant) {
          context.push('/manage-tas', extra: profile);
        } else if (title == 'Student Groups' || title == 'المجموعات الطلابية') {
          context.push('/manage-groups', extra: profile);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.professor.activating(target: title)),
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
