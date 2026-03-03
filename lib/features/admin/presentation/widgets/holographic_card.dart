import 'package:flutter/material.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';

class HolographicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? glowColor;
  final double depth;
  final VoidCallback? onTap;

  const HolographicCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.glowColor,
    this.depth = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = glowColor ?? Theme.of(context).primaryColor;
    final radius = borderRadius ?? BorderRadius.circular(24);

    return MouseRegion(
      cursor: onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            // Outer Glow (The "Aura")
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                borderRadius: radius,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.15 * depth),
                    blurRadius: 25 * depth,
                    spreadRadius: -2,
                  ),
                ],
              ),
            ),

            // The Glass Panel
            GlassContainer(
              borderRadius: radius,
              padding: padding ?? const EdgeInsets.all(20),
              child: Stack(
                children: [
                  // Inner Holographic Scan-lines or Texture could go here
                  child,

                  // Top Highlight Edge
                  Positioned(
                    top: 0,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
