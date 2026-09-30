import 'package:horus/shared/widgets/horus_entrance.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/router/route_guard.dart';
import 'package:horus/core/theme/app_spacing.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _fallbackTimer;
  bool _brandReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      AssetImage(
        Theme.of(context).brightness == Brightness.dark
            ? 'assets/images/Logo_dark.png'
            : 'assets/images/Logo_light.png',
      ),
      context,
    );
  }

  @override
  void initState() {
    super.initState();
    _fallbackTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      _brandReady = true;
      final auth = ref.read(authControllerProvider);
      if (!auth.isLoading) context.go(resolveInitialDestination(auth));
    });
  }

  @override
  void dispose() {
    _fallbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    ref.listen<AuthState>(authControllerProvider, (_, next) {
      if (_brandReady && !next.isLoading) {
        context.go(resolveInitialDestination(next));
      }
    });
    final theme = Theme.of(context);
    final userName = t.$meta.locale.languageCode == 'ar'
        ? (auth.profile?.fullNameAr ?? auth.profile?.fullName)
        : auth.profile?.fullName;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: HorusEntrance(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    theme.brightness == Brightness.dark
                        ? 'assets/images/Logo_dark.png'
                        : 'assets/images/Logo_light.png',
                    width: 210,
                    height: 104,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    userName == null
                        ? t.students.horus_university
                        : '${t.auth.splash.welcome_prefix} $userName',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
