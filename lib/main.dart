import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/i18n/locale_preferences.dart';
import 'package:horus/core/app/horus_app.dart';
import 'package:horus/core/config/env_config.dart';

import 'package:horus/core/config/build_config.dart';
import 'package:horus/core/security/axe_fingerprint.dart';
import 'core/security/branding_verifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Validate environment configuration
  try {
    EnvConfig.validate();
  } catch (e) {
    if (kDebugMode) {
      debugPrint('⚠️  Environment validation: $e');
      debugPrint(EnvConfig.getDebugInfo());
    }
  }

  // Print environment and build info in debug mode
  if (kDebugMode) {
    debugPrint(EnvConfig.getDebugInfo());
    debugPrint('🔒 Horus Traceability Key: ${BuildConfig.traceabilityKey}');
    debugPrint('🔑 Security Signature: ${Axe.axeSignature}');
  }

  // Verify branding (warning only in development)
  final isBrandingValid = BrandingVerifier.verify();
  if (kDebugMode && !isBrandingValid) {
    debugPrint('⚠️  Branding verification failed - development mode');
  }

  // Initialize Supabase
  try {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
      debug: kDebugMode,
    );
    if (kDebugMode) {
      debugPrint('✅ Supabase initialized successfully');
    }
  } catch (e) {
    debugPrint('❌ Supabase initialization error: $e');
    if (!EnvConfig.isDevelopment) {
      rethrow; // Fail fast in production
    }
  }

  // Resolve the saved choice first, then use the supported device locale.
  await LocalePreferences.initialize();

  runApp(TranslationProvider(child: const ProviderScope(child: HorusApp())));
}
