import 'package:go_router/go_router.dart';
import 'package:hue/features/shared/presentation/screens/notifications_screen.dart';
import 'package:hue/features/shared/presentation/screens/support_screen.dart';
import 'package:hue/features/shared/presentation/screens/security_screen.dart';
import 'package:hue/features/shared/presentation/screens/sessions_screen.dart';
import 'package:hue/features/shared/presentation/screens/tutorials_screen.dart';
import 'package:hue/features/shared/presentation/screens/forums_screen.dart';

final List<RouteBase> sharedRoutes = [
  GoRoute(
    path: '/biometrics',
    builder: (context, state) => const SecurityScreen(),
  ),
  GoRoute(
    path: '/sessions',
    builder: (context, state) => const SessionsScreen(),
  ),
  GoRoute(
    path: '/notifications',
    builder: (context, state) => const NotificationsScreen(),
  ),
  GoRoute(path: '/forums', builder: (context, state) => const ForumsScreen()),
  GoRoute(path: '/support', builder: (context, state) => const SupportScreen()),
  GoRoute(
    path: '/tutorials',
    builder: (context, state) => const TutorialsScreen(),
  ),
];
