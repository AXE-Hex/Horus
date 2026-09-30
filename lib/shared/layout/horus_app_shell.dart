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
      if (auth.permissionCodes.contains('grades.read'))
        HorusDestination(
          route: '/dashboard',
          label: t.home.home,
          icon: Icons.home_outlined,
        )
      else if (auth.permissionCodes.contains('grades.manage'))
        HorusDestination(
          route: '/professor-dashboard',
          label: t.home.home,
          icon: Icons.home_outlined,
        )
      else
        HorusDestination(
          route: '/home',
          label: t.home.home,
          icon: Icons.home_outlined,
        ),
      HorusDestination(
        route: '/courses',
        label: t.academic.courses,
        icon: Icons.school_outlined,
      ),
      HorusDestination(
        route: '/feed',
        label: t.students.forums,
        icon: Icons.dynamic_feed_outlined,
      ),
      HorusDestination(
        route: '/schedule',
        label: t.students.daily_schedule,
        icon: Icons.calendar_today_outlined,
      ),
      HorusDestination(
        route: '/profile',
        label: t.extracted.account,
        icon: Icons.person_outline,
      ),
      HorusDestination(
        route: '/control',
        label: t.control.title,
        icon: Icons.account_balance_outlined,
      ),
      HorusDestination(
        route: '/registration',
        label: t.registration.title,
        icon: Icons.app_registration,
      ),
      HorusDestination(
        route: '/advisor-approval',
        label: t.academic.students,
        icon: Icons.fact_check_outlined,
      ),
      HorusDestination(
        route: '/grades',
        label: t.academic.academic_results,
        icon: Icons.analytics_outlined,
      ),
      HorusDestination(
        route: '/notifications',
        label: t.students.notifications,
        icon: Icons.notifications_outlined,
      ),
      HorusDestination(
        route: '/settings',
        label: t.settings.title,
        icon: Icons.settings_outlined,
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
