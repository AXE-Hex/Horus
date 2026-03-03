import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hue/features/enrollment/data/repositories/registration_repository.dart';
import 'package:hue/features/enrollment/data/repositories/advisor_repository.dart';
import 'package:hue/features/enrollment/data/models/registration_models.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final String currentSemester = "Spring 2024";

  int _currentStep = 0;
  final List<Course> _selectedCourses = [];
  final Map<String, Map<String, dynamic>> _selectedSections =
      {}; // courseId -> {section, subSection}

  bool _isLoading = true;
  bool _isRegistering = false;
  String? _error;

  List<Course> _semesterCourses = [];
  Map<String, bool> _lockedCourses = {};

  // Cache for sections per course to avoid redundant fetches
  final Map<String, List<Map<String, dynamic>>> _courseSchedulesCache = {};

  bool _alreadyRegistered = false;
  RegistrationRequest? _existingRequest; // pending or approved request

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final repo = ref.read(registrationRepositoryProvider);
      final advisorRepo = ref.read(advisorRepositoryProvider);
      final auth = ref.read(authControllerProvider);
      final studentId = auth.user?.id;

      if (studentId == null) throw Exception("User not logged in");

      // 1. Check for an existing registration request (pending/approved/rejected)
      final request = await advisorRepo.getMyRegistrationRequest(
        currentSemester,
      );
      if (request != null) {
        setState(() {
          _existingRequest = request;
          _alreadyRegistered = request.isApproved;
          _isLoading = false;
        });
        return;
      }

      // 2. Check for already registered courses (direct, legacy)
      final regs = await repo.getStudentCourseRegistrations(
        studentId,
        currentSemester,
      );
      if (regs.isNotEmpty) {
        setState(() {
          _alreadyRegistered = true;
          _isLoading = false;
        });
        return;
      }

      // 3. Fetch available courses for the semester
      _semesterCourses = await repo.fetchCoursesBySemester(currentSemester);
      _lockedCourses = await repo.checkPrerequisites(
        studentId,
        _semesterCourses,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _toggleCourse(Course course) {
    if (_lockedCourses[course.id] == true) return;

    setState(() {
      if (_selectedCourses.any((c) => c.id == course.id)) {
        _selectedCourses.removeWhere((c) => c.id == course.id);
        _selectedSections.remove(course.id);
      } else {
        _selectedCourses.add(course);
      }
    });
  }

  Future<void> _proceedToSchedules() async {
    if (_selectedCourses.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final repo = ref.read(registrationRepositoryProvider);
      for (final course in _selectedCourses) {
        if (!_courseSchedulesCache.containsKey(course.id)) {
          final schedules = await repo.fetchSectionsByCourse(
            course.id,
            currentSemester,
          );
          _courseSchedulesCache[course.id] = schedules;
        }
      }
      setState(() => _currentStep = 1);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmRegistration() async {
    // Validate that all selected courses have a section picked
    for (final course in _selectedCourses) {
      if (!_selectedSections.containsKey(course.id)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please select a schedule for ${course.name}"),
          ),
        );
        return;
      }
    }

    setState(() {
      _isRegistering = true;
      _error = null;
    });
    try {
      final advisorRepo = ref.read(advisorRepositoryProvider);

      final courses = _selectedCourses.map((c) {
        final sec = _selectedSections[c.id]!;
        return {
          'course_id': c.id,
          'section_name': sec['section_name'],
          'sub_section_name': sec['sub_section_name'],
        };
      }).toList();

      // Submit for advisor approval (not direct DB write)
      final request = await advisorRepo.submitRegistrationRequest(
        semester: currentSemester,
        courses: courses,
      );

      setState(() {
        _existingRequest = request;
        _isRegistering = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green.shade800,
            content: const Text(
              'تم إرسال طلب التسجيل للمشرف بنجاح ✅',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isRegistering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    Widget body;

    if (_isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      body = Center(
        child: Text(
          t.registration.error_loading(error: _error!),
          textAlign: TextAlign.center,
        ),
      );
    } else if (_existingRequest != null) {
      // Show request status (pending / approved / rejected)
      body = _buildRequestStatusCard(_existingRequest!, isArabic, isGlass);
    } else if (_alreadyRegistered) {
      body = _buildSuccessState(isArabic, isGlass);
    } else {
      body = _buildFunnelSteps(isArabic, isGlass);
    }

    final scaffoldBody = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 100,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: Text(
            t.registration.title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: isGlass
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
          centerTitle: true,
        ),
        if (!_alreadyRegistered && _error == null && !_isLoading)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _buildStepper(isGlass),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverToBoxAdapter(child: body),
        ),
      ],
    );

    return isGlass
        ? GlassScaffold(body: scaffoldBody)
        : Scaffold(body: scaffoldBody);
  }

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
          style: GoogleFonts.outfit(
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
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
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
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isLocked ? Colors.white24 : Colors.white,
                    ),
                  ),
                  Text(
                    course.code,
                    style: GoogleFonts.shareTechMono(
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
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.white38,
                ),
              ),
          ],
        ),
      ),
    );
  }

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
              onPressed: () => setState(() => _currentStep = 0),
            ),
            Expanded(
              child: Text(
                t.enrollment.choose_schedules,
                style: GoogleFonts.outfit(
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
                    style: GoogleFonts.outfit(
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
                      t.enrollment.no_schedules_available_for_thi,
                      style: TextStyle(
                        color: isGlass ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  )
                else
                  ...schedules.map((schedule) {
                    final isSelected = selectedSec?['id'] == schedule['id'];
                    return _buildScheduleItemCard(
                      schedule: schedule,
                      isSelected: isSelected,
                      isArabic: isArabic,
                      isGlass: isGlass,
                      onTap: () {
                        setState(() {
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
              : () => setState(() => _currentStep = 2),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            t.enrollment.review_final_timetable,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItemCard({
    required Map<String, dynamic> schedule,
    required bool isSelected,
    required bool isArabic,
    required bool isGlass,
    required VoidCallback onTap,
  }) {
    final day = schedule['day'] as String;
    final startTime = schedule['start_time'] as String;
    final section = schedule['section_name'] ?? 'General';
    final subSection = schedule['sub_section_name'] ?? '-';
    final room = schedule['room'] ?? '-';

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
                    style: GoogleFonts.outfit(
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
                    style: GoogleFonts.shareTechMono(
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
                      style: GoogleFonts.outfit(
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
              onPressed: () => setState(() => _currentStep = 1),
            ),
            Expanded(
              child: Text(
                t.enrollment.review_registration,
                style: GoogleFonts.outfit(
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
                style: GoogleFonts.outfit(
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
                              "${sec['day']} at ${sec['start_time'].substring(0, 5)} | Room: ${sec['room']}",
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
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
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
            // Celebration circles
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
                      .animate(onPlay: (c) => c.repeat())
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
          style: GoogleFonts.outfit(
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
            t.enrollment.you_have_successfully_register,
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
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }

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
        // Status Banner
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
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (request.advisor != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    t.enrollment.advisor_requestadvisorfullname,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
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
                      style: GoogleFonts.outfit(
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
                  t.enrollment.semester_requestsemester,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
        const SizedBox(height: 16),
        // Courses List
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.enrollment.requested_courses,
                  style: GoogleFonts.outfit(
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
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (rc.sectionName != null)
                                Text(
                                  '${rc.sectionName}${rc.subSectionName != null ? ' / ${rc.subSectionName}' : ''}',
                                  style: GoogleFonts.outfit(
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
              setState(() {
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
