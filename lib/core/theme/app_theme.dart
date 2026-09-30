import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_shadows.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme => _build(Brightness.light);
  static ThemeData get darkTheme => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: dark ? AppColors.navy400 : AppColors.navy600,
      brightness: brightness,
      primary: dark ? AppColors.navy400 : AppColors.navy600,
      onPrimary: dark ? AppColors.navy950 : AppColors.white,
      secondary: dark ? AppColors.gold400 : AppColors.gold600,
      onSecondary: dark ? AppColors.navy950 : AppColors.white,
      surface: dark ? AppColors.darkSurface : AppColors.lightSurface,
      onSurface: dark ? AppColors.neutral100 : AppColors.neutral900,
      error: AppColors.danger,
      onError: AppColors.white,
    );
    final background = dark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final surface = dark ? AppColors.darkSurface : AppColors.lightSurface;
    final elevatedSurface = dark
        ? AppColors.darkSurfaceElevated
        : AppColors.white;
    final outline = dark ? AppColors.navy700 : AppColors.neutral200;
    final text = dark ? AppColors.neutral100 : AppColors.neutral900;
    final mutedText = dark ? AppColors.neutral400 : AppColors.neutral600;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      primaryColor: scheme.primary,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(color: text),
        displayMedium: AppTextStyles.displayMedium.copyWith(color: text),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(color: text),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(color: text),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(color: text),
        titleLarge: AppTextStyles.titleLarge.copyWith(color: text),
        titleMedium: AppTextStyles.titleMedium.copyWith(color: text),
        titleSmall: AppTextStyles.titleSmall.copyWith(color: text),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: text),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: mutedText),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: mutedText),
        labelLarge: AppTextStyles.labelLarge.copyWith(color: text),
        labelMedium: AppTextStyles.labelMedium.copyWith(color: mutedText),
        labelSmall: AppTextStyles.labelSmall.copyWith(color: mutedText),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: text, size: 22),
        titleTextStyle: AppTextStyles.titleLarge.copyWith(color: text),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: BorderSide(color: outline),
        ),
      ),
      dividerTheme: DividerThemeData(color: outline, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: elevatedSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        labelStyle: AppTextStyles.labelMedium.copyWith(color: mutedText),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: mutedText),
        prefixIconColor: mutedText,
        suffixIconColor: mutedText,
        border: _inputBorder(outline),
        enabledBorder: _inputBorder(outline),
        focusedBorder: _inputBorder(scheme.primary, width: 1.5),
        errorBorder: _inputBorder(scheme.error),
        focusedErrorBorder: _inputBorder(scheme.error, width: 1.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(44, 48),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          shape: shape,
          elevation: 0,
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(44, 48),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          side: BorderSide(color: outline),
          shape: shape,
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(44, 44),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: dark ? AppColors.navy800 : AppColors.navy100,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => AppTextStyles.labelSmall.copyWith(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : mutedText,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : mutedText,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        indicatorColor: dark ? AppColors.navy800 : AppColors.navy100,
        selectedIconTheme: IconThemeData(color: scheme.primary),
        unselectedIconTheme: IconThemeData(color: mutedText),
        selectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
          color: scheme.primary,
        ),
        unselectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
          color: mutedText,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        titleTextStyle: AppTextStyles.titleLarge.copyWith(color: text),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: mutedText),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: dark ? AppColors.navy800 : AppColors.neutral900,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : Colors.transparent,
        ),
        side: BorderSide(color: mutedText),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(scheme.primary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.white
              : mutedText,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? scheme.primary : outline,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: dark ? AppColors.navy700 : AppColors.navy100,
        circularTrackColor: dark ? AppColors.navy700 : AppColors.navy100,
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: AppTextStyles.labelLarge.copyWith(color: text),
        dataTextStyle: AppTextStyles.bodyMedium.copyWith(color: text),
        dividerThickness: 1,
        decoration: BoxDecoration(color: surface),
      ),
      extensions: [AppElevationTheme(dark: dark)],
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(color: color, width: width),
      );
}

@immutable
class AppElevationTheme extends ThemeExtension<AppElevationTheme> {
  const AppElevationTheme({required this.dark});
  final bool dark;

  List<BoxShadow> level(int value) => AppShadows.forLevel(value, dark: dark);

  @override
  AppElevationTheme copyWith({bool? dark}) =>
      AppElevationTheme(dark: dark ?? this.dark);

  @override
  AppElevationTheme lerp(covariant AppElevationTheme? other, double t) =>
      AppElevationTheme(dark: t < .5 ? dark : other?.dark ?? dark);
}
