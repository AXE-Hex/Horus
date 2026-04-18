import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/security/axe_fingerprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/router/app_router.dart';
import 'package:horus/core/theme/app_theme.dart';
import 'package:horus/core/theme/theme_provider.dart';
import 'package:horus/features/shared/presentation/widgets/liquid_toast_overlay.dart';

class HorusApp extends ConsumerWidget {
  const HorusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Horus',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode.value ?? ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: AppLocaleUtils.supportedLocales,
      locale: TranslationProvider.of(context).locale.flutterLocale,
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();

        return Semantics(
          identifier: Axe.identifier,
          container: true,
          child: LiquidToastOverlay(child: child),
        );
      },
    );
  }
}
