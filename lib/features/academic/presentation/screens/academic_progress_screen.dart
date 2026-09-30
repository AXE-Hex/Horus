import 'package:horus/shared/widgets/app_card.dart';
import 'package:horus/shared/widgets/horus_error_state.dart';
import 'package:horus/shared/layout/horus_page_body.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/academic/data/repositories/professor_repository.dart';

class AcademicProgressScreen extends ConsumerWidget {
  const AcademicProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(academicSummaryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.academic.academic_progress),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: HorusPageBody(
        child: summary.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => HorusErrorState(
            message: t.academic.error,
            onRetry: () => ref.invalidate(academicSummaryProvider),
          ),
          data: (value) => value.hasPublishedGrades
              ? ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    AppCard(
                      variant: AppCardVariant.academic,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.academic.academic_progress,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                            _ProgressValue(
                              label: t.academic.cumulative_gpa,
                              value: value.gpa?.toStringAsFixed(2) ?? '—',
                            ),
                            _ProgressValue(
                              label: t.academic.credits_1,
                              value: value.recordedCredits.toString(),
                            ),
                            _ProgressValue(
                              label: t.academic.courses,
                              value: value.publishedCourseCount.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : HorusEmptyState(
                  icon: Icons.school_outlined,
                  title: t.academic.no_data,
                ),
        ),
      ),
    );
  }
}

class _ProgressValue extends StatelessWidget {
  const _ProgressValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    ),
  );
}
