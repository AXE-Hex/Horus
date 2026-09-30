import 'package:horus/shared/widgets/app_card.dart';
import 'package:horus/shared/widgets/horus_error_state.dart';
import 'package:horus/shared/layout/horus_page_body.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/academic/presentation/providers/student_grades_provider.dart';

class SubjectResultsScreen extends ConsumerWidget {
  const SubjectResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grades = ref.watch(studentGradesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.academic.academic_results),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: HorusPageBody(
        child: grades.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => HorusErrorState(
            message: t.academic.error,
            onRetry: () => ref.invalidate(studentGradesProvider),
          ),
          data: (records) => records.isEmpty
              ? HorusEmptyState(
                  icon: Icons.school_outlined,
                  title: t.academic.no_data,
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: records.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final grade = records[index];
                    return AppCard(
                      variant: AppCardVariant.academic,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    (t.$meta.locale.languageCode == 'ar'
                                            ? grade.course?.nameAr
                                            : grade.course?.nameEn) ??
                                        grade.course?.code ??
                                        grade.courseId,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ),
                                Text(
                                  grade.gradeLetter ?? '—',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _ScoreLine(
                              label: t.academic.coursework,
                              score: grade.coursework,
                            ),
                            _ScoreLine(
                              label: t.academic.midterm_exam,
                              score: grade.midterm,
                            ),
                            _ScoreLine(
                              label: t.academic.practical_project,
                              score: grade.practical,
                            ),
                            _ScoreLine(
                              label: t.academic.final_exam,
                              score: grade.finalExam,
                            ),
                            const Divider(),
                            _ScoreLine(
                              label: t.academic.score,
                              score: grade.total,
                              emphasize: true,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _ScoreLine extends StatelessWidget {
  const _ScoreLine({
    required this.label,
    required this.score,
    this.emphasize = false,
  });

  final String label;
  final double? score;
  final bool emphasize;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          score?.toStringAsTrimmed() ?? '—',
          style: emphasize ? Theme.of(context).textTheme.titleMedium : null,
        ),
      ],
    ),
  );
}

extension on double {
  String toStringAsTrimmed() => truncateToDouble() == this
      ? toInt().toString()
      : toStringAsFixed(
          2,
        ).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
}
