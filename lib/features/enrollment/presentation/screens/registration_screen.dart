// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/i18n/strings.g.dart';
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
import 'package:hue/features/enrollment/data/models/registration_models.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final String currentSemester = "Spring 2024";

  int _currentStep = 0;
  String? _selectedGroup;
  String? _selectedSubSection;

  bool _isLoading = true;
  bool _isRegistering = false;
  String? _error;

  List<String> _availableGroups = [];
  List<String> _availableSubSections = [];
  List<Course> _semesterCourses = [];

  bool _alreadyRegistered = false;

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
      final auth = ref.read(authControllerProvider);
      final studentId = auth.user?.id;

      if (studentId == null) {
        throw Exception("User not logged in");
      }

      // Check if already registered
      final reg = await repo.getStudentRegistration(studentId, currentSemester);
      if (reg != null) {
        setState(() {
          _alreadyRegistered = true;
          _selectedGroup = reg.sectionName;
          _selectedSubSection = reg.subSectionName;
          _isLoading = false;
        });
        return;
      }

      // Fetch Groups
      _availableGroups = await repo.fetchAvailableSections(currentSemester);

      // If no groups found in Supabase yet, use fallback for UI demo purposes
      if (_availableGroups.isEmpty) {
        _availableGroups = ['A', 'B', 'C'];
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadSubSections(String group) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final repo = ref.read(registrationRepositoryProvider);
      _availableSubSections = await repo.fetchSubSections(
        currentSemester,
        group,
      );

      if (_availableSubSections.isEmpty) {
        _availableSubSections = ['${group}1', '${group}2', '${group}3'];
      }
      setState(() => _currentStep = 1);
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadCourses() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final repo = ref.read(registrationRepositoryProvider);
      _semesterCourses = await repo.fetchCoursesBySemester(currentSemester);

      if (_semesterCourses.isEmpty) {
        // Fallback fake courses for demo if none in DB
        _semesterCourses = [
          Course(
            id: '1',
            code: 'CS405',
            name: 'Machine Learning',
            nameAr: 'تعلم الآلة',
            departmentId: 'cs',
            credits: 3,
          ),
          Course(
            id: '2',
            code: 'CS410',
            name: 'Computer Vision',
            nameAr: 'رؤية حاسوبية',
            departmentId: 'cs',
            credits: 3,
          ),
        ];
      }
      setState(() => _currentStep = 2);
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmRegistration() async {
    setState(() {
      _isRegistering = true;
      _error = null;
    });
    try {
      final repo = ref.read(registrationRepositoryProvider);
      final auth = ref.read(authControllerProvider);

      await repo.registerStudent(
        auth.user!.id,
        currentSemester,
        _selectedGroup!,
        _selectedSubSection!,
      );

      setState(() {
        _alreadyRegistered = true;
        _isRegistering = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.$meta.locale.languageCode == 'ar'
                  ? "تم التسجيل بنجاح!"
                  : "Registration Successful!",
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
          'Error: $_error\n\nTap to retry',
          textAlign: TextAlign.center,
        ),
      );
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
            isArabic ? "تسجيل المقررات" : "Course Registration",
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: isGlass ? Colors.white : Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            background: isGlass
                ? null
                : Container(color: Theme.of(context).primaryColor),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(padding: const EdgeInsets.all(20), child: body),
        ),
      ],
    );

    return isGlass
        ? GlassScaffold(body: scaffoldBody)
        : Scaffold(body: scaffoldBody);
  }

  Widget _buildFunnelSteps(bool isArabic, bool isGlass) {
    if (_currentStep == 0) {
      return _buildGroupSelection(isArabic, isGlass);
    } else if (_currentStep == 1) {
      return _buildSubSectionSelection(isArabic, isGlass);
    } else {
      return _buildConfirmationState(isArabic, isGlass);
    }
  }

  Widget _buildGroupSelection(bool isArabic, bool isGlass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isArabic
              ? "الخطوة ١: اختر المجموعة الرئيسية"
              : "Step 1: Choose Main Group",
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isGlass ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isArabic
              ? "اختر المجموعة التي ترغب بالتسجيل فيها لهذا الفصل الدراسي."
              : "Select the main group you wish to register for this semester.",
          style: TextStyle(color: isGlass ? Colors.white70 : Colors.black54),
        ),
        const SizedBox(height: 24),
        ..._availableGroups.map(
          (group) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildSelectionCard(
              title: isArabic ? "المجموعة $group" : "Group $group",
              subtitle: "Main cohort registration",
              icon: LucideIcons.users,
              isGlass: isGlass,
              onTap: () {
                setState(() => _selectedGroup = group);
                _loadSubSections(group);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubSectionSelection(bool isArabic, bool isGlass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                LucideIcons.arrowLeft,
                color: isGlass ? Colors.white : Colors.black87,
              ),
              onPressed: () => setState(() {
                _currentStep = 0;
                _selectedGroup = null;
              }),
            ),
            Expanded(
              child: Text(
                isArabic
                    ? "الخطوة ٢: اختر القسم الفرعي (السكشن)"
                    : "Step 2: Choose Sub-section",
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          isArabic
              ? "المجموعة المختارة: $_selectedGroup. الآن اختر السكشن العملي والتطبيقي."
              : "Selected Group: $_selectedGroup. Now select your practical sub-section.",
          style: TextStyle(color: isGlass ? Colors.white70 : Colors.black54),
        ),
        const SizedBox(height: 24),
        ..._availableSubSections.map(
          (sec) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildSelectionCard(
              title: isArabic ? "سكشن $sec" : "Section $sec",
              subtitle: "Labs and practical sessions",
              icon: LucideIcons.bookOpen,
              isGlass: isGlass,
              onTap: () {
                setState(() => _selectedSubSection = sec);
                _loadCourses();
              },
            ),
          ),
        ),
      ],
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
                color: isGlass ? Colors.white : Colors.black87,
              ),
              onPressed: () => setState(() {
                _currentStep = 1;
                _selectedSubSection = null;
              }),
            ),
            Expanded(
              child: Text(
                isArabic
                    ? "الخطوة ٣: تأكيد التسجيل"
                    : "Step 3: Confirm Registration",
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isGlass
                ? Colors.white10
                : Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isGlass
                  ? Colors.white24
                  : Colors.blue.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              Text(
                isArabic ? "مراجعة خياراتك" : "Review Selections",
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildReviewItem(
                    isArabic ? "الفصل" : "Semester",
                    currentSemester,
                    isGlass,
                  ),
                  _buildReviewItem(
                    isArabic ? "المجموعة" : "Group",
                    _selectedGroup!,
                    isGlass,
                  ),
                  _buildReviewItem(
                    isArabic ? "السكشن" : "Section",
                    _selectedSubSection!,
                    isGlass,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          isArabic
              ? "المقررات التي سيتم تسجيلها تلقائياً:"
              : "Courses to be automatically registered:",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: isGlass ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ..._semesterCourses.map(
          (c) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(LucideIcons.checkCircle2, color: Colors.green, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isArabic ? c.nameAr ?? c.name : c.name,
                    style: TextStyle(
                      color: isGlass ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Text(
                  isArabic ? "${c.credits} ساعات" : "${c.credits} CR",
                  style: TextStyle(
                    color: isGlass ? Colors.white54 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: _isRegistering ? null : _confirmRegistration,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isRegistering
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  isArabic
                      ? "تأكيد التسجيل النهائي"
                      : "Confirm Final Registration",
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(String label, String value, bool isGlass) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: isGlass ? Colors.white54 : Colors.black54,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: isGlass ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isGlass,
    required VoidCallback onTap,
  }) {
    final content = ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isGlass ? Colors.white10 : Colors.blue.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isGlass ? Colors.white : Colors.blue),
      ),
      title: Text(
        title,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: isGlass ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: isGlass ? Colors.white60 : Colors.black54),
      ),
      trailing: Icon(
        LucideIcons.chevronRight,
        color: isGlass ? Colors.white54 : Colors.black38,
      ),
    );

    return isGlass
        ? InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: EdgeInsets.zero,
              child: content,
            ),
          )
        : InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: content,
            ),
          );
  }

  Widget _buildSuccessState(bool isArabic, bool isGlass) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          LucideIcons.checkCircle2,
          size: 80,
          color: isGlass ? Colors.greenAccent : Colors.green,
        ),
        const SizedBox(height: 24),
        Text(
          isArabic ? "مسجل بالفعل!" : "Already Registered!",
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isGlass ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isArabic
              ? "لقد قمت بالتسجيل المسبق بنجاح في هذا الفصل.\nالمجموعة: $_selectedGroup | السكشن: $_selectedSubSection"
              : "You have successfully registered for this semester.\nGroup: $_selectedGroup | Section: $_selectedSubSection",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isGlass ? Colors.white70 : Colors.black54,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () => context.pop(),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isArabic ? "العودة للرئيسية" : "Back to Home",
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
