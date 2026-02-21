// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/router/app_router.dart';
import 'package:hue/core/theme/app_theme.dart';
import 'package:hue/core/theme/theme_provider.dart';
import 'package:hue/features/shared/presentation/widgets/liquid_toast_overlay.dart';

class HueApp extends ConsumerWidget {
  const HueApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Hue',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode.value ?? ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: AppLocaleUtils.supportedLocales,
      locale: TranslationProvider.of(context).locale.flutterLocale,
      builder: (context, child) {
        return LiquidToastOverlay(child: child!);
      },
    );
  }
}
