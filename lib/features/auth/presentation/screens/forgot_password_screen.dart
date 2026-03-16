import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/error/app_exception.dart';
import 'package:hue/core/error/error_handler.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  int _selectedMethod = 0;
  bool _isIdUploaded = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    try {
      if (_emailController.text.isEmpty) {
        throw ValidationException(code: '001', message: t.auth.login.email);
      }

      if (_phoneController.text.isEmpty) {
        throw ValidationException(
          code: '002',
          message: t.auth.forgot_password.error_empty_phone,
        );
      }
      if (_selectedMethod == 1 && !_isIdUploaded) {
        throw ValidationException(
          code: '003',
          message: t.auth.forgot_password.error_no_id,
        );
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.auth.forgot_password.success),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      });
    } catch (e) {
      ErrorHandler.showError(context, e);
    }
  }

  void _simulateUpload() {
    setState(() {
      _isIdUploaded = !_isIdUploaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    const isGlass = true;

    Widget formContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.settings.forgot_password,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.auth.choose_account_recovery_method,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _MethodTab(
                  title: t.auth.forgot_password.method_admin,
                  icon: LucideIcons.building,
                  isSelected: _selectedMethod == 0,
                  onTap: () => setState(() => _selectedMethod = 0),
                ),
              ),
              Expanded(
                child: _MethodTab(
                  title: t.auth.forgot_password.method_online,
                  icon: LucideIcons.smartphone,
                  isSelected: _selectedMethod == 1,
                  onTap: () => setState(() => _selectedMethod = 1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        AnimatedCrossFade(
          firstChild: _buildAdminContent(context),
          secondChild: _buildOnlineContent(context, isGlass),
          crossFadeState: _selectedMethod == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        ),

        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            t.auth.back,
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );

    return GlassScaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/Logo_dark.png'
                        : 'assets/images/Logo_light.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: 24),

              GlassContainer(
                    padding: const EdgeInsets.all(32),
                    borderRadius: BorderRadius.circular(32),
                    child: formContent,
                  )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 600.ms)
                  .slideY(
                    begin: 0.1,
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.easeOut,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminContent(BuildContext context) {
    return Column(
      children: [
        Icon(
          LucideIcons.graduationCap,
          size: 64,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.8),
        ),
        const SizedBox(height: 24),
        Text(
          t.auth.forgot_password.admin_instructions,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildOnlineContent(BuildContext context, bool isGlass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: t.auth.login.email,
            prefixIcon: const Icon(LucideIcons.mail),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: isGlass,
            fillColor: isGlass ? Colors.white.withValues(alpha: 0.4) : null,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: t.auth.forgot_password.phone_label,
            prefixIcon: const Icon(LucideIcons.phone),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: isGlass,
            fillColor: isGlass ? Colors.white.withValues(alpha: 0.4) : null,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _simulateUpload,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: isGlass
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isIdUploaded
                    ? Colors.green
                    : Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isIdUploaded ? LucideIcons.checkCircle : LucideIcons.upload,
                  size: 32,
                  color: _isIdUploaded
                      ? Colors.green
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 8),
                Text(
                  _isIdUploaded
                      ? t.auth.forgot_password.id_uploaded
                      : t.auth.forgot_password.upload_id,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: _isIdUploaded
                        ? Colors.green
                        : Theme.of(context).primaryColor,
                  ),
                ),
                if (!_isIdUploaded) ...[
                  const SizedBox(height: 4),
                  Text(
                    t.auth.forgot_password.upload_id_hint,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: isGlass ? 0 : 2,
          ),
          child: Text(
            t.auth.login.submit,
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _MethodTab extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _MethodTab({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey.withValues(alpha: 0.8),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
