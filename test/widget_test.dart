import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hue/core/app/hue_app.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      TranslationProvider(child: const ProviderScope(child: HueApp())),
    );

    await tester.pumpAndSettle();

    expect(find.text('HUE'), findsOneWidget);
  });
}
