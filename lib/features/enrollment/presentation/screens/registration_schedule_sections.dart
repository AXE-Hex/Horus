part of 'registration_screen.dart';

extension _RegistrationScheduleSections on _RegistrationScreenState {
  Widget _buildScheduleSelection(bool isArabic, bool isGlass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                LucideIcons.arrowLeft,
                color: isGlass ? Colors.white : Colors.black,
              ),
              onPressed: () => _updateState(() => _currentStep = 0),
            ),
            Expanded(
              child: Text(
                t.enrollment.choose_schedules,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._selectedCourses.map((course) {
          final schedules = _courseSchedulesCache[course.id] ?? [];
          final selectedSec = _selectedSections[course.id];

          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Text(
                    isArabic ? (course.nameAr ?? course.name) : course.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isGlass ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                if (schedules.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      t.enrollment.no_schedules_available,
                      style: TextStyle(
                        color: isGlass ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  )
                else
                  ...schedules.map((schedule) {
                    final isSelected = selectedSec?.id == schedule.id;
                    return _buildScheduleItemCard(
                      schedule: schedule,
                      isSelected: isSelected,
                      isArabic: isArabic,
                      isGlass: isGlass,
                      onTap: () {
                        _updateState(() {
                          _selectedSections[course.id] = schedule;
                        });
                      },
                    );
                  }),
              ],
            ),
          );
        }),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _selectedSections.length < _selectedCourses.length
              ? null
              : () => _updateState(() => _currentStep = 2),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            t.enrollment.review_final_timetable,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItemCard({
    required ScheduleOption schedule,
    required bool isSelected,
    required bool isArabic,
    required bool isGlass,
    required VoidCallback onTap,
  }) {
    final day = schedule.day.name;
    final startTime = schedule.startTime;
    final section = schedule.sectionName ?? 'General';
    final subSection = schedule.subSectionName ?? '-';
    final room = schedule.room ?? '-';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? (isGlass
                      ? Colors.white10
                      : Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.1))
                : (isGlass ? Colors.transparent : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? (isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary)
                  : (isGlass
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black12),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    day.substring(0, 3).toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: isSelected
                          ? (isGlass
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary)
                          : (isGlass ? Colors.white38 : Colors.black38),
                    ),
                  ),
                  Text(
                    startTime.substring(0, 5),
                    style: TextStyle(
                      color: isSelected
                          ? (isGlass ? Colors.white70 : Colors.black54)
                          : (isGlass ? Colors.white38 : Colors.black26),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${t.enrollment.sec}: $section",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isGlass ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      "${t.enrollment.room}: $room | ${t.enrollment.sub}: $subSection",
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? (isGlass ? Colors.white70 : Colors.black54)
                            : (isGlass ? Colors.white38 : Colors.black26),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  LucideIcons.check,
                  color: Colors.greenAccent,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
