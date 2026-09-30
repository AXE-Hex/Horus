import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/features/academic/presentation/providers/student_attendance_provider.dart';
import 'package:horus/shared/widgets/horus_error_state.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});
  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final records = ref.watch(studentAttendanceProvider(_page));
    return Scaffold(
      appBar: AppBar(
        title: Text(t.attendance.title),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: _page > 0 && !records.isLoading
                    ? () => setState(() => _page--)
                    : null,
                child: Text(t.extracted.previous),
              ),
              OutlinedButton(
                onPressed:
                    records.value?.length == attendancePageSize &&
                        !records.isLoading
                    ? () => setState(() => _page++)
                    : null,
                child: Text(t.extracted.next),
              ),
            ],
          ),
        ),
      ),
      body: records.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => HorusErrorState(
          message: t.academic.error,
          onRetry: () => ref.invalidate(studentAttendanceProvider(_page)),
        ),
        data: (attendance) => attendance.isEmpty
            ? HorusEmptyState(
                icon: Icons.event_available_outlined,
                title: t.academic.no_data,
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: attendance.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = attendance[index];
                  final status = switch (item.status) {
                    AttendanceStatus.present => t.attendance.present,
                    AttendanceStatus.absent => t.attendance.absent,
                    AttendanceStatus.late => t.attendance.late,
                    AttendanceStatus.excused => t.attendance.excused,
                    AttendanceStatus.unknown => t.attendance.unknown,
                  };
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.event_available_outlined),
                      title: Text(
                        (t.$meta.locale.languageCode == 'ar'
                                ? item.course?.nameAr
                                : item.course?.nameEn) ??
                            item.course?.code ??
                            item.courseId,
                      ),
                      subtitle: Text(
                        MaterialLocalizations.of(
                          context,
                        ).formatMediumDate(item.date),
                      ),
                      trailing: Text(status),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
