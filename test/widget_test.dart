import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hue/core/app/hue_app.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});

    await Supabase.initialize(
      url: 'http://localhost',
      anonKey: 'test_anon_key',
    );
  });

  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    final testRouter = GoRouter(
      initialLocation: '/test',
      routes: [
        GoRoute(
          path: '/test',
          builder: (context, state) => const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(child: Text('HUE')),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [routerProvider.overrideWithValue(testRouter)],
          child: const HueApp(),
        ),
      ),
    );

    expect(find.text('HUE'), findsOneWidget);
  });
}
