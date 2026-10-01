part of 'settings_screen.dart';

extension _SettingsScreenItems on _SettingsScreenState {
  Widget _buildAboutSection(BuildContext context, bool isArabic, bool isGlass) {
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
            icon: LucideIcons.info,
            iconColor: const Color(0xFF4F46E5),
            title: t.extracted.about_app,
            subtitle: t.extracted.version_details_and_developer_info,
            isGlass: isGlass,
            onTap: () => context.push('/about'),
          ),
          _divider(context),
          _buildSettingItem(
            context: context,
            icon: LucideIcons.shieldAlert,
            iconColor: Colors.grey,
            title: t.extracted.privacy_policy,
            subtitle: t.extracted.terms_and_rules_for_data_usage,
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
                  t.extracted.log_out,
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
              SizedBox(width: 14),
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
                      SizedBox(height: 3),
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
              SizedBox(width: 8),
              if (trailing != null)
                trailing
              else if (onTap != null)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.05),
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
}
