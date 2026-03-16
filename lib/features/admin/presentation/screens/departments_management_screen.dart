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

class DepartmentsManagementScreen extends ConsumerWidget {
  final String? collegeId;
  const DepartmentsManagementScreen({super.key, this.collegeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.departments_management,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plus),
            onPressed: () => _showAddDepartmentDialog(context, ref),
          ),
        ],
      ),
      body: FutureBuilder<List<DepartmentModel>>(
        future: ref
            .read(institutionalRepositoryProvider)
            .getDepartments(collegeId: collegeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final departments = snapshot.data ?? [];

          if (departments.isEmpty) {
            return Center(
              child: Text(
                t.admin.no_departments_found,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: departments.length,
            itemBuilder: (context, index) {
              final dept = departments[index];
              return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GlassContainer(
                      onTap: () => context.push(
                        '/admin/departments/details',
                        extra: dept,
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
                                  Colors.purple.withValues(alpha: 0.2),
                                  Colors.purple.withValues(alpha: 0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.purple.withValues(alpha: 0.1),
                              ),
                            ),
                            child: const Icon(
                              LucideIcons.layout,
                              color: Colors.purpleAccent,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic ? dept.nameAr : dept.nameEn,
                                  style: GoogleFonts.outfit(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  (isArabic
                                          ? dept.descriptionAr
                                          : dept.descriptionEn) ??
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
                          // Actions
                          _buildCircleButton(
                            context,
                            LucideIcons.edit2,
                            Colors.white.withValues(alpha: 0.1),
                            () => _showDepartmentFormDialog(
                              context,
                              ref,
                              dept: dept,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildCircleButton(
                            context,
                            LucideIcons.trash2,
                            Colors.redAccent.withValues(alpha: 0.1),
                            () => _confirmDelete(context, ref, dept),
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

  void _showAddDepartmentDialog(BuildContext context, WidgetRef ref) {
    _showDepartmentFormDialog(context, ref);
  }

  void _showDepartmentFormDialog(
    BuildContext context,
    WidgetRef ref, {
    DepartmentModel? dept,
  }) {
    final nameEnController = TextEditingController(text: dept?.nameEn);
    final nameArController = TextEditingController(text: dept?.nameAr);
    final descEnController = TextEditingController(text: dept?.descriptionEn);
    final descArController = TextEditingController(text: dept?.descriptionAr);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(dept == null ? 'Add Department' : 'Edit Department'),
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
                if (collegeId != null && dept == null) 'college_id': collegeId,
              };
              final repo = ref.read(institutionalRepositoryProvider);
              if (dept == null) {
                await repo.createDepartment(data);
              } else {
                await repo.updateDepartment(dept.id, data);
              }
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: Text(dept == null ? 'Create' : 'Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    DepartmentModel dept,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Delete ${dept.nameEn}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(institutionalRepositoryProvider)
                  .deleteDepartment(dept.id);
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
