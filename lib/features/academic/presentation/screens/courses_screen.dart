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

class _CourseList extends StatefulWidget {
  const _CourseList({required this.courses});

  final List<Course> courses;

  @override
  State<_CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<_CourseList> {
  String? _selectedCourseCode;

  @override
  Widget build(BuildContext context) {
    final courses = widget.courses;
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

    final selected = courses.cast<Course?>().firstWhere(
      (course) => course?.code == _selectedCourseCode,
      orElse: () => courses.first,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 820) {
          return _CourseListView(
            courses: courses,
            selectedCourseCode: _selectedCourseCode,
            onSelect: (course) => setState(() {
              _selectedCourseCode = course.code;
            }),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: constraints.maxWidth >= 1120 ? 360 : 300,
              child: _CourseListView(
                courses: courses,
                selectedCourseCode: selected?.code ?? _selectedCourseCode,
                onSelect: (course) => setState(() {
                  _selectedCourseCode = course.code;
                }),
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _CourseWorkspaceSummary(course: selected ?? courses.first),
            ),
          ],
        );
      },
    );
  }
}

class _CourseListView extends StatelessWidget {
  const _CourseListView({
    required this.courses,
    required this.selectedCourseCode,
    required this.onSelect,
  });

  final List<Course> courses;
  final String? selectedCourseCode;
  final ValueChanged<Course> onSelect;

  @override
  Widget build(BuildContext context) => ListView.builder(
    padding: const EdgeInsets.all(AppSpacing.lg),
    itemCount: courses.length,
    itemBuilder: (context, index) {
      final course = courses[index];
      final selected = course.code == selectedCourseCode;
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: _CourseCard(
          course: course,
          selected: selected,
          onTap: () => onSelect(course),
        ),
      );
    },
  );
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course, this.selected = false, this.onTap});

  final Course course;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final theme = Theme.of(context);
    final name = isArabic ? (course.nameAr ?? course.name) : course.name;

    return Card(
      color: selected ? theme.colorScheme.primaryContainer : null,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
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
      ),
    );
  }
}

class _CourseWorkspaceSummary extends StatelessWidget {
  const _CourseWorkspaceSummary({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final theme = Theme.of(context);
    final name = isArabic ? (course.nameAr ?? course.name) : course.name;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  LucideIcons.bookOpen,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                course.code,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(name, style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.md),
              Text(
                '${course.credits} ${t.academic.credits}',
                style: theme.textTheme.titleSmall,
              ),
              if (course.description?.isNotEmpty == true) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(course.description!, style: theme.textTheme.bodyLarge),
              ],
            ],
          ),
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
