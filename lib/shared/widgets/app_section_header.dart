import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'press_feedback.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final String? seeAllText;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
    this.seeAllText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? AppColors.navy400 : AppColors.navy600;

    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.headlineSmall.copyWith(
            color: isDark ? const Color(0xFFF1F5F9) : AppColors.neutral900,
          ),
        ),
        const Spacer(),
        if (onSeeAll != null)
          PressFeedback(
            onTap: onSeeAll,
            hapticType: HapticFeedbackType.light,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                seeAllText ?? 'عرض الكل',
                style: AppTextStyles.labelMedium.copyWith(color: accentColor),
              ),
            ),
          ),
      ],
    );
  }
}
