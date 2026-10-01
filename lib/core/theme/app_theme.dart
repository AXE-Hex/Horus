import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.navy600,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.navy600,
        onPrimary: AppColors.white,
        secondary: AppColors.navy400,
        onSecondary: AppColors.white,
        surface: AppColors.neutral050,
        onSurface: AppColors.neutral900,
        error: AppColors.danger,
        onError: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.neutral900,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.neutral900, size: 18),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.neutral900,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: AppBorders.standard,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.neutral200,
        thickness: 0.5,
        space: 0.5,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.neutral050,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: AppColors.neutral500,
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.neutral400,
        ),
        prefixIconColor: AppColors.navy600,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.neutral200, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.neutral200, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.navy600, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy600,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          elevation: 0,
          textStyle: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.navy600,
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: Color(0xFFCDD7EF), width: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(
            color: AppColors.navy600,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,
        elevation: 0,
        indicatorColor: AppColors.navy100,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyles.labelSmall.copyWith(color: AppColors.navy600);
          }
          return AppTextStyles.labelSmall.copyWith(color: AppColors.neutral500);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.navy600);
          }
          return const IconThemeData(color: AppColors.neutral400);
        }),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: AppColors.neutral900,
        ),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          color: AppColors.neutral900,
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.neutral900,
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.neutral900,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.neutral700,
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.neutral700,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          color: AppColors.neutral500,
        ),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          color: AppColors.neutral700,
        ),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          color: AppColors.neutral500,
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(
          color: AppColors.neutral500,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor:
          AppColors.navy400, // In dark mode, primary is navy-400 (#3A6BC4)
      scaffoldBackgroundColor: const Color(0xFF0F172A), // Dark mode background
      colorScheme: const ColorScheme.dark(
        primary: AppColors.navy400,
        onPrimary: AppColors.navy950,
        secondary: AppColors.navy500,
        onSecondary: AppColors.white,
        surface: Color(0xFF1E293B),
        onSurface: Color(0xFFF1F5F9),
        error: AppColors.danger,
        onError: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: const Color(0xFFF1F5F9),
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFF1F5F9), size: 18),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: const Color(0xFFF1F5F9),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: const BorderSide(color: Color(0xFF334155), width: 0.5),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF334155),
        thickness: 0.5,
        space: 0.5,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E293B),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: const Color(0xFF94A3B8),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: const Color(0xFF6B7280),
        ),
        prefixIconColor: AppColors.navy400,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: Color(0xFF334155), width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: Color(0xFF334155), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.navy400, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy400,
          foregroundColor: AppColors.navy950,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          elevation: 0,
          textStyle: AppTextStyles.labelLarge.copyWith(
            color: AppColors.navy950,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.navy400,
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: Color(0xFF334155), width: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(
            color: AppColors.navy400,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        indicatorColor: const Color(0xFF1E2A45),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyles.labelSmall.copyWith(color: AppColors.navy400);
          }
          return AppTextStyles.labelSmall.copyWith(
            color: const Color(0xFF94A3B8),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.navy400);
          }
          return const IconThemeData(color: Color(0xFF94A3B8));
        }),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: const Color(0xFFF1F5F9),
        ),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          color: const Color(0xFFF1F5F9),
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: const Color(0xFFF1F5F9),
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          color: const Color(0xFFF1F5F9),
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          color: const Color(0xFFCBD5E1),
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: const Color(0xFFCBD5E1),
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          color: const Color(0xFF94A3B8),
        ),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          color: const Color(0xFFCBD5E1),
        ),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          color: const Color(0xFF94A3B8),
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(
          color: const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
