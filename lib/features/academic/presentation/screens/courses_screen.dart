import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/features/academic/presentation/providers/course_catalog_provider.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CoursesScreen extends ConsumerWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentId = ref.watch(authControllerProvider).user?.id;
    if (studentId == null) {
      return Scaffold(body: Center(child: Text(t.auth.login.sign_in_failed)));
    }

    final catalog = ref.watch(courseCatalogProvider(studentId));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: t.academic.back,
            onPressed: () => context.pop(),
            icon: const Icon(LucideIcons.arrowLeft),
          ),
          title: Text(t.academic.courses),
          bottom: TabBar(
            tabs: [
              Tab(text: t.academic.enrolled),
              Tab(text: t.academic.available),
            ],
          ),
        ),
        body: catalog.when(
          data: (state) => TabBarView(
            children: [
              _CourseList(courses: state.enrolledCourses),
              _CourseList(courses: state.availableCourses),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => _CourseLoadError(
            onRetry: () => ref.invalidate(courseCatalogProvider(studentId)),
          ),
        ),
      ),
    );
  }
}

class _CourseList extends StatelessWidget {
  const _CourseList({required this.courses});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.bookOpen,
                size: 36,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(t.academic.no_data, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.xl),
      itemCount: courses.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: _CourseCard(course: courses[index]),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final theme = Theme.of(context);
    final name = isArabic ? (course.nameAr ?? course.name) : course.name;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    course.code,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const Icon(LucideIcons.clock3, size: 16),
                const SizedBox(width: AppSpacing.xs),
                Text('${course.credits} ${t.academic.credits}'),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(name, style: theme.textTheme.titleMedium),
            if (course.description?.isNotEmpty == true) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(course.description!, style: theme.textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}

class _CourseLoadError extends StatelessWidget {
  const _CourseLoadError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(t.academic.error, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(onPressed: onRetry, child: Text(t.academic.retry)),
        ],
      ),
    ),
  );
}
