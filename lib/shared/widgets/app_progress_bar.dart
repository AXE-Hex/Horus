import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_animations.dart';

class AppProgressBar extends StatelessWidget {
  final double percentage; // 0.0 to 1.0
  final double height;

  const AppProgressBar({super.key, required this.percentage, this.height = 5.0})
    : assert(percentage >= 0.0 && percentage <= 1.0);

  Color _getProgressColor(double value, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (value >= 0.85) return AppColors.gold500; // Gold = Excellent
    if (value >= 0.70) {
      return isDark ? AppColors.navy400 : AppColors.navy600; // Blue = Good
    }
    if (value >= 0.60) return AppColors.warning; // Amber = Medium
    return AppColors.danger; // Red = Poor
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.navy700 : AppColors.navy100;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xs),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: percentage),
        duration: reduceMotion ? Duration.zero : AppDurations.panel,
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return LinearProgressIndicator(
            value: value,
            minHeight: height,
            backgroundColor: bg,
            valueColor: AlwaysStoppedAnimation(
              _getProgressColor(value, context),
            ),
          );
        },
      ),
    );
  }
}
