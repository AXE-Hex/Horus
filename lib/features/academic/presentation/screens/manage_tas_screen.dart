import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/academic/data/models/professor_profile_models.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ManageTasScreen extends HookConsumerWidget {
  final ProfessorProfile profile;

  const ManageTasScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(professorProfileProvider);
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final color = const Color(0xFF6366F1);

    return profileAsync.when(
      data: (currentProfile) {
        final tas = currentProfile?.teachingAssistants ?? [];

        final content = CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(
              context,
              isGlass,
              color,
              isArabic,
              ref,
              tas,
              currentProfile,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              sliver: tas.isEmpty
                  ? _buildEmptyState(isGlass, isArabic)
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final ta = tas[index];
                        return _TACard(
                              ta: ta,
                              index: index,
                              isGlass: isGlass,
                              isArabic: isArabic,
                              color: color,
                              onDelete: () => _handleDelete(
                                context,
                                ref,
                                ta,
                                currentProfile,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: (50 * index).ms)
                            .slideX(begin: isArabic ? -0.1 : 0.1);
                      }, childCount: tas.length),
                    ),
            ),
          ],
        );

        return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
    WidgetRef ref,
    List<TeachingAssistant> currentTAs,
    ProfessorProfile? profile,
  ) {
    return GlassSliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: isGlass ? Colors.transparent : null,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          isArabic ? LucideIcons.chevronRight : LucideIcons.chevronLeft,
          color: Colors.white,
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(LucideIcons.userPlus, color: color, size: 20),
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            _showAddTaBottomSheet(
              context,
              ref,
              isGlass,
              color,
              isArabic,
              currentTAs,
              profile,
            );
          },
        ).animate().scale(delay: 400.ms),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        title: Text(
          t.academic.manage_tas,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isGlass, bool isArabic) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.users,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  duration: 2.seconds,
                  curve: Curves.easeInOut,
                ),
            const SizedBox(height: 24),
            Text(
              t.academic.no_tas_assigned_yet,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.academic.start_by_adding_the_first_ta_f,
              style: GoogleFonts.outfit(fontSize: 14, color: Colors.white38),
            ),
          ],
        ).animate().fadeIn(duration: 800.ms),
      ),
    );
  }

  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
    TeachingAssistant ta,
    ProfessorProfile? profile,
  ) async {
    HapticFeedback.heavyImpact();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          t.academic.confirm_removal,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          t.academic.are_you_sure_you_want_to_remov,
          style: GoogleFonts.outfit(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              t.academic.cancel,
              style: const TextStyle(color: Colors.white38),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              t.academic.remove,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && profile != null) {
      await ref.read(professorRepositoryProvider).removeTA(ta.id);
      if (!context.mounted) return;
      ref.invalidate(professorProfileProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(t.academic.removed_successfully),
        ),
      );
    }
  }

  void _showAddTaBottomSheet(
    BuildContext context,
    WidgetRef parentRef,
    bool isGlass,
    Color color,
    bool isArabic,
    List<TeachingAssistant> currentTAs,
    ProfessorProfile? profile,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          final taAsync = ref.watch(availableTAsProvider);

          return GlassContainer(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    t.academic.add_new_ta,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.academic.select_a_ta_from_the_list_to_a,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.white38,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: taAsync.when(
                      data: (tas) {
                        final availableTAs = tas
                            .where(
                              (ta) => !currentTAs.any((c) => c.id == ta.id),
                            )
                            .toList();

                        if (availableTAs.isEmpty) {
                          return Center(
                            child: Text(
                              t.academic.no_available_tas_currently,
                              style: const TextStyle(color: Colors.white38),
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: availableTAs.length,
                          itemBuilder: (context, index) {
                            final ta = availableTAs[index];
                            return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: GlassContainer(
                                    padding: const EdgeInsets.all(12),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: color.withValues(
                                          alpha: 0.1,
                                        ),
                                        child: Icon(
                                          LucideIcons.userPlus,
                                          color: color,
                                          size: 20,
                                        ),
                                      ),
                                      title: Text(
                                        ta.name,
                                        style: GoogleFonts.outfit(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        ta.email,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.white38,
                                        ),
                                      ),
                                      trailing: ElevatedButton(
                                        onPressed: () async {
                                          if (profile != null) {
                                            await ref
                                                .read(
                                                  professorRepositoryProvider,
                                                )
                                                .addTA({
                                                  'professor_id': profile.id,
                                                  'profile_id': ta.id,
                                                  'ta_role': ta.role,
                                                  'is_active': true,
                                                });
                                            if (!context.mounted) return;
                                            ref.invalidate(
                                              professorProfileProvider,
                                            );
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: color,
                                                content: Text(
                                                  t.academic.added_successfully,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Text(t.academic.add),
                                      ),
                                    ),
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: (50 * index).ms)
                                .slideY(begin: 0.1, end: 0);
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TACard extends StatelessWidget {
  final TeachingAssistant ta;
  final int index;
  final bool isGlass;
  final bool isArabic;
  final Color color;
  final VoidCallback onDelete;

  const _TACard({
    required this.ta,
    required this.index,
    required this.isGlass,
    required this.isArabic,
    required this.color,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(LucideIcons.user, color: color, size: 32),
                  ),
                ),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.transparent, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ta.name,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      ta.role,
                      style: GoogleFonts.shareTechMono(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ta.email,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                LucideIcons.trash2,
                color: Colors.redAccent,
                size: 20,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
