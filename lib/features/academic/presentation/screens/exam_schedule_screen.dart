import 'dart:async';

import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/academic/presentation/providers/semester_provider.dart';
import 'package:intl/intl.dart';

part 'exam_date_scroller.dart';
part 'exam_countdown.dart';
part 'exam_card.dart';

final examScheduleProvider =
    FutureProvider.family<List<ExamScheduleRecord>, String>((
      ref,
      semester,
    ) async {
      return await ref
          .read(academicRepositoryProvider)
          .getExamSchedule(semester: semester);
    });

class ExamScheduleScreen extends HookConsumerWidget {
  const ExamScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final isGlass = ref.watch(styleControllerProvider).value == AppStyle.glass;
    final selectedDate = useState<DateTime?>(null);
    final semesterAsync = ref.watch(currentSemesterProvider);

    return semesterAsync.when(
      data: (semester) {
        if (semester == null) {
          return Scaffold(body: Center(child: Text(t.academic.no_data)));
        }
        final examsAsync = ref.watch(examScheduleProvider(semester.code));

        return examsAsync.when(
          data: (rawData) {
            final exams = rawData.map((e) {
              final id = e.courseCode ?? e.courseId;
              Color color = const Color(0xFF6366F1);
              IconData icon = LucideIcons.book;

              if (id.startsWith('CS')) {
                color = const Color(0xFF10B981);
                icon = LucideIcons.cpu;
              } else if (id.startsWith('HU')) {
                color = const Color(0xFFF59E0B);
                icon = LucideIcons.shieldCheck;
              } else if (id.startsWith('MA')) {
                color = const Color(0xFFEC4899);
                icon = LucideIcons.functionSquare;
              }

              return {
                'id': id,
                'subject': e.courseName ?? t.academic.artificial_intelligence,
                'dateTime': e.examDate,
                'seat': 'TBD',
                'room': e.room ?? 'TBD',
                'color': color,
                'icon': icon,
              };
            }).toList();

            final filteredExams = exams.where((exam) {
              if (selectedDate.value == null) return true;
              final examDate = exam['dateTime'] as DateTime;
              return examDate.year == selectedDate.value!.year &&
                  examDate.month == selectedDate.value!.month &&
                  examDate.day == selectedDate.value!.day;
            }).toList();

            final examDates = exams
                .map((e) => e['dateTime'] as DateTime)
                .map((d) => DateTime(d.year, d.month, d.day))
                .toSet()
                .toList();
            examDates.sort();

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
                    icon: const Icon(
                      LucideIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  title: Text(
                    t.academic.exam_schedule,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: exams.isEmpty
                        ? const SizedBox.shrink()
                        : _ExamCountdown(
                            nextExam: exams.first['dateTime'] as DateTime,
                            isArabic: isArabic,
                          ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _DateScroller(
                      dates: examDates,
                      selectedDate: selectedDate.value,
                      onDateSelected: (date) => selectedDate.value = date,
                      isArabic: isArabic,
                    ),
                  ),
                ),
                if (filteredExams.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LucideIcons.calendarX,
                            size: 64,
                            color: Colors.white10,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            t.academic.no_exams_on_this_day,
                            style: GoogleFonts.outfit(
                              color: Colors.white38,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final exam = filteredExams[index];
                        return _ExamCard(
                          exam: exam,
                          isArabic: isArabic,
                          index: index,
                        );
                      }, childCount: filteredExams.length),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );

            return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) =>
              Center(child: Text('Error loading exams: $err')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
          Center(child: Text('Error loading semester: $err')),
    );
  }
}
