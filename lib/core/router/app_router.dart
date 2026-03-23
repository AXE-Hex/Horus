import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/router/route_guard.dart';

import 'package:hue/core/router/routes/auth_routes.dart';
import 'package:hue/core/router/routes/onboarding_routes.dart';
import 'package:hue/core/router/routes/home_routes.dart';
import 'package:hue/core/router/routes/admin_routes.dart';
import 'package:hue/core/router/routes/academic_routes.dart';
import 'package:hue/core/router/routes/enrollment_routes.dart';
import 'package:hue/core/router/routes/settings_routes.dart';
import 'package:hue/core/router/routes/shared_routes.dart';
import 'package:hue/core/router/routes/feed_routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ValueNotifier<AuthState>(
    ref.read(authControllerProvider),
  );

  ref.listen<AuthState>(authControllerProvider, (_, next) {
    authNotifier.value = next;
  });

  ref.onDispose(authNotifier.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = authNotifier.value;
      final location = state.matchedLocation;
      final isLoggedIn = authState.isAuthenticated;
      final isPublic = publicRoutes.contains(location);

      if (!isLoggedIn && !isPublic) {
        return '/login';
      }

      if (isLoggedIn && location == '/login') {
        return '/home';
      }

      if (isLoggedIn && !canAccessRoute(location, authState.role)) {
        return '/home';
      }

      return null;
    },
    routes: [
      ...authRoutes,
      ...onboardingRoutes,
      ...homeRoutes,
      ...adminRoutes,
      ...academicRoutes,
      ...enrollmentRoutes,
      ...settingsRoutes,
      ...sharedRoutes,
      ...feedRoutes,
    ],
  );
});
