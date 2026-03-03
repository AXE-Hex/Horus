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
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:intl/intl.dart';

class DailyScheduleScreen extends HookConsumerWidget {
  const DailyScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final selectedDay = useState(
      DateFormat('EEEE').format(DateTime.now()).toLowerCase(),
    );

    // Timer to update current time every minute
    final currentTime = useState(DateTime.now());
    useEffect(() {
      final timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        currentTime.value = DateTime.now();
      });
      return timer.cancel;
    }, []);

    final days = [
      'all',
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'saturday',
      'sunday',
    ];

    final scheduleAsync = ref.watch(studentScheduleProvider);

    return scheduleAsync.when(
      data: (allSlots) {
        final filteredSlots = allSlots.where((slot) {
          if (selectedDay.value == 'all') return true;
          return (slot['day'] as String).toLowerCase() == selectedDay.value;
        }).toList();

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
                t.schedule.daily_title,
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _buildDayPicker(isArabic, selectedDay, days),
              ),
            ),
            if (filteredSlots.isEmpty)
              SliverFillRemaining(child: _buildEmptyState(context, isArabic))
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final slot = filteredSlots[index];
                    return _ScheduleItem(
                      slot: slot,
                      currentTime: currentTime.value,
                      isArabic: isArabic,
                      index: index,
                    );
                  }, childCount: filteredSlots.length),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        );

        return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildDayPicker(
    bool isArabic,
    ValueNotifier<String> selectedDay,
    List<String> days,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: days.map((day) {
          final isSelected = day == selectedDay.value;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => selectedDay.value = day,
              child: AnimatedContainer(
                duration: 300.ms,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6366F1)
                        : Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF6366F1,
                            ).withValues(alpha: 0.3),
                            blurRadius: 10,
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  isArabic ? _getArabicDay(day) : day.toUpperCase(),
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
        }).toList(),
      ),
    );
  }

  String _getArabicDay(String day) {
    switch (day) {
      case 'all':
        return 'الكل';
      case 'monday':
        return 'الإثنين';
      case 'tuesday':
        return 'الثلاثاء';
      case 'wednesday':
        return 'الأربعاء';
      case 'thursday':
        return 'الخميس';
      case 'saturday':
        return 'السبت';
      case 'sunday':
        return 'الأحد';
      default:
        return day;
    }
  }

  Widget _buildEmptyState(BuildContext context, bool isArabic) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.calendarX, size: 64, color: Colors.white10),
          const SizedBox(height: 20),
          Text(
            t.schedule.no_lectures,
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final Map<String, dynamic> slot;
  final DateTime currentTime;
  final bool isArabic;
  final int index;

  const _ScheduleItem({
    required this.slot,
    required this.currentTime,
    required this.isArabic,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final startTimeStr = slot['startTime'] as String;
    final endTimeStr = slot['endTime'] as String;
    final color = slot['color'] as Color;

    final startParts = startTimeStr.split(':');
    final endParts = endTimeStr.split(':');

    final now = DateTime.now();
    final start = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(startParts[0]),
      int.parse(startParts[1]),
    );
    final end = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(endParts[0]),
      int.parse(endParts[1]),
    );

    final isActive = currentTime.isAfter(start) && currentTime.isBefore(end);
    final isPast = currentTime.isAfter(end);

    double progress = 0.0;
    if (isActive) {
      final totalSeconds = end.difference(start).inSeconds;
      final passedSeconds = currentTime.difference(start).inSeconds;
      progress = (passedSeconds / totalSeconds).clamp(0.0, 1.0);
    }

    return IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    startTimeStr,
                    style: GoogleFonts.shareTechMono(
                      color: isActive
                          ? color
                          : (isPast ? Colors.white24 : Colors.white60),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            isActive || isPast ? color : Colors.white10,
                            isActive
                                ? color.withValues(alpha: 0.1)
                                : (isPast
                                      ? color.withValues(alpha: 0.1)
                                      : Colors.white10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    endTimeStr,
                    style: GoogleFonts.shareTechMono(
                      color: isPast ? Colors.white10 : Colors.white24,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.3),
                                blurRadius: 30,
                                spreadRadius: -5,
                              ),
                              BoxShadow(
                                color: color.withValues(alpha: 0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(24),
                      padding: const EdgeInsets.all(20),
                      border: Border.all(
                        color: isActive
                            ? color.withValues(alpha: 0.8)
                            : Colors.white.withValues(alpha: 0.05),
                        width: isActive ? 1.5 : 1,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTypeBadge(slot['type'] as String, color),
                              if (isActive)
                                _buildLiveIndicator(color)
                              else if (isPast)
                                const Icon(
                                  LucideIcons.checkCircle2,
                                  color: Colors.white10,
                                  size: 16,
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            (isArabic
                                    ? (slot['courses']?['name_ar'] ??
                                          slot['courses']?['name'] ??
                                          slot['subject'] ??
                                          '')
                                    : (slot['courses']?['name'] ??
                                          slot['subject'] ??
                                          ''))
                                as String,
                            style: GoogleFonts.outfit(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: isPast ? Colors.white24 : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                LucideIcons.user,
                                size: 14,
                                color: isPast ? Colors.white10 : color,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                slot['instructor'] as String,
                                style: GoogleFonts.inter(
                                  color: isPast
                                      ? Colors.white10
                                      : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildDetailChip(
                                LucideIcons.mapPin,
                                slot['room'] as String,
                                isPast,
                              ),
                            ],
                          ),
                          if (isActive) ...[
                            const SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.white10,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  color,
                                ),
                                minHeight: 4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${(progress * 100).toInt()}% ${t.academic.completed_1}',
                              style: GoogleFonts.shareTechMono(
                                color: color,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate(delay: (index * 100).ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.1, end: 0);
  }

  Widget _buildTypeBadge(String type, Color color) {
    final isLecture = type == 'type_lecture';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        (isLecture
                ? (t.academic.lecture)
                : (t.academic.section))
            .toUpperCase(),
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildLiveIndicator(Color color) {
    return Row(
      children: [
        Text(
          t.academic.live,
          style: GoogleFonts.outfit(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(width: 6),
        Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            )
            .animate(onPlay: (c) => c.repeat())
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.5, 1.5),
              duration: 800.ms,
            )
            .fadeOut(duration: 800.ms),
      ],
    );
  }

  Widget _buildDetailChip(IconData icon, String label, bool isPast) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: isPast ? Colors.white10 : Colors.white38),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              color: isPast ? Colors.white10 : Colors.white60,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
