import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  GoogleFonts.config.allowRuntimeFetching = false;

  EnvConfig.validate();

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

  // The SDK's legacy parameter name still accepts a modern publishable key.
  // Disable SDK request logging so auth request payloads cannot reach logs.
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabasePublishableKey,
    debug: false,
  );

  // Resolve the saved choice first, then use the supported device locale.
  await LocalePreferences.initialize();

  runApp(TranslationProvider(child: const ProviderScope(child: HorusApp())));
}