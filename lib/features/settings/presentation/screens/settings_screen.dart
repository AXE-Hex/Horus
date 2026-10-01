import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/i18n/locale_preferences.dart';
import 'package:horus/core/theme/app_colors.dart';
import 'package:horus/core/theme/theme_provider.dart';

import 'package:horus/features/shared/presentation/widgets/glass_container.dart';

part 'settings_screen_sections.dart';
part 'settings_screen_items.dart';
part 'settings_screen_dialogs.dart';
part 'settings_screen_preferences.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationPref();
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: _buildBody(context, isArabic, false),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool isArabic, bool isGlass) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildImmersiveHeader(context, isArabic),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final account = _settingsGroup(
                  t.extracted.account,
                  LucideIcons.userCircle,
                  _buildAccountSection(context, isArabic, isGlass),
                );
                final appearance = _settingsGroup(
                  t.extracted.appearance,
                  LucideIcons.palette,
                  _buildAppearanceSection(context, isArabic, isGlass),
                );
                final notifications = _settingsGroup(
                  t.extracted.notifications,
                  LucideIcons.bellRing,
                  _buildNotificationsSection(context, isArabic, isGlass),
                );
                final language = _settingsGroup(
                  t.extracted.language_region,
                  LucideIcons.globe,
                  _buildLanguageSection(context, isArabic, isGlass),
                );
                final support = _settingsGroup(
                  t.extracted.support_feedback,
                  LucideIcons.lifeBuoy,
                  _buildSupportSection(context, isArabic, isGlass),
                );
                final about = _settingsGroup(
                  t.extracted.about,
                  LucideIcons.info,
                  _buildAboutSection(context, isArabic, isGlass),
                );
                final wide = constraints.maxWidth >= 760;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (wide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [account, appearance, support],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              children: [notifications, language, about],
                            ),
                          ),
                        ],
                      )
                    else ...[
                      account,
                      appearance,
                      notifications,
                      language,
                      support,
                      about,
                    ],
                    const SizedBox(height: 12),
                    _buildLogoutButton(context, isArabic, isGlass),
                    const SizedBox(height: 48),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _settingsGroup(String title, IconData icon, Widget content) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildSectionHeader(title, icon), content],
    ),
  );
}
