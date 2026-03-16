import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/roles.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/features/admin/presentation/providers/users_provider.dart';
import 'package:hue/features/admin/data/repositories/users_repository.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'dart:math';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/data/repositories/institutional_repository.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hue/features/shared/presentation/widgets/premium_success_overlay.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  final UserProfileModel? user;
  final RoleCategory? initialCategory;
  final UserRole? initialRole;

  const UserFormScreen({
    super.key,
    this.user,
    this.initialCategory,
    this.initialRole,
  });

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  late final TextEditingController _studentIdController;
  late final TextEditingController _nationalIdController;
  late final TextEditingController _nationalityController;
  late final TextEditingController _phoneController;

  List<UserRole> _selectedRoles = [];
  bool _isSaving = false;
  bool _isActive = true;
  String _selectedGender = 'male'; // male / female

  // Password strength
  double _passwordStrength = 0;
  String _passwordStrengthLabel = '';
  Color _passwordStrengthColor = Colors.grey;

  // Institution Selection
  String? _selectedCollegeId;
  String? _selectedDepartmentId;
  List<CollegeModel> _colleges = [];
  List<DepartmentModel> _departments = [];
  bool _isLoadingColleges = true;
  bool _isLoadingDepartments = false;
  int _currentStep = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    String initialEmail = widget.user?.email ?? '';
    if (initialEmail.endsWith('@horus.edu.eg')) {
      initialEmail = initialEmail.substring(
        0,
        initialEmail.length - '@horus.edu.eg'.length,
      );
    }
    _emailController = TextEditingController(text: initialEmail);
    _passwordController = TextEditingController()
      ..addListener(_checkPasswordStrength);
    _nameController = TextEditingController(text: widget.user?.fullName ?? '');
    _studentIdController = TextEditingController(
      text: widget.user?.studentId ?? '',
    );
    _nationalIdController = TextEditingController(
      text: widget.user?.nationalId ?? '',
    );
    _nationalityController = TextEditingController(
      text: widget.user?.nationality ?? '',
    );
    _phoneController = TextEditingController(text: widget.user?.phone ?? '');
    _isActive = widget.user?.isActive ?? true;

    if (widget.user != null) {
      _selectedRoles = List.from(widget.user!.roles);
    } else if (widget.initialRole != null) {
      _selectedRoles = [widget.initialRole!];
    } else if (widget.initialCategory != null) {
      final categoryRoles = widget.initialCategory!.roles;
      if (widget.initialCategory == RoleCategory.studentRoles) {
        _selectedRoles = [UserRole.student];
      } else {
        _selectedRoles = categoryRoles.isNotEmpty
            ? [categoryRoles.first]
            : [UserRole.student];
      }
    } else {
      _selectedRoles = [UserRole.student];
    }

    if (widget.user != null) {
      _selectedCollegeId = widget.user!.collegeId;
      _selectedDepartmentId = widget.user!.departmentId;
    }

    _loadInstitutions();
  }

  Future<void> _loadInstitutions() async {
    try {
      final repo = ref.read(institutionalRepositoryProvider);
      final colleges = await repo.getColleges();
      if (mounted) {
        setState(() {
          _colleges = colleges;
          _isLoadingColleges = false;
        });
        if (_selectedCollegeId != null) {
          _loadDepartments(_selectedCollegeId!);
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingColleges = false);
    }
  }

  void _checkPasswordStrength() {
    final password = _passwordController.text;
    double strength = 0;
    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#\$&*~]'))) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
      if (strength <= 0.25) {
        _passwordStrengthLabel = t.$meta.locale.languageCode == 'ar'
            ? 'ضعيف'
            : 'Weak';
        _passwordStrengthColor = Colors.red;
      } else if (strength <= 0.5) {
        _passwordStrengthLabel = t.$meta.locale.languageCode == 'ar'
            ? 'متوسط'
            : 'Fair';
        _passwordStrengthColor = Colors.orange;
      } else if (strength <= 0.75) {
        _passwordStrengthLabel = t.$meta.locale.languageCode == 'ar'
            ? 'جيد'
            : 'Good';
        _passwordStrengthColor = Colors.amber;
      } else {
        _passwordStrengthLabel = t.$meta.locale.languageCode == 'ar'
            ? 'قوي'
            : 'Strong';
        _passwordStrengthColor = Colors.green;
      }
    });
  }

  void _generatePassword() {
    const length = 12;
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$&*~';
    final random = Random.secure();
    final password = List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
    _passwordController.text = password;
  }

  Future<void> _loadDepartments(String collegeId) async {
    if (!mounted) return;
    setState(() => _isLoadingDepartments = true);
    try {
      final repo = ref.read(institutionalRepositoryProvider);
      final deps = await repo.getDepartments(collegeId: collegeId);
      if (mounted) {
        setState(() {
          _departments = deps;
          _isLoadingDepartments = false;
          // Ensure selected department is valid
          if (_selectedDepartmentId != null &&
              !deps.any((d) => d.id == _selectedDepartmentId)) {
            _selectedDepartmentId = null;
          }
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingDepartments = false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      if (_validateCurrentStep()) {
        setState(() => _currentStep++);
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _handleSave();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    // We could add more granular validation here if needed
    // For now, most fields are optional except Name and Email
    if (_currentStep == 0) {
      if (_nameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.$meta.locale.languageCode == 'ar' ? 'الاسم مطلوب' : 'Name is required')),
        );
        return false;
      }
    }
    if (_currentStep == 1 && widget.user == null) {
      if (_emailController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.$meta.locale.languageCode == 'ar' ? 'البريد مطلوب' : 'Email is required')),
        );
        return false;
      }
      if (_passwordController.text.length < 8) {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.$meta.locale.languageCode == 'ar' ? 'كلمة المرور قصيرة' : 'Password is too short')),
        );
        return false;
      }
    }
    return true;
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    HapticFeedback.mediumImpact();

    try {
      final controller = ref.read(
        usersControllerProvider(
          category: widget.initialCategory,
          role: widget.initialRole,
        ).notifier,
      );

      // Build full email with domain suffix
      final fullEmail = '${_emailController.text.trim()}@horus.edu.eg';

      if (widget.user == null) {
        await controller.createUser(
          email: fullEmail,
          password: _passwordController.text.trim(),
          fullName: _nameController.text.trim(),
          roles: _selectedRoles,
          gender: _selectedGender,
          studentId: _studentIdController.text.trim(),
          nationalId: _nationalIdController.text.trim(),
          nationality: _nationalityController.text.trim(),
          phone: _phoneController.text.trim(),
          collegeId: _selectedCollegeId,
          departmentId: _selectedDepartmentId,
        );
      } else {
        await ref.read(usersRepositoryProvider).updateProfile(widget.user!.id, {
          'full_name': _nameController.text.trim(),
          'roles': _selectedRoles.map((r) => r.toDbString()).toList(),
          'gender': _selectedGender,
          'student_id': _studentIdController.text.trim(),
          'national_id': _nationalIdController.text.trim(),
          'nationality': _nationalityController.text.trim(),
          'phone': _phoneController.text.trim(),
          'is_active': _isActive,
          'college_id': _selectedCollegeId,
          'department_id': _selectedDepartmentId,
        });
        await controller.refresh();
      }

      HapticFeedback.heavyImpact();
      if (mounted) {
        PremiumSuccessOverlay.show(
          context,
          title: t.admin.changes_saved_successfully,
          message: widget.user == null 
              ? (t.$meta.locale.languageCode == 'ar' ? 'تم إنشاء الحساب بنجاح' : 'User account created successfully')
              : (t.$meta.locale.languageCode == 'ar' ? 'تم تحديث البيانات بنجاح' : 'Profile updated successfully'),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final isEdit = widget.user != null;
    final primaryColor = Theme.of(context).primaryColor;

    return GlassScaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEdit ? t.admin.edit_user : t.admin.add_new_user,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              _getStepTitle(_currentStep, isArabic),
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildStepIndicator(primaryColor),
          Expanded(
            child: Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildPersonalStep(isArabic, primaryColor),
                  _buildAccountStep(isArabic, isEdit, primaryColor),
                  _buildRolesStep(isArabic, primaryColor),
                  _buildAffiliationStep(isArabic, primaryColor, isEdit),
                ],
              ),
            ),
          ),
          _buildNavigationButtons(primaryColor, isArabic),
        ],
      ),
    );
  }

  String _getStepTitle(int step, bool isArabic) {
    switch (step) {
      case 0: return t.extracted.personal_details;
      case 1: return t.extracted.account_credentials;
      case 2: return t.extracted.roles_permissions;
      case 3: return t.extracted.academic_affiliation;
      default: return '';
    }
  }

  Widget _buildStepIndicator(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isActive ? primaryColor : Colors.white10,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? primaryColor : Colors.white24,
                      width: 2,
                    ),
                    boxShadow: isActive ? [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                      )
                    ] : null,
                  ),
                  child: Center(
                    child: index < _currentStep 
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : Text(
                        '${index + 1}',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : Colors.white30,
                        ),
                      ),
                  ),
                ),
                if (index < 3)
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: index < _currentStep ? primaryColor : Colors.white10,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.03, end: 0);
  }

  Widget _buildPremiumField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    Color iconColor = Colors.white,
    bool obscureText = false,
    bool enabled = true,
    TextInputType? keyboardType,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    Widget? suffix,
    String? suffixText,
  }) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(
          context,
        ).colorScheme.onSurface.withValues(alpha: enabled ? 0.04 : 0.02),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: enabled ? 0.08 : 0.04),
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enabled: enabled,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        validator: validator,
        style: GoogleFonts.inter(
          color: enabled ? Colors.white : Colors.white54,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.4),
            fontSize: 13,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          suffixText: suffixText,
          suffixStyle: suffixText != null
              ? GoogleFonts.inter(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                )
              : null,
          suffixIcon:
              suffix ??
              (!enabled
                  ? Icon(
                      LucideIcons.lock,
                      size: 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.2),
                    )
                  : null),
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: primaryColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.redAccent.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }


  Widget _buildInstitutionSelectors(bool isArabic, Color primaryColor) {
    if (_isLoadingColleges) {
      return const Center(child: CircularProgressIndicator());
    }

    final requiresCollege = _selectedRoles.any(
      (r) =>
          r.category != RoleCategory.adminIT &&
          r.category != RoleCategory.externalRoles,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader(
          icon: LucideIcons.building,
          title: t.extracted.institution,
          color:
              (Theme.of(context).cardTheme.color ??
              Theme.of(context).cardColor),
        ),
        SizedBox(height: 16),
        GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              dropdownColor: Color(0xFF1E1E3A),
              decoration: InputDecoration(border: InputBorder.none),
              icon: Icon(
                LucideIcons.chevronDown,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              initialValue: _selectedCollegeId,
              hint: Text(
                t.extracted.select_college,
                style: GoogleFonts.outfit(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              items: _colleges.map((college) {
                return DropdownMenuItem<String>(
                  value: college.id,
                  child: Text(
                    isArabic && college.nameAr.isNotEmpty
                        ? college.nameAr
                        : college.nameEn,
                    style: GoogleFonts.outfit(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
              validator: requiresCollege
                  ? (val) => val == null || val.isEmpty
                        ? (t.extracted.college_is_required)
                        : null
                  : null,
              onChanged: (val) {
                setState(() {
                  _selectedCollegeId = val;
                  _selectedDepartmentId = null;
                });
                if (val != null) {
                  _loadDepartments(val);
                }
              },
            ),
          ),
        ),
        if (_selectedCollegeId != null) ...[
          SizedBox(height: 14),
          if (_isLoadingDepartments)
            Center(child: CircularProgressIndicator())
          else
            GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  dropdownColor: Color(0xFF1E1E3A),
                  decoration: InputDecoration(border: InputBorder.none),
                  icon: Icon(
                    LucideIcons.chevronDown,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  initialValue: _selectedDepartmentId,
                  hint: Text(
                    t.extracted.select_department,
                    style: GoogleFonts.outfit(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  items: _departments.map((dept) {
                    return DropdownMenuItem<String>(
                      value: dept.id,
                      child: Text(
                        isArabic && dept.nameAr.isNotEmpty
                            ? dept.nameAr
                            : dept.nameEn,
                        style: GoogleFonts.outfit(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    );
                  }).toList(),
                  validator: requiresCollege && _departments.isNotEmpty
                      ? (val) => val == null || val.isEmpty
                            ? (t.extracted.department_is_required)
                            : null
                      : null,
                  onChanged: (val) {
                    setState(() {
                      _selectedDepartmentId = val;
                    });
                  },
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildManagementZone(bool isArabic, Color primaryColor) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(22),
      child: Column(
        children: [
          _buildManageRow(
            icon: LucideIcons.userCheck,
            label: t.admin.account_verification,
            value: widget.user!.isVerified,
            onChanged: (val) {
              ref
                  .read(
                    usersControllerProvider(
                      category: widget.initialCategory,
                      role: widget.initialRole,
                    ).notifier,
                  )
                  .toggleVerification(widget.user!.id, val);
            },
            color:
                (Theme.of(context).cardTheme.color ??
                Theme.of(context).cardColor),
          ),
          Divider(
            height: 28,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.06),
          ),
          _buildManageRow(
            icon: LucideIcons.ban,
            label: t.admin.ban_user,
            value: widget.user!.isBanned,
            color:
                (Theme.of(context).cardTheme.color ??
                Theme.of(context).cardColor),
            onChanged: (val) {
              ref
                  .read(
                    usersControllerProvider(
                      category: widget.initialCategory,
                      role: widget.initialRole,
                    ).notifier,
                  )
                  .toggleBan(widget.user!.id, val);
            },
          ),
          Divider(
            height: 28,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.06),
          ),
          // Tags
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                final notifier = ref.read(
                  usersControllerProvider(
                    category: widget.initialCategory,
                    role: widget.initialRole,
                  ).notifier,
                );
                _showTagsDialog(context, notifier);
              },
              icon: Icon(LucideIcons.tag, size: 16, color: primaryColor),
              label: Text(
                t.admin.manage_tags,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                alignment: isArabic
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Divider(
            height: 28,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.06),
          ),
          // Warning level
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      LucideIcons.alertTriangle,
                      size: 14,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    t.admin.warning_level,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Row(
                children: List.generate(5, (index) {
                  final isSelected = widget.user!.warningLevel >= index;
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      ref
                          .read(
                            usersControllerProvider(
                              category: widget.initialCategory,
                              role: widget.initialRole,
                            ).notifier,
                          )
                          .updateWarningLevel(widget.user!.id, index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Icon(
                        isSelected ? Icons.warning : Icons.warning_amber,
                        size: 18,
                        color: isSelected
                            ? Colors.orangeAccent
                            : Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Divider(
            height: 28,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.06),
          ),
          // Delete button
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                final notifier = ref.read(
                  usersControllerProvider(
                    category: widget.initialCategory,
                    role: widget.initialRole,
                  ).notifier,
                );
                _showDeleteConfirmation(context, notifier);
              },
              icon: const Icon(LucideIcons.trash2, size: 16),
              label: Text(
                t.admin.permanently_delete_user,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEF4444),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageRow({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? color,
  }) {
    final c = color ?? Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 14, color: c),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: c,
              ),
            ),
          ],
        ),
        Transform.scale(
          scale: 0.75,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: c,
            activeTrackColor: c.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }


  void _showDeleteConfirmation(BuildContext context, UsersController notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            const Icon(LucideIcons.alertTriangle, color: Colors.redAccent),
            const SizedBox(width: 12),
            Text(
              t.admin.delete_user,
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          t.admin.are_you_sure_you_want_to_delet,
          style: GoogleFonts.inter(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              t.admin.cancel,
              style: GoogleFonts.inter(color: Colors.white60),
            ),
          ),
          TextButton(
            onPressed: () {
              notifier.deleteUser(widget.user!.id);
              Navigator.pop(context);
              this.context.pop();
            },
            child: Text(
              t.admin.delete,
              style: GoogleFonts.inter(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTagsDialog(BuildContext context, UsersController notifier) {
    final controller = TextEditingController(
      text: widget.user!.tags.join(', '),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(LucideIcons.tag, color: Theme.of(context).primaryColor),
            SizedBox(width: 12),
            Text(
              t.admin.manage_tags,
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: TextField(
          controller: controller,
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: t.admin.tag1_tag2,
            hintStyle: GoogleFonts.inter(color: Colors.white30),
            helperText: t.admin.separate_tags_with_commas,
            helperStyle: GoogleFonts.inter(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.3),
              fontSize: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              t.admin.cancel,
              style: GoogleFonts.inter(color: Colors.white60),
            ),
          ),
          TextButton(
            onPressed: () {
              final tags = controller.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
              notifier.updateTags(widget.user!.id, tags);
              Navigator.pop(context);
            },
            child: Text(
              t.admin.save,
              style: GoogleFonts.inter(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalStep(bool isArabic, Color primaryColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader(
            icon: LucideIcons.user,
            title: t.extracted.personal_info,
            color: (Theme.of(context).cardTheme.color ?? Theme.of(context).cardColor),
          ),
          const SizedBox(height: 16),
          _buildPremiumField(
            label: t.admin.full_name,
            controller: _nameController,
            icon: LucideIcons.user,
            iconColor: const Color(0xFF6366F1),
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildPremiumField(
                  label: t.admin.nationality,
                  controller: _nationalityController,
                  icon: LucideIcons.globe,
                  iconColor: const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPremiumField(
                  label: t.admin.national_id,
                  controller: _nationalIdController,
                  icon: LucideIcons.creditCard,
                  iconColor: Colors.amberAccent,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildPremiumField(
            label: t.admin.phone_number,
            controller: _phoneController,
            icon: LucideIcons.phone,
            iconColor: Colors.greenAccent,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 11,
          ),
          if (_selectedRoles.any((r) => r.category == RoleCategory.studentRoles)) ...[
            const SizedBox(height: 14),
            _buildPremiumField(
              label: t.admin.student_id,
              controller: _studentIdController,
              icon: LucideIcons.hash,
              iconColor: const Color(0xFFF59E0B),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 16,
            ),
          ],
          const SizedBox(height: 14),
           _buildGenderSelectorInternal(isArabic, primaryColor),
        ],
      ),
    );
  }

  Widget _buildGenderSelectorInternal(bool isArabic, Color primaryColor) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(LucideIcons.users, size: 16, color: primaryColor),
              const SizedBox(width: 12),
              Text(
                t.extracted.gender,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Row(
            children: [
              ChoiceChip(
                label: Text(t.extracted.male),
                selected: _selectedGender == 'male',
                onSelected: (val) => setState(() => _selectedGender = 'male'),
                backgroundColor: Colors.transparent,
                selectedColor: primaryColor.withValues(alpha: 0.2),
                labelStyle: GoogleFonts.inter(
                  color: _selectedGender == 'male' ? primaryColor : Colors.white54,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: Text(t.extracted.female),
                selected: _selectedGender == 'female',
                onSelected: (val) => setState(() => _selectedGender = 'female'),
                backgroundColor: Colors.transparent,
                selectedColor: primaryColor.withValues(alpha: 0.2),
                labelStyle: GoogleFonts.inter(
                  color: _selectedGender == 'female' ? primaryColor : Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountStep(bool isArabic, bool isEdit, Color primaryColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader(
            icon: LucideIcons.mail,
            title: t.extracted.account,
            color: Colors.tealAccent,
          ),
          const SizedBox(height: 16),
          _buildPremiumField(
            label: t.admin.email_address,
            controller: _emailController,
            icon: LucideIcons.mail,
            iconColor: Colors.tealAccent,
            keyboardType: TextInputType.emailAddress,
            enabled: !isEdit,
            suffixText: '@horus.edu.eg',
            validator: (val) {
              if (val == null || val.trim().isEmpty) return t.extracted.required;
              if (val.contains('@')) return t.extracted.enter_prefix_only;
              return null;
            },
          ),
          if (!isEdit) ...[
            const SizedBox(height: 14),
            _buildPremiumField(
              label: t.admin.password,
              controller: _passwordController,
              icon: LucideIcons.lock,
              iconColor: Colors.pinkAccent,
              obscureText: true,
              suffix: IconButton(
                icon: const Icon(LucideIcons.refreshCw, size: 16, color: Colors.white54),
                onPressed: _generatePassword,
              ),
            ),
            const SizedBox(height: 8),
            if (_passwordController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: _passwordStrength,
                        backgroundColor: Colors.white10,
                        color: _passwordStrengthColor,
                        minHeight: 4,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(_passwordStrengthLabel, style: GoogleFonts.inter(color: _passwordStrengthColor, fontSize: 11)),
                  ],
                ),
              ),
          ],
           const SizedBox(height: 14),
           _buildStatusToggleInternal(isArabic, primaryColor),
        ],
      ),
    );
  }

  Widget _buildStatusToggleInternal(bool isArabic, Color primaryColor) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(LucideIcons.userCheck, size: 16, color: primaryColor),
              const SizedBox(width: 12),
              Text(
                t.admin.account_status,
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white70),
              ),
            ],
          ),
          Switch(
            value: _isActive,
            onChanged: (val) => setState(() => _isActive = val),
            activeColor: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _buildRolesStep(bool isArabic, Color primaryColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader(
            icon: LucideIcons.shield,
            title: widget.initialCategory != null ? t.admin.select_role_in_widgetinitialca : t.admin.select_role_permission,
            color: primaryColor,
          ),
          const SizedBox(height: 16),
          _buildRoleSelectorInsideStep(isArabic, primaryColor),
        ],
      ),
    );
  }

  Widget _buildRoleSelectorInsideStep(bool isArabic, Color primaryColor) {
    final rolesToShow = widget.initialCategory != null
        ? widget.initialCategory!.roles
        : UserRole.values.where((r) => r != UserRole.guest).toList();

    final grouped = <RoleCategory, List<UserRole>>{};
    for (final role in rolesToShow) {
      grouped.putIfAbsent(role.category, () => []).add(role);
    }

    return Column(
      children: grouped.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (grouped.length > 1) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                child: Text(
                  entry.key.displayName(isArabic: isArabic),
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white30),
                ),
              ),
            ],
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: entry.value.map((role) {
                final isSelected = _selectedRoles.contains(role);
                return FilterChip(
                  label: Text(role.displayName(isArabic: isArabic)),
                  selected: isSelected,
                  onSelected: (val) {
                    setState(() {
                      if (isSelected) {
                        if (_selectedRoles.length > 1) _selectedRoles.remove(role);
                      } else {
                        _selectedRoles.add(role);
                      }
                    });
                  },
                  selectedColor: primaryColor.withValues(alpha: 0.2),
                  checkmarkColor: primaryColor,
                  labelStyle: GoogleFonts.inter(
                    color: isSelected ? primaryColor : Colors.white54,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildAffiliationStep(bool isArabic, Color primaryColor, bool isEdit) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           _buildInstitutionSelectors(isArabic, primaryColor),
           if (isEdit) ...[
             const SizedBox(height: 32),
             _buildSectionHeader(
              icon: LucideIcons.settings,
              title: t.admin.advanced_management,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 16),
            _buildManagementZone(isArabic, primaryColor),
           ],
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(Color primaryColor, bool isArabic) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSaving ? null : _prevStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.white10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(t.extracted.previous, style: GoogleFonts.inter(color: Colors.white70)),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentStep == 3 ? const Color(0xFF10B981) : primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
                child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentStep == 3 
                          ? (widget.user != null ? t.admin.save_changes : (t.extracted.create_account))
                          : (t.extracted.next),
                        style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Icon(_currentStep == 3 ? LucideIcons.check : LucideIcons.arrowRight, size: 18),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
