import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/theme/low_performance_provider.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/theme/theme_provider.dart';

import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';

// ignore_for_file: unnecessary_underscores

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
            backgroundColor: const Color(0xFF0A0A1A),
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
              // ── Account Section ──
              _buildSectionHeader(
                isArabic ? 'الحساب الشخصي' : 'Account',
                LucideIcons.userCircle,
              ),
              _buildAccountSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              // ── Appearance Section ──
              _buildSectionHeader(
                isArabic ? 'المظهر' : 'Appearance',
                LucideIcons.palette,
              ),
              _buildAppearanceSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              // ── Notifications Section ──
              _buildSectionHeader(
                isArabic ? 'الإشعارات' : 'Notifications',
                LucideIcons.bellRing,
              ),
              _buildNotificationsSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              // ── Language Section ──
              _buildSectionHeader(
                isArabic ? 'اللغة والمنطقة' : 'Language & Region',
                LucideIcons.globe,
              ),
              _buildLanguageSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              // ── Support & Feedback Section ──
              _buildSectionHeader(
                isArabic ? 'الدعم والتواصل' : 'Support & Feedback',
                LucideIcons.lifeBuoy,
              ),
              _buildSupportSection(context, isArabic, isGlass),
              const SizedBox(height: 28),

              // ── About Section ──
              _buildSectionHeader(
                isArabic ? 'حول التطبيق' : 'About',
                LucideIcons.info,
              ),
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

  Widget _buildImmersiveHeader(
    BuildContext context,
    bool isArabic,
    bool isGlass,
  ) {
    final auth = ref.watch(authControllerProvider);
    final themeColor = Theme.of(context).primaryColor;

    return SliverAppBar(
      expandedHeight: 330,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            color: Colors.white,
            onPressed: () => context.pop(),
          ),
        ),
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
                    const Color(0xFF1A0533),
                    themeColor.withValues(alpha: 0.8),
                    const Color(0xFF0D1B2A),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            if (isGlass)
              Positioned.fill(child: CustomPaint(painter: _ParticlesPainter())),
            // animated glow
            Positioned(
              right: isArabic ? null : -60,
              left: isArabic ? -60 : null,
              top: -60,
              child: AnimatedBuilder(
                animation: _glowController,
                builder: (_, __) => Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        themeColor.withValues(
                          alpha: 0.15 + 0.1 * _glowController.value,
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: isArabic ? null : -40,
              left: isArabic ? -40 : null,
              top: -40,
              child: Opacity(
                opacity: 0.07,
                child: Icon(
                  LucideIcons.settings,
                  size: 260,
                  color: Colors.white,
                ),
              ).animate().rotate(duration: 20.seconds, curve: Curves.linear),
            ),
            SafeArea(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Avatar with tap-to-change
                    GestureDetector(
                      onTap: () => context.push('/profile'),
                      child: Hero(
                        tag: 'profile_avatar_settings',
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [themeColor, const Color(0xFF10B981)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: themeColor.withValues(alpha: 0.45),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF0D1B2A),
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.08,
                                  ),
                                  backgroundImage: auth.avatarUrl != null
                                      ? NetworkImage(auth.avatarUrl!)
                                      : null,
                                  child: auth.avatarUrl == null
                                      ? const Icon(
                                          LucideIcons.userCircle2,
                                          size: 55,
                                          color: Colors.white70,
                                        )
                                      : null,
                                ),
                              ),
                            ).animate().scale(
                              duration: 600.ms,
                              curve: Curves.easeOutBack,
                            ),
                            // Camera overlay
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: themeColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF0D1B2A),
                                    width: 2.5,
                                  ),
                                ),
                                child: const Icon(
                                  LucideIcons.camera,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                          auth.fullName ?? t.settings.user,
                          style: GoogleFonts.outfit(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 4),
                    Text(
                          auth.user?.email ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.55),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: themeColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: themeColor.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            LucideIcons.shield,
                            size: 13,
                            color: Colors.greenAccent,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            auth.role.displayName(
                              isArabic:
                                  LocaleSettings.currentLocale == AppLocale.ar,
                            ),
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 400.ms).scale(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: primaryColor),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ).animate().fadeIn().slideX(begin: -0.1, end: 0),
    );
  }

  Widget _buildAccountSection(
    BuildContext context,
    bool isArabic,
    bool isGlass,
  ) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Column(
        children: [
          _buildSettingItem(
            context: context,
            icon: LucideIcons.userCog,
            iconColor: const Color(0xFF6366F1),
            title: isArabic ? 'تعديل الملف الشخصي' : 'Edit Profile',
            subtitle: isArabic
                ? 'تحديث معلوماتك وبياناتك الشخصية'
                : 'Update your personal info and photo',
            isGlass: isGlass,
            onTap: () => context.push('/profile'),
          ),
          _divider(context),
          _buildSettingItem(
            context: context,
            icon: LucideIcons.unlock,
            iconColor: Colors.orangeAccent,
            title: isArabic ? 'استعادة كلمة المرور' : 'Password Recovery',
            subtitle: isArabic
                ? 'إرسال رابط استعادة كلمة المرور لبريدك الإلكتروني'
                : 'Send password recovery link to your email',
            isGlass: isGlass,
            onTap: () => context.push('/forgot-password'),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _buildAppearanceSection(
    BuildContext context,
    bool isArabic,
    bool isGlass,
  ) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Column(
        children: [
          _buildSettingItem(
            context: context,
            icon: LucideIcons.moonStar,
            iconColor: const Color(0xFF7C3AED),
            title: isArabic ? 'الوضع المظلم' : 'Dark Mode',
            subtitle: isArabic
                ? 'التبديل بين الوضع الداكن والفاتح'
                : 'Toggle between dark and light mode',
            isGlass: isGlass,
            trailing: Consumer(
              builder: (context, ref, _) {
                final themeValue = ref.watch(themeControllerProvider);
                final isDark = themeValue.maybeWhen(
                  data: (mode) => mode == ThemeMode.dark,
                  orElse: () => false,
                );
                return _buildSwitch(
                  value: isDark,
                  onChanged: _handleThemeSwitch,
                  activeColor: const Color(0xFF7C3AED),
                );
              },
            ),
          ),
          _divider(context),
          _buildSettingItem(
            context: context,
            icon: LucideIcons.sparkles,
            iconColor: Colors.pinkAccent,
            title: isArabic ? 'نمط الواجهة' : 'UI Style',
            subtitle: isGlass
                ? (isArabic ? 'الحالي: تصميم الزجاج' : 'Current: Glass Design')
                : (isArabic
                      ? 'الحالي: التصميم الكلاسيكي'
                      : 'Current: Classic Design'),
            isGlass: isGlass,
            onTap: _handleStyleSwitch,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.pinkAccent.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                isArabic ? 'تبديل' : 'Switch',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
          ),
          if (isGlass) ...[
            _divider(context),
            _buildSettingItem(
              context: context,
              icon: LucideIcons.batteryCharging,
              iconColor: Colors.greenAccent,
              title: isArabic ? 'وضع توفير البطارية' : 'Battery Saver Mode',
              subtitle: isArabic
                  ? 'تعطيل التأثيرات البصرية لأداء أفضل'
                  : 'Disable complex visual effects',
              isGlass: isGlass,
              trailing: Consumer(
                builder: (context, ref, _) {
                  final isLowPerf = ref.watch(lowPerformanceControllerProvider);
                  return _buildSwitch(
                    value: isLowPerf,
                    onChanged: (val) {
                      HapticFeedback.lightImpact();
                      ref
                          .read(lowPerformanceControllerProvider.notifier)
                          .toggle();
                    },
                    activeColor: Colors.greenAccent,
                  );
                },
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _buildNotificationsSection(
    BuildContext context,
    bool isArabic,
    bool isGlass,
  ) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Column(
        children: [
          _buildSettingItem(
            context: context,
            icon: LucideIcons.bellRing,
            iconColor: Colors.redAccent,
            title: isArabic ? 'إشعارات التطبيق' : 'App Notifications',
            subtitle: _notificationsEnabled
                ? (isArabic ? 'الإشعارات مفعّلة' : 'Notifications are active')
                : (isArabic ? 'الإشعارات موقوفة' : 'Notifications are off'),
            isGlass: isGlass,
            trailing: _buildSwitch(
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
              activeColor: Colors.redAccent,
            ),
          ),
          _divider(context),
          _buildSettingItem(
            context: context,
            icon: LucideIcons.bell,
            iconColor: Colors.amberAccent,
            title: isArabic ? 'مركز الإشعارات' : 'Notification Center',
            subtitle: isArabic
                ? 'عرض جميع الإشعارات والتنبيهات'
                : 'View all your notifications',
            isGlass: isGlass,
            onTap: () => context.push('/notifications'),
          ),
          _divider(context),
          _buildSettingItem(
            context: context,
            icon: LucideIcons.bellDot,
            iconColor: Colors.orangeAccent,
            title: isArabic ? 'اختبار الإشعارات' : 'Test Notification',
            subtitle: isArabic
                ? 'إرسال إشعار تجريبي'
                : 'Send a test notification',
            isGlass: isGlass,
            onTap: () {
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(
                        LucideIcons.bellRing,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isArabic
                            ? 'تم إرسال الإشعار بنجاح!'
                            : 'Test notification sent!',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  backgroundColor: const Color(0xFF6366F1),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _buildLanguageSection(
    BuildContext context,
    bool isArabic,
    bool isGlass,
  ) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: _buildSettingItem(
        context: context,
        icon: LucideIcons.languages,
        iconColor: Colors.tealAccent,
        title: isArabic ? 'لغة التطبيق' : 'App Language',
        subtitle: _getLanguageName(LocaleSettings.currentLocale.languageCode),
        isGlass: isGlass,
        onTap: () => _showLanguageSelector(context, ref),
      ),
    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _buildSupportSection(
    BuildContext context,
    bool isArabic,
    bool isGlass,
  ) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Column(
        children: [
          // Support Center
          _buildSettingItem(
            context: context,
            icon: LucideIcons.lifeBuoy,
            iconColor: Colors.cyanAccent,
            title: isArabic ? 'مركز الدعم والمساعدة' : 'Support Center',
            subtitle: isArabic
                ? 'تواصل معنا لحل أي مشكلة'
                : 'Get help and resolve any issues',
            isGlass: isGlass,
            onTap: () => _showSupportDialog(context, isArabic),
          ),
          _divider(context),
          // Feedback
          _buildSettingItem(
            context: context,
            icon: LucideIcons.messageSquare,
            iconColor: const Color(0xFF8B5CF6),
            title: isArabic ? 'إرسال ملاحظة' : 'Send Feedback',
            subtitle: isArabic
                ? 'شاركنا رأيك لتحسين التطبيق'
                : 'Share your thoughts to help improve the app',
            isGlass: isGlass,
            onTap: () => _showFeedbackDialog(context, isArabic, isGlass),
          ),
          _divider(context),
          // Rate App
          _buildSettingItem(
            context: context,
            icon: LucideIcons.star,
            iconColor: Colors.amberAccent,
            title: isArabic ? 'تقييم التطبيق' : 'Rate the App',
            subtitle: isArabic ? '⭐ دعمك يهمنا' : '⭐ Your support matters',
            isGlass: isGlass,
            onTap: () {
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isArabic
                        ? 'شكراً على دعمك! 🎉'
                        : 'Thank you for your support! 🎉',
                  ),
                  backgroundColor: Colors.amberAccent.shade700,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _buildAboutSection(BuildContext context, bool isArabic, bool isGlass) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Column(
        children: [
          _buildSettingItem(
            context: context,
            icon: LucideIcons.info,
            iconColor: const Color(0xFF4F46E5),
            title: isArabic ? 'حول التطبيق' : 'About App',
            subtitle: isArabic
                ? 'تفاصيل الإصدار والمطورين'
                : 'Version details and developer info',
            isGlass: isGlass,
            onTap: () => context.push('/about'),
          ),
          _divider(context),
          _buildSettingItem(
            context: context,
            icon: LucideIcons.shieldAlert,
            iconColor: Colors.grey,
            title: isArabic ? 'سياسة الخصوصية' : 'Privacy Policy',
            subtitle: isArabic
                ? 'شروط وقواعد استخدام بياناتك'
                : 'Terms and rules for data usage',
            isGlass: isGlass,
            onTap: () => context.push('/privacy-policy'),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _buildLogoutButton(BuildContext context, bool isArabic, bool isGlass) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(22),
      color: Colors.redAccent.withValues(alpha: isGlass ? 0.08 : 0.06),
      border: Border.all(
        color: Colors.redAccent.withValues(alpha: 0.3),
        width: 1.5,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.heavyImpact();
            ref.read(authControllerProvider.notifier).signOut();
            context.go('/login');
          },
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.logOut,
                  color: Colors.redAccent,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  isArabic ? 'تسجيل الخروج' : 'Log Out',
                  style: GoogleFonts.outfit(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _buildSettingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool isGlass,
    Color iconColor = Colors.white,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.15),
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).hintColor.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (trailing != null)
                trailing
              else if (onTap != null)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.chevronRight,
                    size: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch({
    required bool value,
    required Function(bool) onChanged,
    Color activeColor = Colors.blueAccent,
  }) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: Colors.white,
      activeTrackColor: activeColor,
      inactiveTrackColor: Colors.grey.withValues(alpha: 0.2),
      inactiveThumbColor: Colors.grey,
    );
  }

  Widget _divider(BuildContext context) => Divider(
    height: 1,
    color: Theme.of(context).dividerColor.withValues(alpha: 0.06),
    indent: 16,
    endIndent: 16,
  );

  // ─── Support Dialog ───
  void _showSupportDialog(BuildContext context, bool isArabic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E3A), Color(0xFF12122A)],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    LucideIcons.lifeBuoy,
                    color: Colors.cyanAccent,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic ? 'مركز الدعم' : 'Support Center',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      isArabic ? 'كيف يمكننا مساعدتك؟' : 'How can we help you?',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _supportOption(
              ctx,
              icon: LucideIcons.mail,
              color: const Color(0xFF6366F1),
              title: isArabic ? 'البريد الإلكتروني' : 'Email Support',
              subtitle: 'support@hue.university',
            ),
            const SizedBox(height: 12),
            _supportOption(
              ctx,
              icon: LucideIcons.phone,
              color: const Color(0xFF10B981),
              title: isArabic ? 'خط الدعم الساخن' : 'Call Hotline',
              subtitle: isArabic ? '+20 10 0000 0000' : '+20 10 0000 0000',
            ),
            const SizedBox(height: 12),
            _supportOption(
              ctx,
              icon: LucideIcons.messageCircle,
              color: const Color(0xFF25D366),
              title: 'WhatsApp',
              subtitle: isArabic
                  ? 'تواصل معنا عبر واتساب'
                  : 'Chat with us on WhatsApp',
            ),
          ],
        ),
      ),
    );
  }

  Widget _supportOption(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(LucideIcons.arrowRight, color: color, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Feedback Dialog ───
  void _showFeedbackDialog(BuildContext context, bool isArabic, bool isGlass) {
    final feedbackController = TextEditingController();
    int selectedRating = 5;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setStateLocal) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1E1E3A), Color(0xFF12122A)],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        LucideIcons.messageSquare,
                        color: Color(0xFF8B5CF6),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic ? 'إرسال ملاحظة' : 'Send Feedback',
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          isArabic
                              ? 'رأيك يساعدنا على التطوير'
                              : 'Your opinion helps us improve',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Star rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    final isSelected = i < selectedRating;
                    return GestureDetector(
                      onTap: () => setStateLocal(() => selectedRating = i + 1),
                      child:
                          Icon(
                                isSelected
                                    ? LucideIcons.star
                                    : LucideIcons.star,
                                size: 36,
                                color: isSelected
                                    ? Colors.amberAccent
                                    : Colors.white.withValues(alpha: 0.2),
                              )
                              .animate(target: isSelected ? 1 : 0)
                              .scale(
                                begin: const Offset(0.9, 0.9),
                                end: const Offset(1.1, 1.1),
                              ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                // Text field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: TextField(
                    controller: feedbackController,
                    maxLines: 4,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: isArabic
                          ? 'اكتب ملاحظتك هنا...'
                          : 'Write your feedback here...',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isArabic
                              ? '✅ شكراً! تم إرسال ملاحظتك بنجاح'
                              : '✅ Thank you! Feedback submitted.',
                        ),
                        backgroundColor: const Color(0xFF8B5CF6),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFF8B5CF6)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF7C3AED,
                          ).withValues(alpha: 0.35),
                          blurRadius: 14,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        isArabic ? 'إرسال الملاحظة' : 'Submit Feedback',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Theme / Style / Language ───
  Future<void> _handleThemeSwitch(bool isDark) async {
    final nextMode = isDark ? ThemeMode.dark : ThemeMode.light;
    HapticFeedback.mediumImpact();
    await ref.read(themeControllerProvider.notifier).setTheme(nextMode);
  }

  Future<void> _handleStyleSwitch() async {
    final currentStyle = ref.read(styleControllerProvider).value;
    final nextStyle = currentStyle == AppStyle.glass
        ? AppStyle.classic
        : AppStyle.glass;
    HapticFeedback.heavyImpact();
    await ref.read(styleControllerProvider.notifier).setStyle(nextStyle);
    if (!mounted) return;
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
    final isGlass = ref.read(styleControllerProvider).value == AppStyle.glass;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E3A), Color(0xFF12122A)],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              t.settings.select_app_language,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
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
              t.settings.deutsch,
              AppLocale.de,
              isGlass,
            ),
            _buildLanguageItem(
              context,
              '🇨🇳',
              t.settings.dynamic_val,
              AppLocale.zh,
              isGlass,
            ),
          ],
        ),
      ),
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
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? primaryColor.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          _handleLanguageSwitch(context, locale);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Text(
          emoji,
          style: const TextStyle(fontSize: 22, fontFamily: null),
        ),
        title: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 17,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: Colors.white,
          ),
        ),
        trailing: isSelected
            ? Icon(LucideIcons.checkCircle2, color: primaryColor)
            : null,
      ),
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

class _ParticlesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.2), 60, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.6), 100, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.9), 40, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.1), 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
