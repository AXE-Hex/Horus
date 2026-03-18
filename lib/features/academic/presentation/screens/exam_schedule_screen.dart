import 'dart:async';
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hue/core/data/supabase_providers.dart';
import 'package:intl/intl.dart';

final examScheduleProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((
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
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final selectedDate = useState<DateTime?>(null);
    final examsAsync = ref.watch(examScheduleProvider('Fall 2024'));

    return examsAsync.when(
      data: (rawData) {
        final exams = rawData.map((e) {
          final id = e['course_id'] as String? ?? 'N/A';
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
            'subject':
                e['subject'] as String? ?? t.academic.artificial_intelligence,
            'dateTime':
                DateTime.tryParse(e['exam_date']?.toString() ?? '') ??
                DateTime.now(),
            'seat': e['seat'] as String? ?? 'TBD',
            'room': e['room'] as String? ?? 'TBD',
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
                icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
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
      error: (err, stack) => Center(child: Text('Error loading exams: $err')),
    );
  }
}

class _DateScroller extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime? selectedDate;
  final Function(DateTime?) onDateSelected;
  final bool isArabic;

  const _DateScroller({
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildDateItem(null, t.academic.all, selectedDate == null),
          ...dates.map((date) {
            final isSelected =
                selectedDate != null &&
                date.year == selectedDate!.year &&
                date.month == selectedDate!.month &&
                date.day == selectedDate!.day;
            final dayName = DateFormat('EEE').format(date);
            final dayNum = date.day.toString();
            return _buildDateItem(date, '$dayName $dayNum', isSelected);
          }),
        ],
      ),
    );
  }

  Widget _buildDateItem(DateTime? date, String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () => onDateSelected(date),
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6366F1)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6366F1)
                  : Colors.white.withValues(alpha: 0.1),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.outfit(
              color: isSelected ? Colors.white : Colors.white60,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _ExamCountdown extends HookWidget {
  final DateTime nextExam;
  final bool isArabic;

  const _ExamCountdown({required this.nextExam, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final timeLeft = useState(nextExam.difference(DateTime.now()));

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeLeft.value = nextExam.difference(DateTime.now());
      });
      return timer.cancel;
    }, [nextExam]);

    final days = timeLeft.value.inDays;
    final hours = timeLeft.value.inHours % 24;
    final minutes = timeLeft.value.inMinutes % 60;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            t.academic.next_exam_in,
            style: GoogleFonts.outfit(
              color: const Color(0xFF6366F1),
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeUnit(days.toString().padLeft(2, '0'), t.academic.days),
              _buildDivider(),
              _buildTimeUnit(
                hours.toString().padLeft(2, '0'),
                t.academic.hours,
              ),
              _buildDivider(),
              _buildTimeUnit(
                minutes.toString().padLeft(2, '0'),
                t.academic.mins,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        ':',
        style: GoogleFonts.shareTechMono(
          fontSize: 36,
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final Map<String, dynamic> exam;
  final bool isArabic;
  final int index;

  const _ExamCard({
    required this.exam,
    required this.isArabic,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = exam['color'] as Color;
    final dateTime = exam['dateTime'] as DateTime;
    final date = DateFormat(t.academic.d_mmmm).format(dateTime);
    final time = DateFormat('hh:mm a').format(dateTime);

    return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(28),
              padding: const EdgeInsets.all(24),
              border: Border.all(
                color: color.withValues(alpha: 0.2),
                width: index == 0 ? 1.5 : 1,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: color.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Icon(
                          exam['icon'] as IconData,
                          color: color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exam['subject'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  exam['id'] as String,
                                  style: GoogleFonts.shareTechMono(
                                    fontSize: 13,
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  exam['room'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 13,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _buildSeatBadge(exam['seat'] as String),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildInfoItem(LucideIcons.calendar, date),
                      const SizedBox(width: 24),
                      _buildInfoItem(LucideIcons.clock, time),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSecondaryButton(
                          LucideIcons.calendarPlus,
                          t.academic.add_to_calendar,
                          () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildIconButton(LucideIcons.mapPin, () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        .animate(delay: (index * 150).ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.2, end: 0);
  }

  Widget _buildSeatBadge(String seat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.hash, size: 12, color: Colors.red),
          const SizedBox(width: 6),
          Text(
            seat,
            style: GoogleFonts.shareTechMono(
              color: Colors.red,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white24),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.shareTechMono(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryButton(
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: Colors.white70),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Icon(icon, size: 16, color: Colors.white70),
      ),
    );
  }
}
