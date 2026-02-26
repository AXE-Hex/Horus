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
  late UserRole _selectedRole;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _passwordController = TextEditingController();
    _nameController = TextEditingController(text: widget.user?.fullName ?? '');

    if (widget.user != null) {
      _selectedRole = widget.user!.role;
    } else if (widget.initialRole != null) {
      _selectedRole = widget.initialRole!;
    } else if (widget.initialCategory != null) {
      final categoryRoles = widget.initialCategory!.roles;
      _selectedRole = categoryRoles.isNotEmpty
          ? categoryRoles.first
          : UserRole.student;
    } else {
      _selectedRole = UserRole.student;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
          role: _selectedRole,
        );
      } else {
        await ref.read(usersRepositoryProvider).updateProfile(widget.user!.id, {
          'full_name': _nameController.text.trim(),
          'role': _selectedRole.toDbString(),
        });
        await controller.refresh();
      }

      if (mounted) context.pop();
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
      appBar: AppBar(
        title: Text(
          isEdit
              ? (isArabic ? 'تعديل مستخدم' : 'Edit User')
              : (isArabic ? 'إضافة مستخدم جديد' : 'Add New User'),
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
                label: isArabic ? 'الاسم بالكامل' : 'Full Name',
                controller: _nameController,
                icon: LucideIcons.user,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              _buildField(
                label: isArabic ? 'البريد الإلكتروني' : 'Email Address',
                controller: _emailController,
                icon: LucideIcons.mail,
                keyboardType: TextInputType.emailAddress,
                enabled: !isEdit,
                validator: (val) =>
                    val == null || !val.contains('@') ? 'Invalid email' : null,
              ),
              if (!isEdit) ...[
                const SizedBox(height: 24),
                _buildField(
                  label: isArabic ? 'كلمة المرور' : 'Password',
                  controller: _passwordController,
                  icon: LucideIcons.lock,
                  obscureText: true,
                  validator: (val) => val == null || val.length < 6
                      ? (isArabic ? '6 أحرف على الأقل' : 'Min 6 chars')
                      : null,
                ),
              ],
              const SizedBox(height: 24),
              Text(
                isArabic ? 'اختر الرتبة الصلاحية' : 'Select Role / Permission',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildRoleSelector(isArabic),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _isSaving ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        isArabic ? 'حفظ البيانات' : 'Save Changes',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
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

    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      borderRadius: BorderRadius.circular(20),
      opacity: 0.08,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserRole>(
          value: _selectedRole,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          icon: const Icon(LucideIcons.chevronDown, size: 20),
          items: rolesToShow.map((role) {
            return DropdownMenuItem(
              value: role,
              child: Text(
                role.displayName(isArabic: isArabic),
                style: GoogleFonts.inter(fontSize: 15),
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) setState(() => _selectedRole = val);
          },
        ),
      ),
    );
  }
}
