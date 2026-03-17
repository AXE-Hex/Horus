import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:hue/core/data/supabase_providers.dart';
import 'package:hue/core/auth/auth_provider.dart';

final actionPlanProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, studentId) async {
  return await ref.read(academicRepositoryProvider).getActionPlan(studentId);
});

class ActionPlanScreen extends ConsumerWidget {
  const ActionPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final auth = ref.watch(authControllerProvider);
    final studentId = auth.user?.id;
    
    if (studentId == null) {
      return const Scaffold(body: Center(child: Text('User not signed in')));
    }

    final actionPlanAsync = ref.watch(actionPlanProvider(studentId));

    return actionPlanAsync.when(
      data: (rawData) {
        
        // Ensure we group data logically by year if needed, or map directly
        final List<Map<String, dynamic>> timelineData = rawData.map((item) {
          final isCompleted = item['status'] == 'completed';
          final isInProgress = item['status'] == 'in_progress';
          Color color = Colors.white24;
          IconData icon = LucideIcons.circle;

          if (isCompleted) {
            color = const Color(0xFF10B981);
            icon = LucideIcons.checkCircle;
          } else if (isInProgress) {
            color = const Color(0xFF6366F1);
            icon = LucideIcons.playCircle;
          }

          return {
            'title': 'Year ${item['year'] ?? 1}',
            'subtitle': item['title'] ?? t.academic.foundational_skills,
            'status': item['status'] ?? 'remaining',
            'progress': isCompleted ? 1.0 : (isInProgress ? 0.5 : 0.0),
            'icon': icon,
            'color': color,
            'tasks': (item['tasks'] as List<dynamic>?)?.map((t) => {
              'label': t['label']?.toString() ?? 'Task',
              'done': t['done'] == true,
            }).toList() ?? [],
          };
        }).toList();

        int totalTasks = 0;
        int completedTasks = 0;
        for (final year in timelineData) {
          final tasks = year['tasks'] as List;
          totalTasks += tasks.length;
          completedTasks += tasks.where((t) => t['done'] == true).length;
        }
        
        final double overallProgress = totalTasks > 0 ? (completedTasks / totalTasks) : 0.0;
        final int progressPercentage = (overallProgress * 100).toInt();

        final body = CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
        GlassSliverAppBar(
          expandedHeight: 120,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: Text(
            t.academic.action_plan,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: timelineData.isEmpty 
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      t.academic.no_data, // Fallback string assuming it might exist or generic text
                      style: GoogleFonts.outfit(color: Colors.white60, fontSize: 16),
                    ),
                  ),
                )
              : _buildProgressHeader(isArabic, progressPercentage, overallProgress),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _TimelineItem(
                data: timelineData[index],
                isFirst: index == 0,
                isLast: index == timelineData.length - 1,
                index: index,
                isArabic: isArabic,
              );
            }, childCount: timelineData.length),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildProgressHeader(bool isArabic, int progressPercentage, double overallProgress) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(32),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.academic.overall_progress,
                    style: GoogleFonts.outfit(
                      color: Colors.white60,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$progressPercentage%',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Icon(
                LucideIcons.trendingUp,
                color: Color(0xFF10B981),
                size: 32,
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 12,
              width: double.infinity,
              color: Colors.white10,
              child: Stack(
                children: [
                  Container(
                    width: 300 * overallProgress,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF10B981)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withValues(alpha: 0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ).animate().shimmer(duration: 2.seconds),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isFirst;
  final bool isLast;
  final int index;
  final bool isArabic;

  const _TimelineItem({
    required this.data,
    required this.isFirst,
    required this.isLast,
    required this.index,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final status = data['status'] as String;
    final isCompleted = status == 'completed';
    final isInProgress = status == 'in_progress';
    final color = data['color'] as Color;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLine(isFirst, isLast, isCompleted, isInProgress, color),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _buildCard(isCompleted, isInProgress, color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(
    bool isFirst,
    bool isLast,
    bool isCompleted,
    bool isInProgress,
    Color color,
  ) {
    return Column(
      children: [
        if (!isFirst)
          Container(
            width: 2,
            height: 20,
            color: isCompleted ? color : Colors.white10,
          ),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isCompleted
                ? color
                : (isInProgress ? Colors.white : Colors.white10),
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted || isInProgress ? color : Colors.white24,
              width: 2,
            ),
            boxShadow: isCompleted || isInProgress
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            isCompleted
                ? LucideIcons.check
                : (isInProgress ? LucideIcons.play : LucideIcons.lock),
            size: 14,
            color: isCompleted || isInProgress ? Colors.black : Colors.white24,
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              color: isCompleted ? color : Colors.white10,
            ),
          ),
      ],
    );
  }

  Widget _buildCard(bool isCompleted, bool isInProgress, Color color) {
    return GlassContainer(
          borderRadius: BorderRadius.circular(24),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isCompleted || isInProgress
                          ? color.withValues(alpha: 0.15)
                          : Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      data['icon'] as IconData,
                      color: isCompleted || isInProgress
                          ? color
                          : Colors.white24,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isCompleted || isInProgress
                                ? Colors.white
                                : Colors.white38,
                          ),
                        ),
                        Text(
                          data['subtitle'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isCompleted)
                    const Icon(
                      LucideIcons.shieldCheck,
                      color: Color(0xFF10B981),
                      size: 20,
                    ),
                ],
              ),
              if (isInProgress) ...[
                const SizedBox(height: 20),
                _buildTaskList(
                  data['tasks'] as List<Map<String, dynamic>>,
                  color,
                ),
              ],
            ],
          ),
        )
        .animate(delay: (index * 150).ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.1, end: 0);
  }

  Widget _buildTaskList(List<Map<String, dynamic>> tasks, Color color) {
    return Column(
      children: tasks.map((task) {
        final done = task['done'] as bool;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(
                done ? LucideIcons.checkSquare : LucideIcons.square,
                size: 16,
                color: done ? color : Colors.white24,
              ),
              const SizedBox(width: 12),
              Text(
                task['label'] as String,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: done ? Colors.white70 : Colors.white24,
                  decoration: done ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
