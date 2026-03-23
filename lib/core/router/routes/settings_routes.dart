import 'package:go_router/go_router.dart';
import 'package:hue/features/settings/presentation/screens/settings_screen.dart';

import 'package:hue/features/settings/presentation/screens/profile_screen.dart';
import 'package:hue/features/settings/presentation/screens/change_password_screen.dart';
import 'package:hue/features/settings/presentation/screens/about_screen.dart';
import 'package:hue/features/settings/presentation/screens/privacy_policy_screen.dart';

final List<RouteBase> settingsRoutes = [
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsScreen(),
  ),
  GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
  GoRoute(
    path: '/change-password',
    builder: (context, state) => const ChangePasswordScreen(),
  ),
  GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
  GoRoute(
    path: '/privacy-policy',
    builder: (context, state) => const PrivacyPolicyScreen(),
  ),
];
