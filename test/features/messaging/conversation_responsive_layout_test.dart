import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_theme.dart';
import 'package:horus/features/messaging/presentation/providers/conversation_provider.dart';
import 'package:horus/features/messaging/presentation/screens/conversation_list_screen.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';

class _EmptyAuthController extends AuthController {
  @override
  AuthState build() => const AuthState();
}

ConversationRecord _conversation() {
  final joinedAt = DateTime.utc(2026, 1, 1);
  return ConversationRecord(
    id: '11111111-1111-4111-8111-111111111111',
    isGroup: false,
    createdAt: joinedAt,
    updatedAt: joinedAt,
    lastMessage: 'Fixture message',
    lastMessageAt: joinedAt,
    members: [
      ConversationMemberRecord(
        conversationId: '11111111-1111-4111-8111-111111111111',
        userId: 'fixture-peer',
        joinedAt: joinedAt,
        lastReadAt: joinedAt,
        isAdmin: false,
        isMuted: false,
        profile: const ConversationProfile(
          id: 'fixture-peer',
          fullName: 'Test Member',
        ),
      ),
    ],
  );
}

void main() {
  for (final width in [390, 768, 1440]) {
    testWidgets('conversation layout has no errors at ${width}px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width.toDouble(), 960);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        TranslationProvider(
          child: ProviderScope(
            overrides: [
              authControllerProvider.overrideWith(_EmptyAuthController.new),
              conversationsProvider.overrideWith(
                (ref) async => [_conversation()],
              ),
              messagesProvider.overrideWith((ref, id) async => const []),
            ],
            child: MaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.dark,
              home: const ConversationListScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ConversationListScreen), findsOneWidget);
      expect(find.text('Test Member'), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);
      expect(find.text('Fixture message'), findsOneWidget);
    });
  }
}
