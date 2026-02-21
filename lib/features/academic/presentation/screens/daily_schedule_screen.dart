// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/i18n/strings.g.dart';
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

class DailyScheduleScreen extends HookConsumerWidget {
  const DailyScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final selectedDay = useState('monday');
    final selectedPeriod = useState('all_periods');

    final days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];

    final periods = ['all_periods', 'morning', 'afternoon', 'evening'];

    final allSlots = [
      {
        'day': 'monday',
        'time': '09:00 - 10:30',
        'period': 'morning',
        'subject': 'Artificial Intelligence',
        'room': 'Hall 4',
        'room_number': '4',
        'room_code': 'H4',
        'floor': '1st',
        'direction': 'east',
        'type': 'type_lecture',
        'instructor': 'Dr. Ahmed Ali',
        'status': 'status_started',
      },
      {
        'day': 'monday',
        'time': '10:45 - 12:15',
        'period': 'morning',
        'subject': 'Machine Learning',
        'room': 'Lab 12',
        'room_number': '12',
        'room_code': 'L12',
        'floor': '2nd',
        'direction': 'west',
        'type': 'type_section',
        'instructor': 'Eng. Sara Kamal',
        'status': 'status_active',
      },
      {
        'day': 'monday',
        'time': '01:00 - 02:30',
        'period': 'afternoon',
        'subject': 'Ethics in IT',
        'room': 'Room 105',
        'room_number': '105',
        'room_code': 'R105',
        'floor': '1st',
        'direction': 'south',
        'type': 'type_lecture',
        'instructor': 'Dr. Mohamed Hassan',
        'status': 'status_online',
      },
      {
        'day': 'tuesday',
        'time': '09:00 - 10:30',
        'period': 'morning',
        'subject': 'Data Structures',
        'room': 'Hall 2',
        'room_number': '2',
        'room_code': 'H2',
        'floor': 'Ground',
        'direction': 'east',
        'type': 'type_lecture',
        'instructor': 'Dr. Leila Mahmoud',
        'status': 'status_active',
      },
      {
        'day': 'tuesday',
        'time': '11:00 - 12:30',
        'period': 'morning',
        'subject': 'Software Engineering',
        'room': 'Hall 5',
        'room_number': '5',
        'room_code': 'H5',
        'floor': '2nd',
        'direction': 'north',
        'type': 'type_lecture',
        'instructor': 'Dr. Omar Khaled',
        'status': 'status_cancelled',
      },
      {
        'day': 'tuesday',
        'time': '02:00 - 03:30',
        'period': 'afternoon',
        'subject': 'Operating Systems',
        'room': 'Lab 4',
        'room_number': '4',
        'room_code': 'L4',
        'floor': '1st',
        'direction': 'west',
        'type': 'type_section',
        'instructor': 'Eng. Ahmed Zaki',
        'status': 'status_substitute',
        'substitute': 'Dr. Yasmine Ali',
      },
    ];

    final filteredSlots = allSlots.where((slot) {
      final dayMatch = slot['day'] == selectedDay.value;
      final periodMatch =
          selectedPeriod.value == 'all_periods' ||
          slot['period'] == selectedPeriod.value;
      return dayMatch && periodMatch;
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
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: Text(
            isArabic ? 'الجدول اليومي' : 'Daily Schedule',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),

        // Day Filter
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: days.map((day) {
                final isSelected = day == selectedDay.value;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      isArabic ? t['schedule.$day'] : t['schedule.$day'],
                    ), // TODO: Ensure correct Arabic text map for days or replace inline
                    selected: isSelected,
                    onSelected: (val) {
                      if (val) selectedDay.value = day;
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    labelStyle: GoogleFonts.outfit(
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        // Period Filter
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: periods.map((period) {
                final isSelected = period == selectedPeriod.value;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      isArabic ? t['schedule.$period'] : t['schedule.$period'],
                    ),
                    selected: isSelected,
                    onSelected: (val) {
                      selectedPeriod.value = period;
                    },
                    selectedColor: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.2),
                    checkmarkColor: Theme.of(context).primaryColor,
                    labelStyle: GoogleFonts.outfit(
                      fontSize: 12,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).hintColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        filteredSlots.isEmpty
            ? SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.calendarX,
                        size: 48,
                        color: Theme.of(
                          context,
                        ).hintColor.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isArabic
                            ? "لا توجد محاضرات في هذا اليوم"
                            : "No lectures today",
                        style: GoogleFonts.outfit(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildTimeSlotCard(
                            context,
                            filteredSlots[index],
                            isGlass,
                            isArabic,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: (index * 50).ms)
                        .slideY(begin: 0.1, end: 0);
                  }, childCount: filteredSlots.length),
                ),
              ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildTimeSlotCard(
    BuildContext context,
    Map<String, String> slot,
    bool isGlass,
    bool isArabic,
  ) {
    final status = slot['status']!;
    final type = slot['type']!;

    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'status_started':
        statusColor = Colors.green;
        statusIcon = LucideIcons.playCircle;
        break;
      case 'status_cancelled':
        statusColor = Colors.red;
        statusIcon = LucideIcons.xCircle;
        break;
      case 'status_online':
        statusColor = Colors.purple;
        statusIcon = LucideIcons.globe;
        break;
      case 'status_substitute':
        statusColor = Colors.orange;
        statusIcon = LucideIcons.userPlus;
        break;
      default:
        statusColor = Colors.blue;
        statusIcon = LucideIcons.clock;
    }

    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Column
          Column(
            children: [
              Text(
                slot['time']!.split(' - ')[0],
                style: GoogleFonts.shareTechMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isGlass
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
              ),
              Container(
                width: 2,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      statusColor.withValues(alpha: 0.5),
                      statusColor.withValues(alpha: 0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Text(
                slot['time']!.split(' - ')[1],
                style: GoogleFonts.shareTechMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type and Status Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: type == 'type_lecture'
                            ? Colors.blue.withValues(alpha: 0.1)
                            : Colors.teal.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isArabic ? t['schedule.$type'] : t['schedule.$type'],
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: type == 'type_lecture'
                              ? Colors.blue
                              : Colors.teal,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(statusIcon, size: 12, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          isArabic
                              ? t['schedule.$status']
                              : t['schedule.$status'],
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                        if (status == 'status_started')
                          const SizedBox(width: 4),
                        if (status == 'status_started')
                          Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .fadeIn(duration: 500.ms)
                              .fadeOut(delay: 500.ms),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Subject Name
                Text(
                  slot['subject']!,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 8),

                // Instructor Info
                Row(
                  children: [
                    Icon(
                      LucideIcons.user,
                      size: 14,
                      color: isGlass ? Colors.white60 : Colors.black54,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      slot['instructor']!,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: isGlass ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Location Info
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    _buildRoomDetail(
                      context,
                      LucideIcons.mapPin,
                      slot['room']!,
                      isGlass,
                    ),
                    if (slot.containsKey('room_code'))
                      _buildRoomDetail(
                        context,
                        LucideIcons.tag,
                        slot['room_code']!,
                        isGlass,
                      ),
                    if (slot.containsKey('floor'))
                      _buildRoomDetail(
                        context,
                        LucideIcons.layers,
                        '${isArabic ? 'الطابق' : 'Floor'}: ${slot['floor']}',
                        isGlass,
                      ),
                    if (slot.containsKey('direction'))
                      _buildRoomDetail(
                        context,
                        LucideIcons.compass,
                        isArabic
                            ? t['schedule.${slot['direction']}']
                            : t['schedule.${slot['direction']}'],
                        isGlass,
                      ),
                  ],
                ),

                // Substitute Doctor Info
                if (status == 'status_substitute' &&
                    slot.containsKey('substitute'))
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            LucideIcons.info,
                            size: 14,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${isArabic ? 'بديل' : 'Substitute'}: ${slot['substitute']}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: Colors.orange[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(24),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: content,
          );
  }

  Widget _buildRoomDetail(
    BuildContext context,
    IconData icon,
    String label,
    bool isGlass,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: isGlass
              ? Colors.white.withValues(alpha: 0.5)
              : Theme.of(context).hintColor,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isGlass
                ? Colors.white.withValues(alpha: 0.7)
                : Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }
}
