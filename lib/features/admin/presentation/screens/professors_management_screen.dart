import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:hue/features/admin/data/repositories/institutional_repository.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfessorsManagementScreen extends ConsumerWidget {
  const ProfessorsManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.faculty_management,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ref.read(professorRepositoryProvider).getAllProfessors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final professors = snapshot.data ?? [];

          if (professors.isEmpty) {
            return Center(child: Text(t.admin.no_faculty_records_found));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: professors.length,
            itemBuilder: (context, index) {
              final doc = professors[index];
              final profile = doc['profiles'] as Map<String, dynamic>?;
              final fullName = isArabic
                  ? (profile?['full_name_ar'] ?? profile?['full_name'] ?? 'Doc')
                  : (profile?['full_name'] ?? 'Doc');

              return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GlassContainer(
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
                                  Colors.blueAccent.withValues(alpha: 0.2),
                                  Colors.blueAccent.withValues(alpha: 0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.blueAccent.withValues(alpha: 0.1),
                              ),
                            ),
                            child: const Icon(
                              LucideIcons.user,
                              color: Colors.blueAccent,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  style: GoogleFonts.outfit(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${t.admin.office}: ${doc['office_symbol'] ?? "-"}',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildCircleButton(
                            context,
                            LucideIcons.edit2,
                            Colors.white.withValues(alpha: 0.1),
                            () => _showEditDoctorDialog(context, ref, doc),
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

  void _showEditDoctorDialog(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> doctor,
  ) {
    final officeController = TextEditingController(
      text: doctor['office_symbol'],
    );
    final currentDeptId = doctor['department_id'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Faculty Detail'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: officeController,
              decoration: const InputDecoration(
                labelText: 'Office Symbol/Number',
              ),
            ),
            const SizedBox(height: 16),

            FutureBuilder(
              future: ref
                  .read(institutionalRepositoryProvider)
                  .getDepartments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LinearProgressIndicator();
                final depts = snapshot.data!;
                return DropdownButtonFormField<String>(
                  initialValue: depts.any((d) => d.id == currentDeptId)
                      ? currentDeptId
                      : null,
                  decoration: const InputDecoration(labelText: 'Department'),
                  items: depts
                      .map(
                        (d) => DropdownMenuItem(
                          value: d.id,
                          child: Text(
                            t.$meta.locale.languageCode == 'ar'
                                ? d.nameAr
                                : d.nameEn,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    doctor['department_id'] = val;
                  },
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(professorRepositoryProvider)
                  .updateProfessorDetail(doctor['id'], {
                    'office_symbol': officeController.text,
                    'department_id': doctor['department_id'],
                  });
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: const Text('Save'),
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
