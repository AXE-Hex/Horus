import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/i18n/locale_preferences.dart';
import 'package:horus/core/theme/low_performance_provider.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/core/theme/theme_provider.dart';

import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';

part 'settings_screen_sections.dart';
part 'settings_screen_items.dart';
part 'settings_screen_dialogs.dart';
part 'settings_screen_preferences.dart';
part 'settings_screen_painter.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _loadNotificationPref();
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  Future<void> _loadNotificationPref() async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getBool('notifications_enabled') ?? true;
    if (mounted) setState(() => _notificationsEnabled = val);
  }

  Future<void> _toggleNotifications(bool val) async {
    HapticFeedback.lightImpact();
    setState(() => _notificationsEnabled = val);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', val);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleSettings.currentLocale == AppLocale.ar;
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    return isGlass
        ? GlassScaffold(body: _buildBody(context, isArabic, isGlass))
        : Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: _buildBody(context, isArabic, isGlass),
          );
  }

  Widget _buildBody(BuildContext context, bool isArabic, bool isGlass) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildImmersiveHeader(context, isArabic, isGlass),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionHeader(t.extracted.account, LucideIcons.userCircle),
              _buildAccountSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              _buildSectionHeader(t.extracted.appearance, LucideIcons.palette),
              _buildAppearanceSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              _buildSectionHeader(
                t.extracted.notifications,
                LucideIcons.bellRing,
              ),
              _buildNotificationsSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              _buildSectionHeader(
                t.extracted.language_region,
                LucideIcons.globe,
              ),
              _buildLanguageSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              _buildSectionHeader(
                t.extracted.support_feedback,
                LucideIcons.lifeBuoy,
              ),
              _buildSupportSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              _buildSectionHeader(t.extracted.about, LucideIcons.info),
              _buildAboutSection(context, isArabic, isGlass),
              const SizedBox(height: 40),

              _buildLogoutButton(context, isArabic, isGlass),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );
  }
}
