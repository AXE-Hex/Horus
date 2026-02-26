
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/theme/theme_provider.dart';
import 'package:hue/core/theme/low_performance_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = LocaleSettings.currentLocale == AppLocale.ar;
    final themeMode = ref.watch(themeControllerProvider);
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    return isGlass
        ? GlassScaffold(
            body: _buildBody(context, ref, isArabic, themeMode, appStyle, true),
          )
        : Scaffold(
            body: _buildBody(
              context,
              ref,
              isArabic,
              themeMode,
              appStyle,
              false,
            ),
          );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    bool isArabic,
    AsyncValue<ThemeMode> themeMode,
    AsyncValue<AppStyle> appStyle,
    bool isGlass,
  ) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 280,
          pinned: true,
          stretch: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
            ],
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColorDark,
                      ],
                    ),
                  ),
                ),
                if (isGlass)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ),

                Builder(
                  builder: (context) {
                    final auth = ref.watch(authControllerProvider);
                    return SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Hero(
                            tag: 'profile_avatar',
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.1),
                                backgroundImage: auth.avatarUrl != null
                                    ? NetworkImage(auth.avatarUrl!)
                                    : null,
                                child: auth.avatarUrl == null
                                    ? const Icon(
                                        LucideIcons.user,
                                        size: 50,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            auth.fullName ?? (isArabic ? 'مستخدم' : 'User'),
                            style: GoogleFonts.outfit(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            auth.user?.email ?? '',
                            style: GoogleFonts.shareTechMono(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              auth.role.displayName(isArabic: isArabic),
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSection(context, isArabic ? 'الحساب' : 'Account', [
                _buildSettingsTile(
                  context,
                  LucideIcons.user,
                  isArabic ? 'تعديل الملف الشخصي' : 'Edit Profile',
                  isGlass: isGlass,
                  onTap: () => context.push('/profile'),
                ),
                _buildSettingsTile(
                  context,
                  LucideIcons.lock,
                  isArabic ? 'تغيير كلمة المرور' : 'Change Password',
                  isGlass: isGlass,
                  onTap: () => context.push('/change-password'),
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection(context, isArabic ? 'العرض' : 'Display', [
                _buildSettingsTile(
                  context,
                  LucideIcons.moon,
                  isArabic ? 'الوضع الداكن' : 'Dark Mode',
                  isGlass: isGlass,
                  trailing: Consumer(
                    builder: (context, ref, _) {
                      final themeValue = ref.watch(themeControllerProvider);
                      return Switch(
                        value: themeValue.maybeWhen(
                          data: (mode) => mode == ThemeMode.dark,
                          orElse: () => false,
                        ),
                        onChanged: (val) {
                          _handleThemeSwitch(context, ref, val);
                        },
                        activeThumbColor: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                ),
                _buildSettingsTile(
                  context,
                  LucideIcons.languages,
                  isArabic ? 'اللغة' : 'Language',
                  isGlass: isGlass,
                  subtitle: _getLanguageName(
                    LocaleSettings.currentLocale.languageCode,
                  ),
                  onTap: () => _showLanguageSelector(context, ref),
                ),
                _buildSettingsTile(
                  context,
                  LucideIcons.palette,
                  isArabic ? 'نمط الواجهة' : 'UI Style',
                  isGlass: isGlass,
                  subtitle: appStyle.value == AppStyle.glass
                      ? (isArabic ? 'زجاجي' : 'Glass')
                      : (isArabic ? 'كلاسيكي' : 'Classic'),
                  onTap: () =>
                      _handleStyleSwitch(context, ref, appStyle.value!),
                ),
                if (isGlass)
                  _buildSettingsTile(
                    context,
                    LucideIcons.zap,
                    isArabic ? 'وضع الأداء المنخفض' : 'Low Performance Mode',
                    isGlass: isGlass,
                    subtitle: isArabic
                        ? 'تعطيل التأثيرات الثقيلة للأجهزة القديمة'
                        : 'Disables heavy effects for older devices',
                    trailing: Consumer(
                      builder: (context, ref, _) {
                        final isLowPerf = ref.watch(
                          lowPerformanceControllerProvider,
                        );
                        return Switch(
                          value: isLowPerf,
                          onChanged: (val) {
                            HapticFeedback.lightImpact();
                            ref
                                .read(lowPerformanceControllerProvider.notifier)
                                .toggle();
                          },
                          activeThumbColor: Theme.of(context).primaryColor,
                        );
                      },
                    ),
                  ),
              ]),
              const SizedBox(height: 24),
              _buildSection(context, isArabic ? 'الإشعارات' : 'Notifications', [
                _buildSettingsTile(
                  context,
                  LucideIcons.bell,
                  isArabic ? 'إشعارات التطبيق' : 'App Notifications',
                  isGlass: isGlass,
                  trailing: Switch(value: true, onChanged: (val) {}),
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection(context, isArabic ? 'حول' : 'About', [
                _buildSettingsTile(
                  context,
                  LucideIcons.info,
                  isArabic ? 'حول التطبيق' : 'About App',
                  isGlass: isGlass,
                  onTap: () => context.push('/about'),
                ),
                _buildSettingsTile(
                  context,
                  LucideIcons.shieldCheck,
                  isArabic ? 'سياسة الخصوصية' : 'Privacy Policy',
                  isGlass: isGlass,
                  onTap: () => context.push('/privacy-policy'),
                ),
              ]),
              const SizedBox(height: 32),
              _buildSettingsTile(
                context,
                LucideIcons.logOut,
                isArabic ? 'تسجيل الخروج' : 'Logout',
                isGlass: isGlass,
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () {
                  ref.read(authControllerProvider.notifier).signOut();
                  context.go('/login');
                },
              ).animate().fadeIn(),
              const SizedBox(height: 40),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
          child: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        _buildSettingsGroup(children),
      ],
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: EdgeInsets.zero,
      child: Column(children: children),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildSettingsTile(
    BuildContext context,
    IconData icon,
    String title, {
    required bool isGlass,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    final effectiveIconColor = iconColor ?? Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: effectiveIconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: effectiveIconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:
                          textColor ??
                          Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else if (onTap != null)
              Icon(
                LucideIcons.chevronRight,
                size: 18,
                color: Theme.of(context).hintColor.withValues(alpha: 0.3),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleThemeSwitch(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
  ) async {
    final nextMode = isDark ? ThemeMode.dark : ThemeMode.light;
    HapticFeedback.mediumImpact();
    await ref.read(themeControllerProvider.notifier).setTheme(nextMode);

  }

  void _handleLanguageSwitch(BuildContext context, AppLocale nextLocale) {
    if (nextLocale == LocaleSettings.currentLocale) return;

    context.go(
      '/transition',
      extra: {
        'nextPath': '/settings',
        'message': t.settings.messages.changing_language,
        'isRefresh': true,
        'onComplete': () {
          LocaleSettings.setLocale(nextLocale);
        },
      },
    );
  }

  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isGlass =
            ref.read(styleControllerProvider).value == AppStyle.glass;
        final isArabic = LocaleSettings.currentLocale == AppLocale.ar;
        return GlassContainer(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          blur: isGlass ? 20 : 0,
          opacity: isGlass ? 0.8 : 1.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isArabic ? 'اللغة' : 'Language',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              _buildLanguageItem(
                context,
                '🇺🇸',
                'English',
                AppLocale.en,
                isGlass,
              ),
              _buildLanguageItem(
                context,
                '🇸🇦',
                'العربية',
                AppLocale.ar,
                isGlass,
              ),
              _buildLanguageItem(
                context,
                '🇩🇪',
                'Deutsch',
                AppLocale.de,
                isGlass,
              ),
              _buildLanguageItem(context, '🇨🇳', '中文', AppLocale.zh, isGlass),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageItem(
    BuildContext context,
    String emoji,
    String label,
    AppLocale locale,
    bool isGlass,
  ) {
    final isSelected = LocaleSettings.currentLocale == locale;
    final textColor = isGlass
        ? Colors.white
        : Theme.of(context).colorScheme.onSurface;

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _handleLanguageSwitch(context, locale);
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? textColor
                      : textColor.withValues(alpha: 0.7),
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                LucideIcons.check,
                color: Colors.greenAccent,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleStyleSwitch(
    BuildContext context,
    WidgetRef ref,
    AppStyle currentStyle,
  ) async {
    final nextStyle = currentStyle == AppStyle.glass
        ? AppStyle.classic
        : AppStyle.glass;

    HapticFeedback.heavyImpact();
    await ref.read(styleControllerProvider.notifier).setStyle(nextStyle);

    if (!context.mounted) return;

    context.go(
      '/transition',
      extra: {
        'nextPath': '/settings',
        'message': t.settings.messages.rebuilding_design,
        'isRefresh': true,
        'onComplete': null,
      },
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'ar':
        return 'العربية';
      case 'de':
        return 'Deutsch';
      case 'zh':
        return '中文';
      default:
        return 'English';
    }
  }
}
