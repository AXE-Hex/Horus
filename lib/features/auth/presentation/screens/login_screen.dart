import 'dart:math' as math;
import 'dart:ui';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSigningIn = false;

  late final AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
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
        content: Text(
          message,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.redAccent.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(20),
        elevation: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Immersive Animated Mesh Background
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return CustomPaint(
                painter: _MeshGradientPainter(
                  animationValue: _bgController.value,
                  primaryColor: theme.primaryColor,
                  isDark: isDark,
                  backgroundColor: theme.scaffoldBackgroundColor,
                ),
              );
            },
          ),

          // 2. Extra blur layer for the glass effect over the mesh
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              color: (isDark ? Colors.black : Colors.white).withValues(
                alpha: 0.1,
              ),
            ),
          ),

          // 3. Foreground Content (Logo & Form)
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 40.0,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          constraints.maxHeight -
                          80, // Account for vertical padding
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Top Area: Logo
                        Column(
                          children: [
                            const SizedBox(height: 40),
                            Hero(
                                  tag: 'app_logo',
                                  child: Image.asset(
                                    isDark
                                        ? 'assets/images/Logo_dark.png'
                                        : 'assets/images/Logo_light.png',
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.contain,
                                  ),
                                )
                                .animate()
                                .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  curve: Curves.easeOutBack,
                                  duration: 800.ms,
                                )
                                .then()
                                .animate(onPlay: (c) => c.repeat(reverse: true))
                                .moveY(
                                  begin: 0,
                                  end: -8,
                                  duration: 3.seconds,
                                  curve: Curves.easeInOut,
                                ),
                          ],
                        ),

                        // Bottom Area: Login Form
                        Container(
                              margin: const EdgeInsets.only(top: 40),
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: (isDark ? Colors.black : Colors.white)
                                    .withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 30,
                                    spreadRadius: -5,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                        t.auth.login.welcome,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.outfit(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w900,
                                          color: theme
                                              .textTheme
                                              .displayLarge
                                              ?.color,
                                          letterSpacing: -0.5,
                                        ),
                                      )
                                      .animate()
                                      .fadeIn(delay: 200.ms)
                                      .slideY(begin: 0.2, end: 0),

                                  const SizedBox(height: 8),

                                  Text(
                                        t.auth.login.subtitle,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: theme
                                              .textTheme
                                              .bodyMedium
                                              ?.color
                                              ?.withValues(alpha: 0.6),
                                        ),
                                      )
                                      .animate()
                                      .fadeIn(delay: 300.ms)
                                      .slideY(begin: 0.2, end: 0),

                                  const SizedBox(height: 40),

                                  // Email Field
                                  _buildGlassTextField(
                                        controller: _emailController,
                                        labelText: t.auth.login.email,
                                        icon: LucideIcons.mail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        isDark: isDark,
                                      )
                                      .animate()
                                      .fadeIn(delay: 400.ms)
                                      .slideX(begin: -0.1, end: 0),

                                  const SizedBox(height: 20),

                                  // Password Field
                                  _buildGlassTextField(
                                        controller: _passwordController,
                                        labelText: t.auth.login.password,
                                        icon: LucideIcons.lock,
                                        obscureText: _obscurePassword,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (_) =>
                                            _handleSignIn(),
                                        isDark: isDark,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? LucideIcons.eye
                                                : LucideIcons.eyeOff,
                                            color: theme.iconTheme.color
                                                ?.withValues(alpha: 0.6),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                      )
                                      .animate()
                                      .fadeIn(delay: 500.ms)
                                      .slideX(begin: 0.1, end: 0),

                                  const SizedBox(height: 16),

                                  // Forgot Password Link
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: TextButton(
                                      onPressed: () =>
                                          context.push('/forgot-password'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: theme.primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        t.auth.login.forgot_password,
                                        style: GoogleFonts.outfit(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ).animate().fadeIn(delay: 600.ms),

                                  const SizedBox(height: 32),

                                  // Submit Button
                                  _buildMainButton(theme),

                                  const SizedBox(height: 24),

                                  // Guest Login Button
                                  _buildGuestButton(theme),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 100.ms, duration: 800.ms)
                            .slideY(
                              begin: 0.1,
                              end: 0,
                              duration: 800.ms,
                              curve: Curves.easeOutCirc,
                            ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.done,
    void Function(String)? onFieldSubmitted,
    Widget? suffixIcon,
    required bool isDark,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white : Colors.black87,
      ),
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.outfit(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: GoogleFonts.outfit(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(
          icon,
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
          size: 20,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: (isDark ? Colors.white : Colors.black).withValues(
          alpha: 0.05,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: (isDark ? Colors.white : Colors.black).withValues(
              alpha: 0.1,
            ),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: (isDark ? Colors.white : Colors.black).withValues(
              alpha: 0.1,
            ),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
      ),
    );
  }

  Widget _buildMainButton(ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            HSLColor.fromColor(theme.primaryColor).withLightness(0.6).toColor(),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.4),
            blurRadius: 20,
            spreadRadius: -5,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isSigningIn ? null : _handleSignIn,
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white.withValues(alpha: 0.2),
          child: Center(
            child: _isSigningIn
                ? const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.auth.login.submit,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        LucideIcons.arrowRight,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms).scale(curve: Curves.easeOutBack);
  }

  Widget _buildGuestButton(ThemeData theme) {
    return TextButton(
      onPressed: _isSigningIn
          ? null
          : () {
              context.go('/home'); // Default guest action
            },
      style: TextButton.styleFrom(
        foregroundColor: theme.textTheme.bodyMedium?.color?.withValues(
          alpha: 0.8,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
      ),
      child: Text(
        t.auth.login.guest,
        style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}

/// A custom painter that draws a slow-moving, glowing mesh gradient background.
class _MeshGradientPainter extends CustomPainter {
  final double animationValue;
  final Color primaryColor;
  final bool isDark;
  final Color backgroundColor;

  _MeshGradientPainter({
    required this.animationValue,
    required this.primaryColor,
    required this.isDark,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Fill base background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    final width = size.width;
    final height = size.height;

    // Create a few dynamic glowing blobs that move in a figure-8 or circle
    _drawBlob(
      canvas,
      center: Offset(
        width * 0.5 + math.cos(animationValue * 2 * math.pi) * width * 0.3,
        height * 0.3 + math.sin(animationValue * 2 * math.pi) * height * 0.2,
      ),
      radius: width * 0.8,
      color: primaryColor.withValues(alpha: isDark ? 0.15 : 0.1),
    );

    _drawBlob(
      canvas,
      center: Offset(
        width * 0.2 + math.sin(animationValue * 2 * math.pi) * width * 0.4,
        height * 0.8 + math.cos(animationValue * 2 * math.pi) * height * 0.3,
      ),
      radius: width * 0.9,
      color: Colors.purpleAccent.withValues(alpha: isDark ? 0.12 : 0.08),
    );

    _drawBlob(
      canvas,
      center: Offset(
        width * 0.8 + math.cos(animationValue * 4 * math.pi) * width * 0.2,
        height * 0.6 + math.sin(animationValue * 2 * math.pi) * height * 0.4,
      ),
      radius: width * 0.7,
      color: Colors.blueAccent.withValues(alpha: isDark ? 0.12 : 0.08),
    );
  }

  void _drawBlob(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required Color color,
  }) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color,
          color.withValues(alpha: 0.5),
          color.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _MeshGradientPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isDark != isDark ||
        oldDelegate.primaryColor != primaryColor;
  }
}
