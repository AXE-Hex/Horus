import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_theme.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:horus/features/feed/presentation/providers/feed_provider.dart';
import 'package:horus/features/feed/presentation/screens/feed_screen.dart';

class _EmptyAuthController extends AuthController {
  @override
  AuthState build() => const AuthState();
}

class _EmptyFeedNotifier extends FeedNotifier {
  @override
  Future<List<PostModel>> build() async => const [];
}

void main() {
  for (final width in [390, 768, 1440]) {
    testWidgets('feed has no layout errors at ${width}px', (tester) async {
      tester.view.physicalSize = Size(width.toDouble(), 960);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        TranslationProvider(
          child: ProviderScope(
            overrides: [
              authControllerProvider.overrideWith(_EmptyAuthController.new),
              feedProvider.overrideWith(_EmptyFeedNotifier.new),
            ],
            child: MaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.dark,
              home: const FeedScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FeedScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
