import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/theme/low_performance_provider.dart';

class AnimatedMeshBackground extends ConsumerWidget {
  const AnimatedMeshBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;
    final isLowPerformance = ref.watch(lowPerformanceControllerProvider);

    // In low performance mode, render a static gradient for 0% CPU/GPU overhead
    if (isLowPerformance) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0F0F13),
                    primary.withValues(alpha: 0.1),
                    Colors.blueAccent.withValues(alpha: 0.05),
                    const Color(0xFF0F0F13),
                  ]
                : [
                    const Color(0xFFF8F9FA),
                    primary.withValues(alpha: 0.08),
                    Colors.blueAccent.withValues(alpha: 0.05),
                    const Color(0xFFF8F9FA),
                  ],
          ),
        ),
      );
    }

    Widget circle1 = Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primary.withValues(alpha: isDark ? 0.35 : 0.25),
      ),
    );

    Widget circle2 = Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? Colors.blueAccent.withValues(alpha: 0.2)
            : Colors.blueAccent.withValues(alpha: 0.15),
      ),
    );

    // Apply animation only in normal mode
    circle1 = circle1
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.2, 1.2),
          duration: 6.seconds, // Slower duration reduces layout/paint triggers
          curve: Curves.easeInOutSine,
        );

    circle2 = circle2
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(1.15, 1.15),
          end: const Offset(1, 1),
          duration: 7.seconds,
          curve: Curves.easeInOutSine,
        );

    return Stack(
      children: [
        Container(
          color: isDark ? const Color(0xFF0F0F13) : const Color(0xFFF8F9FA),
        ),
        Positioned(
          top: -100,
          right: -50,
          child: circle1,
        ),
        Positioned(
          bottom: -150,
          left: -100,
          child: circle2,
        ),
        Positioned.fill(
          child: BackdropFilter(
            // Reduced blur slightly from 80 to 50 for noticeably better render performance
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }
}
