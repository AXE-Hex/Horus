import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'horus_adaptive_scaffold.dart';
import 'horus_destination.dart';

class HorusAppShell extends ConsumerWidget {
  const HorusAppShell({super.key, required this.child, required this.location});
  final Widget child;
  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final destinations = accessibleDestinations([
      HorusDestination(
        route: '/home',
        label: t.home.home,
        icon: Icons.dynamic_feed_outlined,
      ),
      HorusDestination(
        route: '/conversations',
        label: t.messaging.title,
        icon: Icons.chat_bubble_outline_rounded,
      ),
      HorusDestination(
        route: '/courses',
        label: t.academic.courses,
        icon: Icons.school_outlined,
      ),
      HorusDestination(
        route: '/colleges-selection',
        label: t.navigation.university,
        icon: Icons.account_balance_outlined,
      ),
      HorusDestination(
        route: '/profile',
        label: t.extracted.account,
        icon: Icons.person_outline,
      ),
    ], auth.hasRole ? auth.permissionCodes : const {});
    return HorusAdaptiveScaffold(
      destinations: destinations,
      location: location,
      navigationLabel: t.home.home,
      onNavigate: (route) => context.go(route),
      child: child,
    );
  }
}
