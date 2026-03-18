import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _obscurePassword = true;
  bool _isSigningIn = false;

  late final AnimationController _orbController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _orbController.dispose();
    _pulseController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    String email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showError(
        t.$meta.locale.languageCode == 'ar'
            ? 'الرجاء إدخال البريد الإلكتروني وكلمة المرور'
            : 'Please enter email and password',
      );
      return;
    }

    if (email.contains('@')) {
      _showError(
        t.$meta.locale.languageCode == 'ar'
            ? 'الرجاء إدخال الجزء الأول فقط بدون @horus.edu.eg'
            : 'Please enter prefix only (no @horus.edu.eg)',
      );
      return;
    }

    email = '$email@horus.edu.eg';

    setState(() => _isSigningIn = true);
    HapticFeedback.mediumImpact();

    await ref.read(authControllerProvider.notifier).signIn(email, password);

    if (!mounted) return;

    final authState = ref.read(authControllerProvider);
    if (authState.error != null) {
      _showError(authState.error!);
      setState(() => _isSigningIn = false);
      HapticFeedback.heavyImpact();
    } else if (authState.isAuthenticated) {
      HapticFeedback.lightImpact();
      context.go('/home');
    } else {
      setState(() => _isSigningIn = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                LucideIcons.alertTriangle,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFDC2626),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(20),
        elevation: 12,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          const Color(0xFF030712),
                          const Color(0xFF0F172A),
                          const Color(0xFF020617),
                        ]
                      : [
                          const Color(0xFFF8FAFC),
                          const Color(0xFFEFF6FF),
                          const Color(0xFFF1F5F9),
                        ],
                ),
              ),
            ),

            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _orbController,
                builder: (context, child) {
                  return CustomPaint(
                    size: size,
                    painter: _OrbsPainter(
                      t: _orbController.value,
                      primary: theme.primaryColor,
                      isDark: isDark,
                    ),
                  );
                },
              ),
            ),

            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                color:
                    (isDark ? const Color(0xFF030712) : const Color(0xFFF8FAFC))
                        .withValues(alpha: isDark ? 0.5 : 0.35),
              ),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width > 600 ? size.width * 0.2 : 28,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLogo(theme, isDark),
                      const SizedBox(height: 16),

                      Text(
                        t.students.horus_university,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                          color: theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ).animate().fadeIn(delay: 400.ms, duration: 800.ms),

                      const SizedBox(height: 48),

                      _buildLoginCard(theme, isDark, isArabic),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(ThemeData theme, bool isDark) {
    return AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            final glow = 0.08 + (_pulseController.value * 0.07);
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: glow),
                    blurRadius: 60,
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: child,
            );
          },
          child: Hero(
            tag: 'app_logo',
            child: Image.asset(
              isDark
                  ? 'assets/images/Logo_dark.png'
                  : 'assets/images/Logo_light.png',
              width: 110,
              height: 110,
              fit: BoxFit.contain,
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 1000.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.7, 0.7),
          end: const Offset(1, 1),
          duration: 1000.ms,
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildLoginCard(ThemeData theme, bool isDark, bool isArabic) {
    return ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color:
                    (isDark ? const Color(0xFF1E293B) : const Color(0xFFFFFFFF))
                        .withValues(alpha: isDark ? 0.45 : 0.7),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: (isDark ? Colors.white : Colors.black).withValues(
                    alpha: isDark ? 0.08 : 0.06,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.06),
                    blurRadius: 48,
                    spreadRadius: -8,
                    offset: const Offset(0, 24),
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
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: theme.textTheme.displayLarge?.color,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.15, end: 0),

                  const SizedBox(height: 8),

                  Text(
                    t.auth.login.subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.textTheme.bodyMedium?.color?.withValues(
                        alpha: 0.5,
                      ),
                      height: 1.4,
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.15, end: 0),

                  const SizedBox(height: 36),

                  _buildTextField(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        label: t.auth.login.email,
                        icon: LucideIcons.atSign,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => _passwordFocus.requestFocus(),
                        isDark: isDark,
                        theme: theme,
                        suffixText: '@horus.edu.eg',
                      )
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slideX(begin: isArabic ? 0.08 : -0.08, end: 0),

                  const SizedBox(height: 16),

                  _buildTextField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        label: t.auth.login.password,
                        icon: LucideIcons.keyRound,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _handleSignIn(),
                        isDark: isDark,
                        theme: theme,
                        suffixWidget: GestureDetector(
                          onTap: () {
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                            HapticFeedback.selectionClick();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.05,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _obscurePassword
                                  ? LucideIcons.eye
                                  : LucideIcons.eyeOff,
                              color: theme.iconTheme.color?.withValues(
                                alpha: 0.4,
                              ),
                              size: 18,
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 500.ms)
                      .slideX(begin: isArabic ? -0.08 : 0.08, end: 0),

                  const SizedBox(height: 12),

                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        context.push('/forgot-password');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        t.auth.login.forgot_password,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms),

                  const SizedBox(height: 24),

                  _buildSignInButton(theme),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 100.ms, duration: 900.ms)
        .slideY(
          begin: 0.04,
          end: 0,
          duration: 900.ms,
          curve: Curves.easeOutCirc,
        );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
    required ThemeData theme,
    required bool isDark,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.done,
    void Function(String)? onSubmitted,
    Widget? suffixWidget,
    String? suffixText,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: theme.colorScheme.onSurface.withValues(alpha: 0.04),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.07),
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onFieldSubmitted: onSubmitted,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: theme.textTheme.bodyLarge?.color,
          fontSize: 15,
        ),
        cursorColor: theme.primaryColor,
        cursorRadius: const Radius.circular(2),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.outfit(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.45),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          floatingLabelStyle: GoogleFonts.outfit(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.primaryColor.withValues(alpha: 0.12),
                  theme.primaryColor.withValues(alpha: 0.06),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.primaryColor, size: 18),
          ),
          suffixText: suffixText,
          suffixStyle: suffixText != null
              ? GoogleFonts.inter(
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.35,
                  ),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                )
              : null,
          suffixIcon: suffixWidget,
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
              color: theme.primaryColor.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(ThemeData theme) {
    return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                theme.primaryColor,
                HSLColor.fromColor(
                  theme.primaryColor,
                ).withLightness(0.5).toColor(),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: 0.35),
                blurRadius: 28,
                spreadRadius: -6,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isSigningIn ? null : _handleSignIn,
              borderRadius: BorderRadius.circular(18),
              splashColor: Colors.white.withValues(alpha: 0.15),
              highlightColor: Colors.transparent,
              child: Center(
                child: _isSigningIn
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.auth.login.submit,
                            style: GoogleFonts.outfit(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              LucideIcons.arrowRight,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 700.ms)
        .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutBack);
  }
}

class _OrbsPainter extends CustomPainter {
  final double t;
  final Color primary;
  final bool isDark;

  _OrbsPainter({required this.t, required this.primary, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final angle = t * 2 * math.pi;

    _paintOrb(
      canvas,
      center: Offset(
        w * 0.3 + math.cos(angle) * w * 0.35,
        h * 0.25 + math.sin(angle * 0.7) * h * 0.25,
      ),
      radius: w * 0.8,
      color: primary.withValues(alpha: isDark ? 0.18 : 0.10),
    );

    _paintOrb(
      canvas,
      center: Offset(
        w * 0.8 + math.sin(angle * 1.3) * w * 0.4,
        h * 0.7 + math.cos(angle * 0.9) * h * 0.3,
      ),
      radius: w * 0.9,
      color: (isDark ? const Color(0xFF7C3AED) : const Color(0xFF8B5CF6))
          .withValues(alpha: isDark ? 0.12 : 0.07),
    );

    _paintOrb(
      canvas,
      center: Offset(
        w * 0.6 + math.cos(angle * 1.7) * w * 0.3,
        h * 0.5 + math.sin(angle * 1.1) * h * 0.4,
      ),
      radius: w * 0.7,
      color: (isDark ? const Color(0xFF059669) : const Color(0xFF34D399))
          .withValues(alpha: isDark ? 0.10 : 0.06),
    );
  }

  void _paintOrb(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required Color color,
  }) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color,
          color.withValues(alpha: color.a * 0.5),
          color.withValues(alpha: 0),
        ],
        stops: const [0.0, 0.35, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _OrbsPainter old) =>
      old.t != t || old.isDark != isDark || old.primary != primary;
}
