import 'package:go_router/go_router.dart';
import 'package:horus/features/auth/presentation/screens/login_screen.dart';
import 'package:horus/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:horus/features/auth/presentation/screens/guest_registration_screen.dart';
import 'package:horus/features/auth/presentation/screens/access_pending_screen.dart';

final List<RouteBase> authRoutes = [
  GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
  GoRoute(
    path: '/forgot-password',
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
  GoRoute(
    path: '/guest-registration',
    builder: (context, state) => const GuestRegistrationScreen(),
  ),
  GoRoute(
    path: '/access-pending',
    builder: (context, state) => const AccessPendingScreen(),
  ),
];
