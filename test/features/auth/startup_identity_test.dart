import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/models/profile_model.dart';
import 'package:horus/core/theme/app_theme.dart';
import 'package:horus/features/splash/presentation/screens/splash_screen.dart';
import 'package:horus/features/students/presentation/screens/digital_id_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;

class FixtureAuth extends AuthController {
  FixtureAuth(this.fixture);
  final AuthState fixture;
  @override
  AuthState build() => fixture;
}

AuthState fixtureAuth({
  UserRole role = UserRole.student,
  Set<String> permissions = const {'grades.read'},
  bool banned = false,
  String? studentId,
}) => AuthState(
  user: User(
    id: 'fixture-user',
    appMetadata: {},
    userMetadata: {},
    aud: 'authenticated',
    createdAt: '2026-01-01T00:00:00Z',
  ),
  profile: ProfileModel(
    id: 'fixture-user',
    email: 'fixture@example.invalid',
    fullName: 'Test Identity Fixture',
    fullNameAr: 'هوية الاختبار',
    roles: [role],
    isActive: true,
    isBanned: banned,
    studentId: studentId,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  ),
  permissionCodes: permissions,
);

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));
  for (final scenario in <(String, AuthState, String)>[
    ('signed out', const AuthState(), '/welcome'),
    ('student', fixtureAuth(), '/dashboard'),
    (
      'professor',
      fixtureAuth(role: UserRole.professor, permissions: {'grades.manage'}),
      '/professor-dashboard',
    ),
    (
      'dean',
      fixtureAuth(role: UserRole.dean, permissions: {'courses.manage'}),
      '/control',
    ),
    (
      'rector',
      fixtureAuth(role: UserRole.rector, permissions: {'courses.manage'}),
      '/control',
    ),
    (
      'guest',
      fixtureAuth(role: UserRole.guest, permissions: {}),
      '/access-pending',
    ),
    ('banned', fixtureAuth(banned: true), '/access-pending'),
  ]) {
    testWidgets('pre-EDIT startup routes ${scenario.$1}', (tester) async {
      LocaleSettings.setLocale(AppLocale.en);
      final router = GoRouter(
        initialLocation: '/splash',
        routes: [
          GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
          for (final route in [
            '/login',
            '/welcome',
            '/dashboard',
            '/professor-dashboard',
            '/control',
            '/access-pending',
          ])
            GoRoute(
              path: route,
              builder: (_, _) => Scaffold(body: Text(route)),
            ),
        ],
      );
      await tester.pumpWidget(
        TranslationProvider(
          child: ProviderScope(
            overrides: [
              authControllerProvider.overrideWith(
                () => FixtureAuth(scenario.$2),
              ),
            ],
            child: MaterialApp.router(routerConfig: router),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(SplashScreen), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));
      expect(find.text(scenario.$3), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      router.dispose();
    });
  }

  for (final locale in [AppLocale.en, AppLocale.ar]) {
    testWidgets(
      'real identity fits 320px with large text in ${locale.languageCode}',
      (tester) async {
        tester.view.physicalSize = const Size(320, 900);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        LocaleSettings.setLocale(locale);
        await tester.pumpWidget(
          TranslationProvider(
            child: ProviderScope(
              overrides: [
                authControllerProvider.overrideWith(
                  () => FixtureAuth(fixtureAuth(studentId: 'TEST-ID-ONLY')),
                ),
              ],
              child: MaterialApp(
                theme: AppTheme.lightTheme,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(2)),
                  child: Directionality(
                    textDirection: locale == AppLocale.ar
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: child!,
                  ),
                ),
                home: const DigitalIDScreen(),
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(seconds: 3));
        expect(find.text('TEST-ID-ONLY'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
        LocaleSettings.setLocale(AppLocale.en);
      },
    );
  }

  testWidgets('missing identifier does not fabricate a digital ID', (
    tester,
  ) async {
    LocaleSettings.setLocale(AppLocale.en);
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            authControllerProvider.overrideWith(
              () => FixtureAuth(fixtureAuth()),
            ),
          ],
          child: const MaterialApp(home: DigitalIDScreen()),
        ),
      ),
    );
    expect(find.text(t.students.id_unavailable), findsOneWidget);
    expect(find.text('20230001'), findsNothing);
  });
}
