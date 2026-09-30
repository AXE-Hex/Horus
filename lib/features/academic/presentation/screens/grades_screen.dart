import 'package:horus/shared/widgets/app_card.dart';
import 'package:horus/shared/widgets/horus_error_state.dart';
import 'package:horus/shared/layout/horus_page_body.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/academic/presentation/providers/student_grades_provider.dart';

class GradesScreen extends ConsumerWidget {
  const GradesScreen({super.key});

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
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final grade = records[index];
                    return AppCard(
                      variant: AppCardVariant.academic,
                      child: ListTile(
                        leading: const Icon(Icons.school_outlined),
                        title: Text(
                          (t.$meta.locale.languageCode == 'ar'
                                  ? grade.course?.nameAr
                                  : grade.course?.nameEn) ??
                              grade.course?.code ??
                              grade.courseId,
                        ),
                        subtitle: Text(
                          '${grade.course?.code ?? grade.courseId} · ${grade.semester} · ${grade.course?.creditHours ?? '—'} ${t.academic.credits_1}',
                        ),
                        trailing: Text(
                          grade.gradeLetter ?? '—',
                          style: Theme.of(context).textTheme.titleLarge,
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
