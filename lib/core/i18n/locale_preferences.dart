import 'package:shared_preferences/shared_preferences.dart';

import 'strings.g.dart';

abstract final class LocalePreferences {
  static const preferenceKey = 'app_locale';

  static AppLocale resolve({
    String? savedLanguageCode,
    AppLocale? deviceLocale,
  }) {
    final saved = _localeFor(savedLanguageCode);
    if (saved != null) return saved;
    return deviceLocale ?? AppLocale.en;
  }

  static AppLocale? _localeFor(String? languageCode) {
    if (languageCode == null) return null;
    for (final locale in AppLocale.values) {
      if (locale.languageCode == languageCode.toLowerCase()) return locale;
    }
    return null;
  }

  static Future<AppLocale> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(preferenceKey);
    final device = AppLocaleUtils.findDeviceLocale();
    final locale = resolve(savedLanguageCode: saved, deviceLocale: device);
    await LocaleSettings.setLocale(locale, listenToDeviceLocale: false);
    return locale;
  }

  static Future<void> set(AppLocale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(preferenceKey, locale.languageCode);
    await LocaleSettings.setLocale(locale, listenToDeviceLocale: false);
  }
}
