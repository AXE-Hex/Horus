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
import 'package:hue/core/i18n/strings.g.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _passwordController = TextEditingController();
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
  }

  @override
  void dispose() {
    _glowController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _studentIdController.dispose();
    _nationalIdController.dispose();
    _nationalityController.dispose();
    _phoneController.dispose();
    super.dispose();
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

      if (widget.user == null) {
        await controller.createUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          fullName: _nameController.text.trim(),
          roles: _selectedRoles,
          studentId: _studentIdController.text.trim(),
          nationalId: _nationalIdController.text.trim(),
          nationality: _nationalityController.text.trim(),
          phone: _phoneController.text.trim(),
        );
      } else {
        await ref.read(usersRepositoryProvider).updateProfile(widget.user!.id, {
          'full_name': _nameController.text.trim(),
          'roles': _selectedRoles.map((r) => r.toDbString()).toList(),
          'student_id': _studentIdController.text.trim(),
          'national_id': _nationalIdController.text.trim(),
          'nationality': _nationalityController.text.trim(),
          'phone': _phoneController.text.trim(),
          'is_active': _isActive,
        });
        await controller.refresh();
      }

      HapticFeedback.heavyImpact();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(LucideIcons.checkCircle, color: Colors.white),
                const SizedBox(width: 12),
                Text(t.admin.changes_saved_successfully),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: const Color(0xFFEF4444),
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
        title: Text(
          isEdit ? t.admin.edit_user : t.admin.add_new_user,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Section: Personal Info
                      _buildSectionHeader(
                        icon: LucideIcons.user,
                        title: isArabic ? 'المعلومات الشخصية' : 'Personal Info',
                        color: const Color(0xFF6366F1),
                      ),
                      const SizedBox(height: 16),

                      _buildPremiumField(
                            label: t.admin.full_name,
                            controller: _nameController,
                            icon: LucideIcons.user,
                            iconColor: const Color(0xFF6366F1),
                            validator: (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                          )
                          .animate()
                          .fadeIn(delay: 100.ms)
                          .slideY(begin: 0.08, end: 0),

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
                                ),
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(delay: 150.ms)
                          .slideY(begin: 0.08, end: 0),

                      const SizedBox(height: 14),

                      _buildPremiumField(
                            label: t.admin.phone_number,
                            controller: _phoneController,
                            icon: LucideIcons.phone,
                            iconColor: Colors.greenAccent,
                            keyboardType: TextInputType.phone,
                          )
                          .animate()
                          .fadeIn(delay: 180.ms)
                          .slideY(begin: 0.08, end: 0),

                      if (_selectedRoles.any(
                        (r) => r.category == RoleCategory.studentRoles,
                      )) ...[
                        const SizedBox(height: 14),
                        _buildPremiumField(
                              label: t.admin.student_id,
                              controller: _studentIdController,
                              icon: LucideIcons.hash,
                              iconColor: const Color(0xFFF59E0B),
                            )
                            .animate()
                            .fadeIn(delay: 190.ms)
                            .slideY(begin: 0.08, end: 0),
                      ],

                      const SizedBox(height: 28),

                      // ── Section: Account
                      _buildSectionHeader(
                        icon: LucideIcons.mail,
                        title: isArabic ? 'بيانات الحساب' : 'Account',
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
                            validator: (val) =>
                                val == null || !val.contains('@')
                                ? 'Invalid email'
                                : null,
                          )
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .slideY(begin: 0.08, end: 0),

                      if (!isEdit) ...[
                        const SizedBox(height: 14),
                        _buildPremiumField(
                              label: t.admin.password,
                              controller: _passwordController,
                              icon: LucideIcons.lock,
                              iconColor: Colors.pinkAccent,
                              obscureText: true,
                              validator: (val) => val == null || val.length < 6
                                  ? (t.admin.min_6_chars)
                                  : null,
                            )
                            .animate()
                            .fadeIn(delay: 250.ms)
                            .slideY(begin: 0.08, end: 0),
                      ],

                      const SizedBox(height: 28),

                      // ── Section: Roles
                      _buildSectionHeader(
                        icon: LucideIcons.shield,
                        title: widget.initialCategory != null
                            ? t.admin.select_role_in_widgetinitialca
                            : t.admin.select_role_permission,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 16),

                      _buildRoleSelector(isArabic, primaryColor)
                          .animate()
                          .fadeIn(delay: 300.ms)
                          .slideY(begin: 0.08, end: 0),

                      const SizedBox(height: 28),

                      // ── Section: Management (edit only)
                      if (isEdit) ...[
                        _buildSectionHeader(
                          icon: LucideIcons.settings,
                          title: t.admin.advanced_management,
                          color: Colors.orangeAccent,
                        ),
                        const SizedBox(height: 16),
                        _buildManagementZone(isArabic, primaryColor)
                            .animate()
                            .fadeIn(delay: 350.ms)
                            .slideY(begin: 0.08, end: 0),
                        const SizedBox(height: 28),
                      ],

                      // ── Save Button
                      _buildSaveButton(primaryColor, isArabic),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
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
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
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
    String? Function(String?)? validator,
  }) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withValues(alpha: enabled ? 0.04 : 0.02),
        border: Border.all(
          color: Colors.white.withValues(alpha: enabled ? 0.08 : 0.04),
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enabled: enabled,
        keyboardType: keyboardType,
        validator: validator,
        style: GoogleFonts.inter(
          color: enabled ? Colors.white : Colors.white54,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.4),
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
          suffixIcon: !enabled
              ? Icon(
                  LucideIcons.lock,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.2),
                )
              : null,
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

  Widget _buildRoleSelector(bool isArabic, Color primaryColor) {
    final rolesToShow = widget.initialCategory != null
        ? widget.initialCategory!.roles
        : UserRole.values.where((r) => r != UserRole.guest).toList();

    // Group by category
    final grouped = <RoleCategory, List<UserRole>>{};
    for (final role in rolesToShow) {
      grouped.putIfAbsent(role.category, () => []).add(role);
    }

    return GlassContainer(
      borderRadius: BorderRadius.circular(22),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.userCheck, size: 16, color: primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    t.admin.account_status,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Transform.scale(
                scale: 0.75,
                child: Switch(
                  value: _isActive,
                  onChanged: (val) => setState(() => _isActive = val),
                  activeThumbColor: const Color(0xFF10B981),
                  activeTrackColor: const Color(
                    0xFF10B981,
                  ).withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          Divider(height: 24, color: Colors.white.withValues(alpha: 0.06)),
          // Role chips
          ...grouped.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (grouped.length > 1) ...[
                  Text(
                    entry.key.displayName(isArabic: isArabic),
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.3),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: entry.value.map((role) {
                    final isSelected = _selectedRoles.contains(role);
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          if (isSelected) {
                            if (_selectedRoles.length > 1) {
                              _selectedRoles.remove(role);
                            }
                          } else {
                            _selectedRoles.add(role);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: 200.ms,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? primaryColor.withValues(alpha: 0.15)
                              : Colors.white.withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? primaryColor.withValues(alpha: 0.5)
                                : Colors.white.withValues(alpha: 0.06),
                            width: isSelected ? 1.5 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: primaryColor.withValues(alpha: 0.15),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Icon(
                                  LucideIcons.check,
                                  size: 12,
                                  color: primaryColor,
                                ),
                              ),
                            Text(
                              role.displayName(isArabic: isArabic),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? primaryColor
                                    : Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
              ],
            );
          }),
        ],
      ),
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
            color: const Color(0xFF10B981),
          ),
          Divider(height: 28, color: Colors.white.withValues(alpha: 0.06)),
          _buildManageRow(
            icon: LucideIcons.ban,
            label: t.admin.ban_user,
            value: widget.user!.isBanned,
            color: const Color(0xFFEF4444),
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
          Divider(height: 28, color: Colors.white.withValues(alpha: 0.06)),
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
          Divider(height: 28, color: Colors.white.withValues(alpha: 0.06)),
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
          Divider(height: 28, color: Colors.white.withValues(alpha: 0.06)),
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

  Widget _buildSaveButton(Color primaryColor, bool isArabic) {
    return AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) => GestureDetector(
            onTap: _isSaving ? null : _handleSave,
            child: Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, const Color(0xFF10B981)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(
                      alpha: 0.25 + 0.15 * _glowController.value,
                    ),
                    blurRadius: 20,
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: Center(
                child: _isSaving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            LucideIcons.save,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            t.admin.save_changes,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms)
        .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1));
  }

  void _showDeleteConfirmation(BuildContext context, UsersController notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
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
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(LucideIcons.tag, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Text(
              t.admin.manage_tags,
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: TextField(
          controller: controller,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: t.admin.tag1_tag2,
            hintStyle: GoogleFonts.inter(color: Colors.white30),
            helperText: t.admin.separate_tags_with_commas,
            helperStyle: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
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
}
