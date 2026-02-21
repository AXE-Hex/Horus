import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:hue/core/app/hue_app.dart';
import 'package:hue/core/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
    debug: false,
  );

  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const ProviderScope(child: HueApp())));
}
