part of 'registration_screen.dart';

extension _RegistrationConfirmationSections on _RegistrationScreenState {
  Widget _buildConfirmationState(bool isArabic, bool isGlass) {
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
              onPressed: () => _updateState(() => _currentStep = 1),
            ),
            Expanded(
              child: Text(
                t.enrollment.review_registration,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        GlassContainer(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              Text(
                t.enrollment.selected_schedule_summary,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isGlass
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              ..._selectedCourses.map((course) {
                final sec = _selectedSections[course.id]!;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic
                                  ? (course.nameAr ?? course.name)
                                  : course.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isGlass ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              "${sec.day.name} at ${sec.startTime.substring(0, 5)} | Room: ${sec.room ?? '-'}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isGlass
                                    ? Colors.white60
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _isRegistering ? null : _confirmRegistration,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: _isRegistering
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                )
              : Text(
                  t.enrollment.confirm_submit,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
        ),
      ],
    );
  }

  Widget _buildSuccessState(bool isArabic, bool isGlass) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(
              3,
              (i) =>
                  Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: (isGlass ? Colors.greenAccent : Colors.green)
                                .withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                      )
                      .animate()
                      .scale(
                        duration: (1000 + i * 500).ms,
                        begin: const Offset(1, 1),
                        end: const Offset(2, 2),
                      )
                      .fadeOut(duration: (1000 + i * 500).ms),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: (isGlass ? Colors.greenAccent : Colors.green).withValues(
                  alpha: 0.1,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: (isGlass ? Colors.greenAccent : Colors.green)
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Icon(
                LucideIcons.partyPopper,
                size: 80,
                color: isGlass ? Colors.greenAccent : Colors.green,
              ),
            ).animate().scale(duration: 800.ms, curve: Curves.bounceOut),
          ],
        ),
        const SizedBox(height: 48),
        Text(
          t.registration.already_registered_title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: isGlass ? Colors.white : Colors.black87,
            letterSpacing: -1,
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 16),
        GlassContainer(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(24),
          child: Text(
            t.enrollment.registration_success_message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isGlass ? Colors.white70 : Colors.black54,
              fontSize: 15,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.9, 0.9)),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () => context.pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: isGlass
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
            foregroundColor: isGlass
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor:
                (isGlass ? Colors.white : Theme.of(context).colorScheme.primary)
                    .withValues(alpha: 0.3),
          ),
          child: Text(
            t.registration.back_home,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }
}
