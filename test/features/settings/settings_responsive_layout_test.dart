import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_theme.dart';
import 'package:horus/features/settings/presentation/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _EmptyAuthController extends AuthController {
  @override
  AuthState build() => const AuthState();
}

void main() {
  for (final width in [390, 768, 1440]) {
    testWidgets('settings has no layout errors at ${width}px', (tester) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = Size(width.toDouble(), 960);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        TranslationProvider(
          child: ProviderScope(
            overrides: [
              authControllerProvider.overrideWith(_EmptyAuthController.new),
            ],
            child: MaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.dark,
              home: const SettingsScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
      final scroll = tester.renderObject<RenderBox>(
        find.byType(CustomScrollView).first,
      );
      expect(scroll.size.width, lessThanOrEqualTo(width.toDouble()));
      if (width == 1440) {
        expect(scroll.size.width, lessThanOrEqualTo(1080));
      }
    });
  }
}
