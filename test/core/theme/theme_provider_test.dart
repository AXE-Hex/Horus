import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/theme/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('unrecognized or absent theme preference resolves to System', () async {
    SharedPreferences.setMockInitialValues({'theme_mode': 'style'});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      await container.read(themeControllerProvider.future),
      ThemeMode.system,
    );
  });

  test(
    'saved Light and Dark preferences restore and can change to System',
    () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        await container.read(themeControllerProvider.future),
        ThemeMode.dark,
      );
      await container
          .read(themeControllerProvider.notifier)
          .setTheme(ThemeMode.light);
      expect(container.read(themeControllerProvider).value, ThemeMode.light);

      await container
          .read(themeControllerProvider.notifier)
          .setTheme(ThemeMode.system);
      expect(container.read(themeControllerProvider).value, ThemeMode.system);
    },
  );
}
