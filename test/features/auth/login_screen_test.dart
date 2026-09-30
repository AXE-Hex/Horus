import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_theme.dart';
import 'package:horus/features/auth/presentation/screens/login_screen.dart';

class LoginFixtureAuth extends AuthController {
  @override
  AuthState build() => const AuthState();
}

void main() {
  testWidgets('login shows university domain for a username only', (
    tester,
  ) async {
    LocaleSettings.setLocale(AppLocale.en);
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            authControllerProvider.overrideWith(LoginFixtureAuth.new),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const LoginScreen(),
          ),
        ),
      ),
    );

    final emailFormField = find.byType(TextFormField).first;
    final emailField = find.byType(TextField).first;
    expect(
      tester.widget<TextField>(emailField).decoration?.suffixText,
      '@horus.edu.eg',
    );

    await tester.enterText(emailFormField, 'student.dev');
    await tester.pump();
    expect(
      tester.widget<TextField>(emailField).decoration?.suffixText,
      '@horus.edu.eg',
    );

    await tester.enterText(emailFormField, 'student.dev@horus.edu.eg');
    await tester.pump();
    expect(tester.widget<TextField>(emailField).decoration?.suffixText, isNull);
  });
}
