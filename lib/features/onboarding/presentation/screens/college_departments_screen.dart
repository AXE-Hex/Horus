import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/data/repositories/institutional_repository.dart';

class CollegeDepartmentsScreen extends ConsumerWidget {
  final CollegeModel college;
  final Color color;

  const CollegeDepartmentsScreen({
    super.key,
    required this.college,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final collegeTitle = isArabic ? college.nameAr : college.nameEn;

    Widget content = SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                _buildBackButton(context, isGlass),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        collegeTitle,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isGlass
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '${college.studentCount} ${t.extracted.students}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: isGlass
                              ? Colors.white70
                              : Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<DepartmentModel>>(
              future: ref
                  .read(institutionalRepositoryProvider)
                  .getDepartments(collegeId: college.id),
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
                      t.admin.no_departments_in_this_college,
                      style: GoogleFonts.inter(
                        color: isGlass
                            ? Colors.white70
                            : Theme.of(context).hintColor,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  itemCount: departments.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (c, i) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final dept = departments[index];
                    final deptName = isArabic ? dept.nameAr : dept.nameEn;

                    return _DepartmentCard(
                      name: deptName,
                      color: color,
                      index: index,
                      isGlass: isGlass,
                      department: dept,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );

    return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
  }

  Widget _buildBackButton(BuildContext context, bool isGlass) {
    final button = IconButton(
      icon: const Icon(LucideIcons.chevronLeft),
      onPressed: () => context.pop(),
    );

    if (isGlass) {
      return GlassContainer(
        borderRadius: BorderRadius.circular(12),
        padding: EdgeInsets.zero,
        child: button,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
        child: button,
      );
    }
  }
}

class _DepartmentCard extends StatelessWidget {
  final String name;
  final Color color;
  final int index;
  final bool isGlass;
  final DepartmentModel department;

  const _DepartmentCard({
    required this.name,
    required this.color,
    required this.index,
    required this.isGlass,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final content = InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        context.push(
          '/department-detail',
          extra: {'department': department, 'color': color},
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isGlass ? null : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: isGlass
              ? null
              : Border.all(color: color.withValues(alpha: 0.1)),
          boxShadow: isGlass
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(LucideIcons.graduationCap, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isGlass
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Tap to view identity & details',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: isGlass ? Colors.white30 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? LucideIcons.chevronLeft
                  : LucideIcons.chevronRight,
              size: 16,
              color: isGlass ? Colors.white38 : Theme.of(context).hintColor,
            ),
          ],
        ),
      ),
    );

    return (isGlass
            ? GlassContainer(
                borderRadius: BorderRadius.circular(20),
                padding: EdgeInsets.zero,
                child: content,
              )
            : content)
        .animate()
        .fadeIn(delay: (index * 50).ms)
        .slideX(begin: 0.1, end: 0);
  }
}
