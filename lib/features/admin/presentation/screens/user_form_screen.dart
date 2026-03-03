import 'package:flutter/material.dart';
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

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
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

  @override
  void initState() {
    super.initState();
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
      // For student roles category, default to 'student'
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

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(LucideIcons.checkCircle, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  t.admin.changes_saved_successfully,
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
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

    return GlassScaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          isEdit
              ? (t.admin.edit_user)
              : (t.admin.add_new_user),
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildField(
                label: t.admin.full_name,
                controller: _nameController,
                icon: LucideIcons.user,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      label: t.admin.nationality,
                      controller: _nationalityController,
                      icon: LucideIcons.globe,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildField(
                      label: t.admin.national_id,
                      controller: _nationalIdController,
                      icon: LucideIcons.contact,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1, end: 0),
              const SizedBox(height: 20),
              _buildField(
                label: t.admin.phone_number,
                controller: _phoneController,
                icon: LucideIcons.phone,
                keyboardType: TextInputType.phone,
              ).animate().fadeIn(delay: 180.ms).slideY(begin: 0.1, end: 0),
              const SizedBox(height: 20),
              if (_selectedRoles.any(
                (r) => r.category == RoleCategory.studentRoles,
              ))
                _buildField(
                  label: t.admin.student_id,
                  controller: _studentIdController,
                  icon: LucideIcons.hash,
                ).animate().fadeIn(delay: 190.ms).slideY(begin: 0.1, end: 0),
              _buildField(
                label: t.admin.email_address,
                controller: _emailController,
                icon: LucideIcons.mail,
                keyboardType: TextInputType.emailAddress,
                enabled: !isEdit,
                validator: (val) =>
                    val == null || !val.contains('@') ? 'Invalid email' : null,
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
              if (!isEdit) ...[
                const SizedBox(height: 24),
                _buildField(
                  label: t.admin.password,
                  controller: _passwordController,
                  icon: LucideIcons.lock,
                  obscureText: true,
                  validator: (val) => val == null || val.length < 6
                      ? (t.admin.min_6_chars)
                      : null,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
              ],
              const SizedBox(height: 24),
              Text(
                widget.initialCategory != null
                    ? (t.admin.select_role_in_widgetinitialca)
                    : (t.admin.select_role_permission),
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildRoleSelector(
                isArabic,
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
              const SizedBox(height: 32),
              if (isEdit) ...[
                _buildManagementZone(isArabic),
                const SizedBox(height: 32),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                    onPressed: _isSaving ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shadowColor: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.5),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            t.admin.save_changes,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.1,
                            ),
                          ),
                  )
                  .animate()
                  .fadeIn(delay: 500.ms)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                  ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    bool enabled = true,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ),
        GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          borderRadius: BorderRadius.circular(20),
          opacity: enabled ? 0.08 : 0.03,
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            enabled: enabled,
            keyboardType: keyboardType,
            validator: validator,
            style: GoogleFonts.inter(fontSize: 15),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 20,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSelector(bool isArabic) {
    final rolesToShow = widget.initialCategory != null
        ? widget.initialCategory!.roles
        : UserRole.values.where((r) => r != UserRole.guest).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.admin.user_roles_ranks,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              GlassContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  children: [
                    Text(
                      t.admin.account_status,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        value: _isActive,
                        onChanged: (val) => setState(() => _isActive = val),
                        activeThumbColor: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: rolesToShow.map((role) {
            final isSelected = _selectedRoles.contains(role);
            final color = isSelected
                ? Theme.of(context).primaryColor
                : Colors.white.withValues(alpha: 0.05);

            return InkWell(
              onTap: () {
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
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: 200.ms,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? color.withValues(alpha: 0.15) : color,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? color
                        : Colors.white.withValues(alpha: 0.05),
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (role.isTeachingStaff)
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Icon(LucideIcons.graduationCap, size: 14),
                      ),
                    Text(
                      role.displayName(isArabic: isArabic),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? color
                            : Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildManagementZone(bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.admin.advanced_management,
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GlassContainer(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(24),
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
              ),
              const Divider(height: 32),
              _buildManageRow(
                icon: LucideIcons.ban,
                label: t.admin.ban_user,
                value: widget.user!.isBanned,
                color: Colors.redAccent,
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
              const Divider(height: 32),
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
                  icon: const Icon(LucideIcons.tag, size: 18),
                  label: Text(t.admin.manage_tags),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    alignment: isArabic
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                  ),
                ),
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.alertTriangle, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        t.admin.warning_level,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      final isSelected = widget.user!.warningLevel >= index;
                      return IconButton(
                        icon: Icon(
                          isSelected ? Icons.warning : Icons.warning_amber,
                          size: 18,
                          color: isSelected ? Colors.orange : Colors.grey,
                        ),
                        onPressed: () {
                          ref
                              .read(
                                usersControllerProvider(
                                  category: widget.initialCategory,
                                  role: widget.initialRole,
                                ).notifier,
                              )
                              .updateWarningLevel(widget.user!.id, index);
                        },
                      );
                    }),
                  ),
                ],
              ),
              const Divider(height: 32),
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
                  icon: const Icon(LucideIcons.trash2, size: 18),
                  label: Text(
                    t.admin.permanently_delete_user,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildManageRow({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: color ?? Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context, UsersController notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.admin.delete_user),
        content: Text(
          t.admin.are_you_sure_you_want_to_delet,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.admin.cancel),
          ),
          TextButton(
            onPressed: () {
              notifier.deleteUser(widget.user!.id);
              Navigator.pop(context);
              context.pop(); // Exit detail screen
            },
            child: Text(
              t.admin.delete,
              style: const TextStyle(color: Colors.red),
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
        title: Text(t.admin.manage_tags),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: t.admin.tag1_tag2,
            helperText: t.admin.separate_tags_with_commas,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.admin.cancel),
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
            child: Text(t.admin.save),
          ),
        ],
      ),
    );
  }
}
