part of 'settings_screen.dart';

extension _SettingsScreenSections on _SettingsScreenState {
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
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: () {
              context.go('/home');
            },
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
                    Color(0xFF1A0533),
                    themeColor.withValues(alpha: 0.8),
                    Color(0xFF0D1B2A),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            if (isGlass)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(painter: _ParticlesPainter()),
                ),
              ),

            Positioned(
              right: isArabic ? null : -60,
              left: isArabic ? -60 : null,
              top: -60,
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _glowController,
                  builder: (_, child) => Container(
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
            ),
            Positioned(
              right: isArabic ? null : -40,
              left: isArabic ? -40 : null,
              top: -40,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.07,
                  child: Icon(
                    LucideIcons.settings,
                    size: 260,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ).animate().rotate(duration: 20.seconds, curve: Curves.linear),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                                  colors: [themeColor, Color(0xFF10B981)],
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
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF0D1B2A),
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.08,
                                  ),
                                  backgroundImage:
                                      auth.profile?.avatarUrl != null
                                      ? NetworkImage(auth.profile!.avatarUrl!)
                                      : null,
                                  child: auth.profile?.avatarUrl == null
                                      ? Icon(
                                          LucideIcons.userCircle2,
                                          size: 55,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withValues(alpha: 0.7),
                                        )
                                      : null,
                                ),
                              ),
                            ).animate().scale(
                              duration: 600.ms,
                              curve: Curves.easeOutBack,
                            ),

                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: themeColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        (Theme.of(context).cardTheme.color ??
                                        Theme.of(context).cardColor),
                                    width: 2.5,
                                  ),
                                ),
                                child: Icon(
                                  LucideIcons.camera,
                                  size: 16,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                          auth.profile?.fullName ?? t.settings.user,
                          style: GoogleFonts.outfit(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: -0.5,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.2, end: 0),
                    SizedBox(height: 4),
                    Text(
                          auth.user?.email ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.55),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideY(begin: 0.2, end: 0),
                    SizedBox(height: 12),
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
                          Icon(
                            LucideIcons.shield,
                            size: 13,
                            color: Colors.greenAccent,
                          ),
                          SizedBox(width: 7),
                          Text(
                            auth.role.displayName(
                              isArabic:
                                  LocaleSettings.currentLocale == AppLocale.ar,
                            ),
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurface,
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
          SizedBox(width: 10),
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
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
      ),
      child: Column(
        children: [
          _buildSettingItem(
            context: context,
            icon: LucideIcons.userCog,
            iconColor: const Color(0xFF6366F1),
            title: t.extracted.edit_profile,
            subtitle: t.extracted.update_your_personal_info_and_photo,
            isGlass: isGlass,
            onTap: () => context.push('/profile'),
          ),
          _divider(context),
          _buildSettingItem(
            context: context,
            icon: LucideIcons.unlock,
            iconColor: Colors.orangeAccent,
            title: t.extracted.password_recovery,
            subtitle: t.extracted.send_password_recovery_link_to_your_emai,
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
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
      ),
      child: Column(
        children: [
          _buildSettingItem(
            context: context,
            icon: LucideIcons.moonStar,
            iconColor: const Color(0xFF7C3AED),
            title: t.extracted.dark_mode,
            subtitle: t.extracted.toggle_between_dark_and_light_mode,
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
            title: t.extracted.ui_style,
            subtitle: isGlass
                ? (t.extracted.current_glass_design)
                : (t.extracted.current_classic_design),
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
                t.extracted.kSwitch,
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
              title: t.extracted.battery_saver_mode,
              subtitle: t.extracted.disable_complex_visual_effects,
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
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
      ),
      child: Column(
        children: [
          _buildSettingItem(
            context: context,
            icon: LucideIcons.bellRing,
            iconColor: Colors.redAccent,
            title: t.extracted.app_notifications,
            subtitle: _notificationsEnabled
                ? (t.extracted.notifications_are_active)
                : (t.extracted.notifications_are_off),
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
            title: t.extracted.notification_center,
            subtitle: t.extracted.view_all_your_notifications,
            isGlass: isGlass,
            onTap: () => context.push('/notifications'),
          ),
          _divider(context),
          _buildSettingItem(
            context: context,
            icon: LucideIcons.bellDot,
            iconColor: Colors.orangeAccent,
            title: t.extracted.test_notification,
            subtitle: t.extracted.send_a_test_notification,
            isGlass: isGlass,
            onTap: () {
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        LucideIcons.bellRing,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 18,
                      ),
                      SizedBox(width: 12),
                      Text(
                        t.extracted.test_notification_sent,
                        style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
      ),
      child: _buildSettingItem(
        context: context,
        icon: LucideIcons.languages,
        iconColor: Colors.tealAccent,
        title: t.extracted.app_language,
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
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
      ),
      child: Column(
        children: [
          _buildSettingItem(
            context: context,
            icon: LucideIcons.lifeBuoy,
            iconColor: Colors.cyanAccent,
            title: t.extracted.support_center,
            subtitle: t.extracted.get_help_and_resolve_any_issues,
            isGlass: isGlass,
            onTap: () => _showSupportDialog(context, isArabic),
          ),
          _divider(context),

          _buildSettingItem(
            context: context,
            icon: LucideIcons.messageSquare,
            iconColor: const Color(0xFF8B5CF6),
            title: t.extracted.send_feedback,
            subtitle: t.extracted.share_your_thoughts_to_help_improve_the,
            isGlass: isGlass,
            onTap: () => _showFeedbackDialog(context, isArabic, isGlass),
          ),
          _divider(context),

          _buildSettingItem(
            context: context,
            icon: LucideIcons.star,
            iconColor: Colors.amberAccent,
            title: t.extracted.rate_the_app,
            subtitle: t.extracted.your_support_matters,
            isGlass: isGlass,
            onTap: () {
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.extracted.thank_you_for_your_support),
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
}
