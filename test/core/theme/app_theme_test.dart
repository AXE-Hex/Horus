import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/app_colors.dart';
import 'package:horus/core/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('themes preserve pre-EDIT light and dark palette', () {
    GoogleFonts.config.allowRuntimeFetching = false;
    final light = AppTheme.lightTheme;
    final dark = AppTheme.darkTheme;

    expect(light.useMaterial3, isTrue);
    expect(light.scaffoldBackgroundColor, AppColors.white);
    expect(light.cardTheme.color, AppColors.white);
    expect(dark.useMaterial3, isTrue);
    expect(dark.scaffoldBackgroundColor, const Color(0xFF0F172A));
    expect(dark.colorScheme.surface, const Color(0xFF1E293B));
    expect(dark.colorScheme.secondary, AppColors.navy500);
  });
}
