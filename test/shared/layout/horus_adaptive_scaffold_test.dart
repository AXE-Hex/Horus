import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/shared/layout/horus_adaptive_scaffold.dart';
import 'package:horus/shared/layout/horus_destination.dart';

void main() {
  const destinations = [
    HorusDestination(route: '/home', label: 'Home', icon: Icons.home),
    HorusDestination(route: '/forums', label: 'Forums', icon: Icons.forum),
    HorusDestination(route: '/courses', label: 'Courses', icon: Icons.school),
    HorusDestination(
      route: '/university',
      label: 'University',
      icon: Icons.account_balance,
    ),
    HorusDestination(route: '/profile', label: 'Profile', icon: Icons.person),
  ];

  for (final (width, expected) in [
    (390.0, 'mobile-bottom-navigation'),
    (768.0, 'tablet-navigation-rail'),
    (1440.0, 'desktop-sidebar'),
  ]) {
    testWidgets('$expected fits at ${width.toInt()}px', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: HorusAdaptiveScaffold(
            destinations: destinations,
            location: '/home',
            onNavigate: (_) {},
            navigationLabel: 'Navigation',
            child: const Scaffold(body: Text('Feed content')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Feed content'), findsOneWidget);
      expect(tester.takeException(), isNull);
      switch (expected) {
        case 'mobile-bottom-navigation':
          expect(find.byType(NavigationRail), findsNothing);
          expect(
            find.byKey(const ValueKey('horus-desktop-sidebar')),
            findsNothing,
          );
          for (final destination in destinations) {
            expect(find.text(destination.label), findsOneWidget);
          }
        case 'tablet-navigation-rail':
          expect(find.byType(NavigationRail), findsOneWidget);
          expect(
            find.byKey(const ValueKey('horus-desktop-sidebar')),
            findsNothing,
          );
        case 'desktop-sidebar':
          expect(
            find.byKey(const ValueKey('horus-desktop-sidebar')),
            findsOneWidget,
          );
          expect(find.byType(NavigationRail), findsNothing);
      }
    });
  }
}
