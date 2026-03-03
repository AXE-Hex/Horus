import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/data/repositories/institutional_repository.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CollegesManagementScreen extends ConsumerWidget {
  const CollegesManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.colleges_management,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plus),
            onPressed: () => _showAddCollegeDialog(context, ref),
          ),
        ],
      ),
      body: FutureBuilder<List<CollegeModel>>(
        future: ref.read(institutionalRepositoryProvider).getColleges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final colleges = snapshot.data ?? [];

          if (colleges.isEmpty) {
            return Center(
              child: Text(
                t.admin.no_colleges_found,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: colleges.length,
            itemBuilder: (context, index) {
              final college = colleges[index];
              return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GlassContainer(
                      onTap: () => context.push(
                        '/admin/colleges/details',
                        extra: college,
                      ),
                      padding: const EdgeInsets.all(24),
                      borderRadius: BorderRadius.circular(30),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.2),
                                  Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Icon(
                              LucideIcons.building,
                              color: Theme.of(context).primaryColor,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic ? college.nameAr : college.nameEn,
                                  style: GoogleFonts.outfit(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  (isArabic
                                          ? college.descriptionAr
                                          : college.descriptionEn) ??
                                      '',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.white.withValues(alpha: 0.4),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildCircleButton(
                            context,
                            LucideIcons.trash2,
                            Colors.redAccent.withValues(alpha: 0.1),
                            () => _confirmDelete(context, ref, college),
                            iconColor: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: (index * 50).ms, duration: 400.ms)
                  .slideX(
                    begin: 0.1,
                    end: 0,
                    delay: (index * 50).ms,
                    duration: 400.ms,
                  );
            },
          );
        },
      ),
    );
  }

  void _showAddCollegeDialog(BuildContext context, WidgetRef ref) {
    _showCollegeFormDialog(context, ref);
  }

  void _showCollegeFormDialog(
    BuildContext context,
    WidgetRef ref, {
    CollegeModel? college,
  }) {
    final nameEnController = TextEditingController(text: college?.nameEn);
    final nameArController = TextEditingController(text: college?.nameAr);
    final descEnController = TextEditingController(
      text: college?.descriptionEn,
    );
    final descArController = TextEditingController(
      text: college?.descriptionAr,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(college == null ? 'Add College' : 'Edit College'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameEnController,
                decoration: const InputDecoration(labelText: 'Name (EN)'),
              ),
              TextField(
                controller: nameArController,
                decoration: const InputDecoration(labelText: 'Name (AR)'),
              ),
              TextField(
                controller: descEnController,
                decoration: const InputDecoration(
                  labelText: 'Description (EN)',
                ),
              ),
              TextField(
                controller: descArController,
                decoration: const InputDecoration(
                  labelText: 'Description (AR)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final data = {
                'name': nameEnController.text,
                'name_ar': nameArController.text,
                'description': descEnController.text,
                'description_ar': descArController.text,
              };
              final repo = ref.read(institutionalRepositoryProvider);
              if (college == null) {
                await repo.createCollege(data);
              } else {
                await repo.updateCollege(college.id, data);
              }
              if (!context.mounted) return;
              Navigator.pop(context);
              // Trigger refresh (simple restart for now or use a provider for list)
            },
            child: Text(college == null ? 'Create' : 'Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    CollegeModel college,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Delete ${college.nameEn}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(institutionalRepositoryProvider)
                  .deleteCollege(college.id);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(
    BuildContext context,
    IconData icon,
    Color bgColor,
    VoidCallback onTap, {
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 18,
            color: iconColor ?? Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
