import 'package:horus/core/router/back_navigation.dart';
import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:horus/features/enrollment/data/repositories/registration_repository.dart';
import 'package:horus/features/enrollment/data/repositories/advisor_repository.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:horus/features/academic/presentation/providers/semester_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'registration_course_sections.dart';
part 'registration_schedule_sections.dart';
part 'registration_confirmation_sections.dart';
part 'registration_status_sections.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  String currentSemester = '';

  int _currentStep = 0;
  final List<Course> _selectedCourses = [];
  final Map<String, ScheduleOption> _selectedSections = {};

  bool _isLoading = true;
  bool _isRegistering = false;
  String? _error;

  List<Course> _semesterCourses = [];
  Map<String, bool> _lockedCourses = {};

  final Map<String, List<ScheduleOption>> _courseSchedulesCache = {};

  bool _alreadyRegistered = false;
  RegistrationRequest? _existingRequest;

  void _updateState(VoidCallback callback) => setState(callback);

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
      final semester = await ref.read(currentSemesterProvider.future);
      if (semester == null) {
        _error = t.academic.no_data;
        return;
      }
      currentSemester = semester.code;

      if (studentId == null) throw Exception("User not logged in");

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

      _semesterCourses = await repo.fetchCoursesBySemester(currentSemester);
      _lockedCourses = await repo.checkPrerequisites(
        studentId,
        _semesterCourses,
      );
    } catch (e) {
      _error = t.academic.error;
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
      setState(() => _error = t.academic.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmRegistration() async {
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
        return RegistrationCourseSelection(
          courseId: c.id,
          sectionName: sec.sectionName,
          subSectionName: sec.subSectionName,
        );
      }).toList();

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
        _error = t.academic.error;
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
          'Error loading registration: $_error',
          textAlign: TextAlign.center,
        ),
      );
    } else if (_existingRequest != null) {
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
            onPressed: () => context.backToHorus(),
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
}
