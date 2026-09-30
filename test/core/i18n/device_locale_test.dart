import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/i18n/locale_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'device language selects supported locale and falls back to English',
    (tester) async {
      tester.binding.platformDispatcher.localeTestValue = const Locale(
        'ar',
        'EG',
      );
      expect(AppLocaleUtils.findDeviceLocale(), AppLocale.ar);

      tester.binding.platformDispatcher.localeTestValue = const Locale(
        'fr',
        'FR',
      );
      expect(AppLocaleUtils.findDeviceLocale(), AppLocale.en);

      expect(
        LocalePreferences.resolve(
          savedLanguageCode: null,
          deviceLocale: AppLocale.ar,
        ),
        AppLocale.ar,
      );
      expect(
        LocalePreferences.resolve(
          savedLanguageCode: null,
          deviceLocale: AppLocale.en,
        ),
        AppLocale.en,
      );
      expect(
        LocalePreferences.resolve(
          savedLanguageCode: 'de',
          deviceLocale: AppLocale.ar,
        ),
        AppLocale.de,
      );
      expect(
        LocalePreferences.resolve(
          savedLanguageCode: 'unsupported',
          deviceLocale: AppLocale.ar,
        ),
        AppLocale.ar,
      );

      tester.binding.platformDispatcher.clearLocaleTestValue();
    },
  );

  test('saved language is restored before device locale fallback', () async {
    SharedPreferences.setMockInitialValues({'app_locale': 'ar'});
    final locale = await LocalePreferences.initialize();
    expect(locale, AppLocale.ar);
    expect(LocaleSettings.currentLocale, AppLocale.ar);
  });

  testWidgets('Arabic uses RTL and English uses LTR directionality', (
    tester,
  ) async {
    TextDirection? direction;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: Builder(
          builder: (context) {
            direction = Directionality.of(context);
            return const SizedBox();
          },
        ),
      ),
    );
    expect(direction, TextDirection.rtl);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: Builder(
          builder: (context) {
            direction = Directionality.of(context);
            return const SizedBox();
          },
        ),
      ),
    );
    expect(direction, TextDirection.ltr);
  });
}
