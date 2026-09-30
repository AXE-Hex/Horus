import 'package:horus/shared/widgets/app_card.dart';
import 'package:horus/shared/widgets/horus_error_state.dart';
import 'package:horus/shared/layout/horus_page_body.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/academic/presentation/providers/student_grades_provider.dart';

class TranscriptScreen extends ConsumerWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grades = ref.watch(studentGradesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.academic.academic_journey),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: HorusPageBody(
        child: grades.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => HorusErrorState(
            message: t.academic.error,
            onRetry: () => ref.invalidate(studentGradesProvider),
          ),
          data: (records) {
            if (records.isEmpty) {
              return HorusEmptyState(
                icon: Icons.school_outlined,
                title: t.academic.no_data,
              );
            }
            final bySemester = <String, List<GradeRecord>>{};
            for (final record in records) {
              bySemester.putIfAbsent(record.semester, () => []).add(record);
            }
            final semesters = bySemester.keys.toList()
              ..sort((a, b) => b.compareTo(a));
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: semesters.length,
              itemBuilder: (context, index) {
                final semester = semesters[index];
                final semesterGrades = bySemester[semester]!;
                return AppCard(
                  variant: AppCardVariant.academic,
                  margin: const EdgeInsets.only(bottom: 14),
                  child: ExpansionTile(
                    title: Text(semester),
                    subtitle: Text(
                      '${semesterGrades.length} ${t.academic.courses}',
                    ),
                    children: [
                      for (final grade in semesterGrades)
                        ListTile(
                          title: Text(
                            (t.$meta.locale.languageCode == 'ar'
                                    ? grade.course?.nameAr
                                    : grade.course?.nameEn) ??
                                grade.course?.code ??
                                grade.courseId,
                          ),
                          subtitle: Text(
                            '${grade.course?.code ?? grade.courseId} · ${grade.course?.creditHours ?? '—'} ${t.academic.credits_1}',
                          ),
                          trailing: Text(grade.gradeLetter ?? '—'),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
