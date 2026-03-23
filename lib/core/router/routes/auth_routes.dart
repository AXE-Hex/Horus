import 'package:go_router/go_router.dart';
import 'package:hue/features/auth/presentation/screens/login_screen.dart';
import 'package:hue/features/auth/presentation/screens/forgot_password_screen.dart';

final List<RouteBase> authRoutes = [
  GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
  GoRoute(
    path: '/forgot-password',
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
];
