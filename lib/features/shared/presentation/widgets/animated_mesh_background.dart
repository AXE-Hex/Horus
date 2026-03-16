import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedMeshBackground extends StatelessWidget {
  const AnimatedMeshBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;

    return Stack(
      children: [
        // Base color
        Container(
          color: isDark ? const Color(0xFF0F0F13) : const Color(0xFFF8F9FA),
        ),
        // Animated glowing orbs
        Positioned(
          top: -100,
          right: -50,
          child:
              Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withValues(alpha: isDark ? 0.35 : 0.25),
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.3, 1.3),
                    duration: 4.seconds,
                    curve: Curves.easeInOutSine,
                  ),
        ),
        Positioned(
          bottom: -150,
          left: -100,
          child:
              Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? Colors.blueAccent.withValues(alpha: 0.2)
                          : Colors.blueAccent.withValues(alpha: 0.15),
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(1, 1),
                    duration: 5.seconds,
                    curve: Curves.easeInOutSine,
                  ),
        ),
        // Blur overlay to melt the shapes into gradients
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),
        ),
        // Subtle noise or grid (optional, but a subtle dark tint helps)
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
