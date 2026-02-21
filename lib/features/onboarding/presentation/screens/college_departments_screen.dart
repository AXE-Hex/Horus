// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/i18n/strings.g.dart';
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

class CollegeDepartmentsScreen extends ConsumerWidget {
  final Map<String, dynamic> collegeData;

  const CollegeDepartmentsScreen({super.key, required this.collegeData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final color = collegeData['color'] as Color;
    final departments = collegeData['departments'] as List<dynamic>? ?? [];
    final collegeTitle =
        (collegeData['title'] as String Function(Translations))(t);

    Widget content = SafeArea(
      child: Column(
        children: [
          // HEADER
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
                        '${departments.length} ${t.colleges.details.majors}',
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

          // DEPARTMENTS LIST
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              itemCount: departments.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (c, i) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final deptKey = departments[index] as String;
                final deptName = t['colleges.departments.$deptKey'] as String;

                return _DepartmentCard(
                  name: deptName,
                  color: color,
                  index: index,
                  isGlass: isGlass,
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

  const _DepartmentCard({
    required this.name,
    required this.color,
    required this.index,
    required this.isGlass,
  });

  @override
  Widget build(BuildContext context) {
    final content = InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        context.push(
          '/department-detail',
          extra: {
            'name': name,
            'color': color,
            'key': name.toLowerCase().replaceAll(
              ' ',
              '_',
            ), // Simple key generation
          },
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
              LucideIcons.chevronRight,
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
