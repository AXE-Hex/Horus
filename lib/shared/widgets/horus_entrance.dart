import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/theme/app_animations.dart';
import 'package:horus/core/theme/low_performance_provider.dart';

/// A single short opacity transition; no blur, painter, or looping controller.
class HorusEntrance extends ConsumerWidget {
  const HorusEntrance({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = AppMotion.duration(
      context,
      AppDurations.panel,
      lowPerformance: ref.watch(lowPerformanceControllerProvider),
    );
    if (duration == Duration.zero) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      builder: (context, value, child) => Opacity(opacity: value, child: child),
      child: child,
    );
  }
}
