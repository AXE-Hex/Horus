import 'dart:math' as math;
import 'package:flutter/material.dart';

class LiquidBackground extends StatefulWidget {
  final List<Color>? colors;
  final bool showParticles;

  const LiquidBackground({super.key, this.colors, this.showParticles = true});

  @override
  State<LiquidBackground> createState() => _LiquidBackgroundState();
}

class _LiquidBackgroundState extends State<LiquidBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = widget.colors?[0] ?? theme.primaryColor;
    final secondary = widget.colors != null && widget.colors!.length > 1
        ? widget.colors![1]
        : Colors.indigoAccent;
    final tertiary = widget.colors != null && widget.colors!.length > 2
        ? widget.colors![2]
        : Colors.cyanAccent;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LiquidPainter(
              animation: _controller.value,
              primary: primary,
              secondary: secondary,
              tertiary: tertiary,
              isDark: theme.brightness == Brightness.dark,
            ),
            child: widget.showParticles ? const _LiquidParticles() : null,
          );
        },
      ),
    );
  }
}

class _LiquidPainter extends CustomPainter {
  final double animation;
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final bool isDark;

  _LiquidPainter({
    required this.animation,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 1. Solid Base
    final bgPaint = Paint()
      ..color = isDark ? const Color(0xFF020617) : const Color(0xFFF8FAFC);
    canvas.drawRect(rect, bgPaint);

    // 2. Fluid Blobs
    _drawBlob(canvas, size, primary, 0.4, 0.3, 0.6, 1.2, 0.0);
    _drawBlob(canvas, size, secondary, 0.7, 0.8, 0.5, 1.0, 0.3);
    _drawBlob(canvas, size, tertiary, 0.2, 0.7, 0.4, 0.8, 0.6);
    _drawBlob(
      canvas,
      size,
      primary.withValues(alpha: 0.5),
      0.5,
      0.5,
      0.7,
      1.4,
      0.9,
    );

    // 3. Subtle Lighting Overlay
    final overlayPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: isDark ? 0.02 : 0.05),
          Colors.transparent,
          Colors.black.withValues(alpha: isDark ? 0.05 : 0.02),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, overlayPaint);
  }

  void _drawBlob(
    Canvas canvas,
    Size size,
    Color color,
    double xMult,
    double yMult,
    double sizeMult,
    double speed,
    double offset,
  ) {
    final t = (animation + offset) % 1.0;
    final angle = t * 2 * math.pi * speed;

    final x = size.width * (xMult + math.sin(angle) * 0.15);
    final y = size.height * (yMult + math.cos(angle * 0.8) * 0.15);
    final blobSize =
        size.shortestSide * sizeMult * (1.0 + math.sin(angle * 0.5) * 0.1);

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: isDark ? 0.12 : 0.08),
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(x, y), radius: blobSize));

    canvas.drawCircle(Offset(x, y), blobSize, paint);
  }

  @override
  bool shouldRepaint(covariant _LiquidPainter oldDelegate) =>
      oldDelegate.animation != animation ||
      oldDelegate.isDark != isDark ||
      oldDelegate.primary != primary;
}

class _LiquidParticles extends StatefulWidget {
  const _LiquidParticles();

  @override
  State<_LiquidParticles> createState() => _LiquidParticlesState();
}

class _LiquidParticlesState extends State<_LiquidParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = List.generate(25, (_) => _Particle());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(_particles, _controller.value),
        );
      },
    );
  }
}

class _Particle {
  double x = math.Random().nextDouble();
  double y = math.Random().nextDouble();
  double size = math.Random().nextDouble() * 3 + 1;
  double speed = math.Random().nextDouble() * 0.02 + 0.005;
  double opacity = math.Random().nextDouble() * 0.3 + 0.1;
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double animation;

  _ParticlePainter(this.particles, this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var p in particles) {
      final yPos = (p.y - animation * p.speed) % 1.0;
      paint.color = Colors.white.withValues(alpha: p.opacity);
      canvas.drawCircle(
        Offset(p.x * size.width, yPos * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
