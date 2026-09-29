import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/router/route_guard.dart';

import 'package:horus/core/router/routes/auth_routes.dart';
import 'package:horus/core/router/routes/onboarding_routes.dart';
import 'package:horus/core/router/routes/home_routes.dart';
import 'package:horus/core/router/routes/academic_routes.dart';
import 'package:horus/core/router/routes/enrollment_routes.dart';
import 'package:horus/core/router/routes/settings_routes.dart';
import 'package:horus/core/router/routes/shared_routes.dart';
import 'package:horus/core/router/routes/feed_routes.dart';

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
    redirect: (context, state) =>
        redirectForAuthState(state.matchedLocation, authNotifier.value),
    routes: [
      ...authRoutes,
      ...onboardingRoutes,
      ...homeRoutes,
      ...academicRoutes,
      ...enrollmentRoutes,
      ...settingsRoutes,
      ...sharedRoutes,
      ...feedRoutes,
    ],
  );
});
