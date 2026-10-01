import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/router/back_navigation.dart';

GoRouter _router(String initial) => GoRouter(
  initialLocation: initial,
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => Scaffold(
        body: TextButton(
          onPressed: () => context.push('/profile'),
          child: const Text('Home'),
        ),
      ),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => Scaffold(
        body: TextButton(
          onPressed: context.backToHorus,
          child: const Text('Back from profile'),
        ),
      ),
    ),
  ],
);

void main() {
  testWidgets('a direct screen link falls back to the guarded home route', (
    tester,
  ) async {
    final router = _router('/profile');
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back from profile'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('a pushed screen retains normal back behavior', (tester) async {
    final router = _router('/home');
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back from profile'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
  });
}
