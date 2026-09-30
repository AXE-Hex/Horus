import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/app_colors.dart';
import 'package:horus/core/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('themes use Material 3 and Horus light and navy dark surfaces', () {
    GoogleFonts.config.allowRuntimeFetching = false;
    final light = AppTheme.lightTheme;
    final dark = AppTheme.darkTheme;

    expect(light.useMaterial3, isTrue);
    expect(light.scaffoldBackgroundColor, AppColors.lightBackground);
    expect(light.cardTheme.color, AppColors.lightSurface);
    expect(dark.useMaterial3, isTrue);
    expect(dark.scaffoldBackgroundColor, AppColors.darkBackground);
    expect(dark.colorScheme.surface, AppColors.darkSurface);
    expect(dark.colorScheme.secondary, AppColors.gold400);
  });
}
