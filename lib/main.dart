import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/app/horus_app.dart';
import 'package:horus/core/config/env_config.dart';

import 'package:horus/core/config/build_config.dart';
import 'package:horus/core/security/axe_fingerprint.dart';
import 'core/security/branding_verifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvConfig.validate();

  if (kDebugMode) {
    debugPrint('Horus Traceability Key: ${BuildConfig.traceabilityKey}');
  }

  if (!BrandingVerifier.verify() || Axe.axeSignature == 'INVALID') {}

  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
    debug: false,
  );

  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const ProviderScope(child: HorusApp())));
}
