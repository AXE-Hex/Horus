part of 'registration_screen.dart';

extension _RegistrationCourseSections on _RegistrationScreenState {
  Widget _buildFunnelSteps(bool isArabic, bool isGlass) {
    if (_currentStep == 0) {
      return _buildCourseSelection(isArabic, isGlass);
    } else if (_currentStep == 1) {
      return _buildScheduleSelection(isArabic, isGlass);
    } else {
      return _buildConfirmationState(isArabic, isGlass);
    }
  }

  Widget _buildCourseSelection(bool isArabic, bool isGlass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.enrollment.select_your_courses,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isGlass
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.enrollment.select_the_subjects_you_want_t,
          style: TextStyle(
            color: isGlass
                ? Colors.white70
                : Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        const SizedBox(height: 24),
        ..._semesterCourses.map((course) {
          final isSelected = _selectedCourses.any((c) => c.id == course.id);
          final isLocked = _lockedCourses[course.id] == true;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildCourseSelectionCard(
              course: course,
              isSelected: isSelected,
              isLocked: isLocked,
              isArabic: isArabic,
              isGlass: isGlass,
              onTap: () => _toggleCourse(course),
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0);
        }),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _selectedCourses.isEmpty ? null : _proceedToSchedules,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            t.enrollment.next_pick_schedules,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseSelectionCard({
    required Course course,
    required bool isSelected,
    required bool isLocked,
    required bool isArabic,
    required bool isGlass,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isLocked ? null : onTap,
      borderRadius: BorderRadius.circular(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? (isGlass ? Colors.white : Theme.of(context).colorScheme.primary)
              : (isLocked
                    ? Colors.redAccent.withValues(alpha: 0.2)
                    : Colors.white10),
          width: isSelected ? 2 : 1,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isGlass
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary)
                    : (isLocked
                          ? Colors.redAccent.withValues(alpha: 0.1)
                          : Colors.white10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isLocked
                    ? LucideIcons.lock
                    : (isSelected ? LucideIcons.check : LucideIcons.book),
                color: isSelected
                    ? (isGlass
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white)
                    : (isLocked ? Colors.redAccent : Colors.white60),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? (course.nameAr ?? course.name) : course.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isLocked ? Colors.white24 : Colors.white,
                    ),
                  ),
                  Text(
                    course.code,
                    style: TextStyle(
                      fontSize: 12,
                      color: isLocked ? Colors.white10 : Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            if (!isLocked)
              Text(
                "${course.credits} ${t.enrollment.cr}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.white38,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
