import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/router/route_guard.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_colors.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/shared/widgets/app_button.dart';
import 'package:horus/shared/widgets/app_card.dart';
import 'package:horus/shared/widgets/app_text_field.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _obscurePassword = true;
  bool _isSigningIn = false;
  bool _showUniversityDomain = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      _showError(t.auth.login.required_fields);
      return;
    }
    if (!isUniversityEmail(email)) {
      _showError(t.auth.login.invalid_email);
      return;
    }

    setState(() => _isSigningIn = true);
    HapticFeedback.mediumImpact();
    await ref.read(authControllerProvider.notifier).signIn(email, password);
    if (!mounted) return;

    final authState = ref.read(authControllerProvider);
    if (authState.error != null) {
      _showError(_authErrorMessage(authState.error!));
      setState(() => _isSigningIn = false);
      HapticFeedback.heavyImpact();
    } else if (authState.isAuthenticated) {
      HapticFeedback.lightImpact();
      context.go(resolveInitialDestination(authState));
    } else {
      setState(() => _isSigningIn = false);
    }
  }

  String _authErrorMessage(String code) => switch (code) {
    'invalid_university_email' => t.auth.login.invalid_email,
    'sign_in_failed' => t.auth.login.sign_in_failed,
    _ => t.auth.login.sign_in_failed,
  };

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: wide
            ? Row(
                children: [
                  Expanded(flex: 5, child: _campusPanel(context)),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppSpacing.xxxl),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 460),
                          child: _loginForm(context, isDark),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.xxxl,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: _loginForm(context, isDark),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _campusPanel(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      Image.asset('assets/images/HUE1.jpg', fit: BoxFit.cover),
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x6610213A), Color(0xF007111F)],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/Logo_dark.png',
              width: 190,
              height: 92,
              fit: BoxFit.contain,
              alignment: AlignmentDirectional.centerStart,
            ),
            const Spacer(),
            Text(
              t.students.horus_university,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 48,
              height: 3,
              decoration: const BoxDecoration(
                color: AppColors.gold400,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _loginForm(BuildContext context, bool isDark) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if (MediaQuery.sizeOf(context).width < 900)
        Center(
          child: Image.asset(
            isDark
                ? 'assets/images/Logo_dark.png'
                : 'assets/images/Logo_light.png',
            width: 190,
            height: 92,
            fit: BoxFit.contain,
          ),
        ),
      const SizedBox(height: AppSpacing.xl),
      Text(
        t.auth.login.welcome,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: AppSpacing.xs),
      Text(
        t.auth.login.subtitle,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const SizedBox(height: AppSpacing.xxl),
      AppCard(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _emailController,
              focusNode: _emailFocus,
              label: t.auth.login.email,
              prefixIcon: const Icon(LucideIcons.atSign),
              keyboardType: TextInputType.emailAddress,
              hintText: t.auth.login.email_hint,
              suffixText: _showUniversityDomain ? '@horus.edu.eg' : null,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                final showDomain = !value.contains('@');
                if (showDomain != _showUniversityDomain) {
                  setState(() => _showUniversityDomain = showDomain);
                }
              },
              onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              label: t.auth.login.password,
              prefixIcon: const Icon(LucideIcons.keyRound),
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleSignIn(),
              suffixIcon: IconButton(
                tooltip: t.$meta.locale.languageCode == 'ar'
                    ? (_obscurePassword
                          ? 'إظهار كلمة المرور'
                          : 'إخفاء كلمة المرور')
                    : (_obscurePassword ? 'Show password' : 'Hide password'),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(
                  _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => context.push('/forgot-password'),
                child: Text(t.auth.login.forgot_password),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: t.auth.login.submit,
              onPressed: _handleSignIn,
              isLoading: _isSigningIn,
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.md),
      TextButton(
        onPressed: () => context.push('/guest-registration'),
        child: Text(t.auth.guest_registration.title),
      ),
    ],
  );
}
