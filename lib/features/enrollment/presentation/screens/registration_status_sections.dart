part of 'registration_screen.dart';

extension _RegistrationStatusSections on _RegistrationScreenState {
  Widget _buildStepper(bool isGlass) {
    return Row(
      children: [
        _buildStepIndicator(0, LucideIcons.book, isGlass),
        _buildStepLine(0, isGlass),
        _buildStepIndicator(1, LucideIcons.calendar, isGlass),
        _buildStepLine(1, isGlass),
        _buildStepIndicator(2, LucideIcons.clipboardCheck, isGlass),
      ],
    );
  }

  Widget _buildStepIndicator(int step, IconData icon, bool isGlass) {
    final isActive = _currentStep >= step;
    final isCurrent = _currentStep == step;

    return AnimatedContainer(
          duration: 400.ms,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isCurrent
                ? (isGlass
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary)
                : (isActive
                      ? (isGlass
                            ? Colors.white54
                            : Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.6))
                      : (isGlass
                            ? Colors.white12
                            : Colors.grey.withValues(alpha: 0.1))),
            shape: BoxShape.circle,
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color:
                          (isGlass
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary)
                              .withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 18,
            color: isCurrent
                ? (isGlass
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white)
                : (isActive
                      ? Colors.white
                      : (isGlass ? Colors.white24 : Colors.grey)),
          ),
        )
        .animate(target: isCurrent ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2));
  }

  Widget _buildStepLine(int step, bool isGlass) {
    final isActive = _currentStep > step;
    return Expanded(
      child: AnimatedContainer(
        duration: 400.ms,
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: isActive
            ? (isGlass ? Colors.white : Theme.of(context).colorScheme.primary)
            : (isGlass ? Colors.white10 : Colors.grey.withValues(alpha: 0.2)),
      ),
    );
  }

  Widget _buildRequestStatusCard(
    RegistrationRequest request,
    bool isArabic,
    bool isGlass,
  ) {
    final Color statusColor;
    final IconData statusIcon;
    final String statusLabel;

    switch (request.status) {
      case RegistrationStatus.pending:
        statusColor = Colors.amber;
        statusIcon = LucideIcons.clock;
        statusLabel = t.enrollment.awaiting_advisor_review;
        break;
      case RegistrationStatus.approved:
        statusColor = Colors.greenAccent;
        statusIcon = LucideIcons.checkCircle;
        statusLabel = t.enrollment.approved;
        break;
      case RegistrationStatus.rejected:
        statusColor = Colors.redAccent;
        statusIcon = LucideIcons.xCircle;
        statusLabel = t.enrollment.rejected;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = LucideIcons.info;
        statusLabel = request.status.label(isArabic: isArabic);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(statusIcon, color: statusColor, size: 56),
                const SizedBox(height: 16),
                Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (request.advisor != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    t.enrollment.advisor_name_label(
                      name: request.advisor?.fullName ?? '',
                    ),
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (request.advisorNotes != null &&
                    request.advisorNotes!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      '"${request.advisorNotes}"',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  t.enrollment.semester_label_with_value(
                    semester: request.semester,
                  ),
                  style: TextStyle(fontSize: 12, color: Colors.white38),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
        const SizedBox(height: 16),

        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.enrollment.requested_courses,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...request.courses.map((rc) {
                  final course = rc.course;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            LucideIcons.bookOpen,
                            color: statusColor,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course != null
                                    ? (isArabic
                                          ? (course.nameAr ?? course.name)
                                          : course.name)
                                    : rc.courseId,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (rc.sectionName != null)
                                Text(
                                  '${rc.sectionName}${rc.subSectionName != null ? ' / ${rc.subSectionName}' : ''}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white54,
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
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
        if (request.isRejected) ...[
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              _updateState(() {
                _existingRequest = null;
                _currentStep = 0;
                _selectedCourses.clear();
                _selectedSections.clear();
              });
            },
            icon: const Icon(LucideIcons.refreshCw),
            label: Text(t.enrollment.reregister),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ).animate().fadeIn(duration: 600.ms),
        ],
      ],
    );
  }
}
