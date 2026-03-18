import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';

final departmentProjectsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((
      ref,
      departmentId,
    ) async {
      return await ref
          .read(academicRepositoryProvider)
          .getDepartmentProjects(departmentId);
    });

class SpecializationProjectsScreen extends ConsumerWidget {
  const SpecializationProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    final auth = ref.watch(authControllerProvider);
    final departmentId = auth.user?.userMetadata?['department_id'] as String?;

    if (departmentId == null || departmentId.isEmpty) {
      final noDepBody = CustomScrollView(
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
              t.academic.specialization_projects,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.folderX, size: 64, color: Colors.white24),
                  const SizedBox(height: 16),
                  Text(
                    t.extracted.no_projects_available_yet,
                    style: GoogleFonts.outfit(color: Colors.white60),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
      return isGlass
          ? GlassScaffold(body: noDepBody)
          : Scaffold(body: noDepBody);
    }

    final projectsAsync = ref.watch(departmentProjectsProvider(departmentId));

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
            t.academic.specialization_projects,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: projectsAsync.when(
            data: (projects) {
              if (projects.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.folderX,
                          size: 64,
                          color: Colors.white24,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          t.extracted.no_projects_available_yet,
                          style: GoogleFonts.outfit(color: Colors.white60),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final project = projects[index];
                  return _buildProjectCard(
                    context,
                    project,
                    isGlass,
                    isArabic,
                    index,
                  );
                }, childCount: projects.length),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => SliverFillRemaining(
              child: Center(
                child: Text("Error: $err", style: TextStyle(color: Colors.red)),
              ),
            ),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildProjectCard(
    BuildContext context,
    Map<String, dynamic> project,
    bool isGlass,
    bool isArabic,
    int index,
  ) {
    final title = isArabic
        ? (project['title_ar'] ?? project['title_en'])
        : project['title_en'];
    final description = isArabic
        ? (project['description_ar'] ?? project['description_en'])
        : project['description_en'];
    final status = project['status'] ?? 'active';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child:
          GlassContainer(
                padding: const EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _buildStatusBadge(status, isArabic),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.calendar,
                          size: 16,
                          color: Colors.white38,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateTime.parse(
                            project['created_at'],
                          ).toLocal().toString().split(' ')[0],
                          style: GoogleFonts.shareTechMono(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                t.extracted.details,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                LucideIcons.chevronRight,
                                size: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate(delay: (index * 100).ms)
              .fadeIn(duration: 500.ms)
              .slideX(begin: 0.1, end: 0),
    );
  }

  Widget _buildStatusBadge(String status, bool isArabic) {
    Color color = Colors.blue;
    String text = status;

    switch (status) {
      case 'active':
        color = Colors.greenAccent;
        text = t.extracted.active;
        break;
      case 'completed':
        color = Colors.blueAccent;
        text = t.extracted.completed;
        break;
      case 'paused':
        color = Colors.orangeAccent;
        text = t.extracted.paused;
        break;
      case 'cancelled':
        color = Colors.redAccent;
        text = t.extracted.cancelled;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
