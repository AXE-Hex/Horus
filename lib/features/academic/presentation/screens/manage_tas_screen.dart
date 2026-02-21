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

class ManageTasScreen extends ConsumerStatefulWidget {
  final ProfessorProfile profile;

  const ManageTasScreen({super.key, required this.profile});

  @override
  ConsumerState<ManageTasScreen> createState() => _ManageTasScreenState();
}

class _ManageTasScreenState extends ConsumerState<ManageTasScreen> {
  late List<TeachingAssistant> currentTAs;

  @override
  void initState() {
    super.initState();
    currentTAs = List.from(widget.profile.teachingAssistants);
  }

  void _showAddTaBottomSheet(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    // Filter out TAs already in the list
    final availableTAs = globalFacultyTAs
        .where((ta) => !currentTAs.any((c) => c.id == ta.id))
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final content = Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: isGlass ? null : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isArabic ? 'إضافة معيد جديد' : 'Add New TA',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: availableTAs.isEmpty
                    ? Center(
                        child: Text(
                          isArabic
                              ? 'لا يوجد معيدون متاحون'
                              : 'No available TAs',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: isGlass ? Colors.white60 : Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: availableTAs.length,
                        itemBuilder: (context, index) {
                          final ta = availableTAs[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: color.withValues(alpha: 0.1),
                              child: Icon(LucideIcons.userPlus, color: color),
                            ),
                            title: Text(
                              ta.name,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                color: isGlass ? Colors.white : Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                              ta.email,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: isGlass
                                    ? Colors.white60
                                    : Colors.black54,
                              ),
                            ),
                            trailing: OutlinedButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                setState(() {
                                  currentTAs.add(ta);
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${isArabic ? "تم إضافة:" : "Added:"} ${ta.name}',
                                    ),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: color,
                                side: BorderSide(
                                  color: color.withValues(alpha: 0.5),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(isArabic ? 'إضافة' : 'Add'),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );

        return isGlass
            ? GlassContainer(
                padding: EdgeInsets.zero,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: content,
              )
            : content;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final color = Colors.indigo;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 120,
          pinned: true,
          backgroundColor: isGlass
              ? Colors.transparent
              : theme.scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              LucideIcons.chevronLeft,
              color: isGlass ? Colors.white : Colors.black87,
            ),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(LucideIcons.plusCircle, color: color),
              onPressed: () {
                HapticFeedback.selectionClick();
                _showAddTaBottomSheet(context, isGlass, color, isArabic);
              },
            ).animate().scale(delay: 200.ms),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            title: Text(
              isArabic ? 'إدارة المعيدين' : 'Manage TAs',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          sliver: currentTAs.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        Icon(
                          LucideIcons.users,
                          size: 64,
                          color: isGlass ? Colors.white24 : Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isArabic ? 'لا يوجد معيدون حالياً' : 'No Active TAs',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            color: isGlass ? Colors.white70 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final ta = currentTAs[index];
                    final block = ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: color.withValues(alpha: 0.1),
                        child: Icon(LucideIcons.user, color: color),
                      ),
                      title: Text(
                        ta.name,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isGlass ? Colors.white : Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            ta.role,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            ta.email,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: isGlass ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          LucideIcons.trash2,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          setState(() {
                            currentTAs.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${isArabic ? "تم إزالة:" : "Removed:"} ${ta.name}',
                              ),
                            ),
                          );
                        },
                      ),
                    );

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: isGlass
                          ? GlassContainer(
                                  padding: EdgeInsets.zero,
                                  child: block,
                                )
                                .animate()
                                .fadeIn(
                                  delay: Duration(milliseconds: 50 * index),
                                )
                                .slideX(begin: 0.1)
                          : Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: block,
                                )
                                .animate()
                                .fadeIn(
                                  delay: Duration(milliseconds: 50 * index),
                                )
                                .slideX(begin: 0.1),
                    );
                  }, childCount: currentTAs.length),
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
}
