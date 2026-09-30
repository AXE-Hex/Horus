part of 'settings_screen.dart';

extension _SettingsScreenPreferences on _SettingsScreenState {
  void _handleLanguageSwitch(BuildContext context, AppLocale nextLocale) {
    if (nextLocale == LocaleSettings.currentLocale) return;
    context.go(
      '/transition',
      extra: {
        'nextPath': '/settings',
        'message': t.settings.messages.changing_language,
        'isRefresh': true,
        'onComplete': () {
          LocalePreferences.set(nextLocale);
        },
      },
    );
  }

  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
    const isGlass = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
            ],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),
            Text(
              t.settings.select_app_language,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
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
        leading: Text(emoji, style: TextStyle(fontSize: 22, fontFamily: null)),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 17,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
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
