import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/i18n/strings.g.dart';

class TransitionScreen extends StatefulWidget {
  final String nextPath;
  final VoidCallback? onComplete;
  final String? message;
  final Locale? newLocale;
  final bool isRefresh;

  const TransitionScreen({
    super.key,
    required this.nextPath,
    this.onComplete,
    this.message,
    this.newLocale,
    this.isRefresh = false,
  });

  @override
  State<TransitionScreen> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  Timer? _timer;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(TransitionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.nextPath != widget.nextPath ||
        oldWidget.message != widget.message) {
      _hasTriggered = false;
      _timer?.cancel();
      _startTimer();
    }
  }

  void _startTimer() {
    if (_hasTriggered) return;

    _timer = Timer(const Duration(milliseconds: 1000), () {
      if (mounted && !_hasTriggered) {
        _hasTriggered = true;
        try {
          if (widget.onComplete != null) {
            widget.onComplete!();
          }
        } catch (e) {
          debugPrint('TransitionScreen Error: $e');
        }

        if (mounted) {
          if (widget.isRefresh && context.canPop()) {
            context.pop();
          } else {
            context.go(widget.nextPath);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleSettings.currentLocale == AppLocale.ar;
    return GlassScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/images/Logo_dark.png'
                      : 'assets/images/Logo_light.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                )
                .animate()
                .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                .scale(
                  begin: const Offset(0.9, 0.9),
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
                  duration: 1500.ms,
                  curve: Curves.easeInOut,
                ),
            const SizedBox(height: 48),
            Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).shadowColor.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOut),

            const SizedBox(height: 32),

            Text(
                  widget.message ??
                      (isArabic ? 'الرجاء الانتظار...' : 'Please wait...'),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .moveY(
                  begin: 10,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),

            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
