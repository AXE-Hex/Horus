
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    String email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isNotEmpty && !email.contains('@')) {
      email = '$email@horus.edu.eg';
    }

    if (email.isEmpty || password.isEmpty) {
      _showError(
        t.$meta.locale.languageCode == 'ar'
            ? 'الرجاء إدخال البريد الإلكتروني وكلمة المرور'
            : 'Please enter email and password',
      );
      return;
    }

    setState(() => _isSigningIn = true);

    await ref.read(authControllerProvider.notifier).signIn(email, password);

    if (!mounted) return;

    final authState = ref.read(authControllerProvider);
    if (authState.error != null) {
      _showError(authState.error!);
      setState(() => _isSigningIn = false);
    } else if (authState.isAuthenticated) {

      context.go('/home');
    } else {
      setState(() => _isSigningIn = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    Widget formContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isArabic ? "مرحباً بك مجدداً" : "Welcome Back",
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isArabic
              ? "الرجاء تسجيل الدخول للمتابعة"
              : "Please log in to continue",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 32),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: isArabic ? "البريد الإلكتروني" : "Email",
            hintText: "username",
            helperText: isArabic
                ? "يمكنك كتابة اسم المستخدم فقط (بدون @horus.edu.eg)"
                : "You can enter your username only (without @horus.edu.eg)",
            prefixIcon: const Icon(LucideIcons.mail),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: isGlass,
            fillColor: isGlass ? Colors.white.withValues(alpha: 0.4) : null,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _handleSignIn(),
          decoration: InputDecoration(
            labelText: isArabic ? "كلمة المرور" : "Password",
            prefixIcon: const Icon(LucideIcons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: isGlass,
            fillColor: isGlass ? Colors.white.withValues(alpha: 0.4) : null,
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              context.push('/forgot-password');
            },
            child: Text(
              isArabic ? "هل نسيت كلمة المرور؟" : "Forgot Password?",
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isSigningIn ? null : _handleSignIn,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: isGlass ? 0 : 2,
          ),
          child: _isSigningIn
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  isArabic ? "تسجيل الدخول" : "Sign In",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );

    return GlassScaffold(
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
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                  )
                  .then()
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .moveY(
                    begin: 0,
                    end: -10,
                    duration: 2.seconds,
                    curve: Curves.easeInOut,
                  ),

              const SizedBox(height: 32),

              isGlass
                  ? GlassContainer(
                          padding: const EdgeInsets.all(32),
                          borderRadius: BorderRadius.circular(32),
                          blur: 25,
                          child: formContent,
                        )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideY(
                          begin: 0.1,
                          end: 0,
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        )
                  : Card(
                          elevation: 0,
                          color: Colors.transparent,
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
}
