import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/feed/presentation/widgets/media_grid.dart';

void main() {
  testWidgets('empty media renders no feed media control', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: MediaGrid(mediaUrls: [])),
      ),
    );

    expect(find.byType(MediaGrid), findsOneWidget);
    expect(find.byType(AspectRatio), findsNothing);
  });

  testWidgets('grid indicates hidden items when a post has more than four', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 360,
              height: 280,
              child: const MediaGrid(
                mediaUrls: [
                  'https://example.test/1.png',
                  'https://example.test/2.png',
                  'https://example.test/3.png',
                  'https://example.test/4.png',
                  'https://example.test/5.png',
                  'https://example.test/6.png',
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('+2'), findsOneWidget);
  });

  testWidgets('Arabic locale resolves to RTL and English resolves to LTR', (
    tester,
  ) async {
    Future<TextDirection> directionFor(Locale locale) async {
      late TextDirection direction;
      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: Builder(
            builder: (context) {
              direction = Directionality.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      return direction;
    }

    expect(await directionFor(const Locale('ar')), TextDirection.rtl);
    expect(await directionFor(const Locale('en')), TextDirection.ltr);
  });
}
