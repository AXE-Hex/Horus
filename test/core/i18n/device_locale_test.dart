import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/i18n/strings.g.dart';

void main() {
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

      tester.binding.platformDispatcher.clearLocaleTestValue();
    },
  );
}
