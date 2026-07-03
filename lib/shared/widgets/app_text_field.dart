import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? suffixText;
  final bool enabled;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.suffixText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final fill = isDark ? const Color(0xFF1E293B) : const Color(0xFFF9FAFB);
    final borderCol = isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB);
    final primaryCol = isDark ? AppColors.navy400 : AppColors.navy600;
    
    final labelColor = isDark ? const Color(0xFF94A3B8) : AppColors.neutral700;
    final hintColor = isDark ? const Color(0xFF6B7280) : AppColors.neutral500;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.labelMedium.copyWith(color: labelColor),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          enabled: enabled,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? const Color(0xFFF1F5F9) : AppColors.neutral900,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: fill,
            hintText: hintText,
            hintStyle: AppTextStyles.bodyMedium.copyWith(color: hintColor),
            prefixIcon: prefixIcon,
            prefixIconColor: primaryCol,
            suffixIcon: suffixIcon,
            suffixIconColor: primaryCol,
            suffixText: suffixText,
            suffixStyle: suffixText != null 
                ? AppTextStyles.bodyMedium.copyWith(color: hintColor) 
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: borderCol, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: borderCol, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: primaryCol, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.danger, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
            ),
            errorStyle: AppTextStyles.labelSmall.copyWith(color: AppColors.danger),
          ),
        ),
      ],
    );
  }
}
