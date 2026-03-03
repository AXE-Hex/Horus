
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SecurityScreen extends ConsumerWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 120,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: Text(
            t.shared.security,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSecuritySection(
                  context,
                  t.shared.authentication,
                  [
                    _buildSwitchTile(
                      context,
                      t.shared.biometric_login,
                      t.shared.use_fingerprint_or_face_id,
                      true,
                      isGlass,
                    ),
                    _buildSwitchTile(
                      context,
                      t.shared.twofactor_auth,
                      t.shared.protect_account_with_2fa,
                      false,
                      isGlass,
                    ),
                  ],
                  isGlass,
                ),
                const SizedBox(height: 24),
                _buildSecuritySection(
                  context,
                  t.shared.device_management,
                  [
                    _buildActionTile(
                      context,
                      t.shared.view_active_sessions,
                      t.shared.manage_logged_in_devices,
                      LucideIcons.monitor,
                      () => context.push('/sessions'),
                      isGlass,
                    ),
                    _buildActionTile(
                      context,
                      t.shared.change_password,
                      t.shared.update_your_login_credentials,
                      LucideIcons.key,
                      () {},
                      isGlass,
                    ),
                  ],
                  isGlass,
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildSecuritySection(
    BuildContext context,
    String title,
    List<Widget> items,
    bool isGlass,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isGlass
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) =>
              Padding(padding: const EdgeInsets.only(bottom: 8), child: item),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    String desc,
    bool value,
    bool isGlass,
  ) {
    final content = SwitchListTile(
      value: value,
      onChanged: (val) {},
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: isGlass ? Colors.white : null,
        ),
      ),
      subtitle: Text(
        desc,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Theme.of(context).hintColor,
        ),
      ),
      activeThumbColor: Theme.of(context).primaryColor,
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(16),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: content,
          );
  }

  Widget _buildActionTile(
    BuildContext context,
    String title,
    String desc,
    IconData icon,
    VoidCallback onTap,
    bool isGlass,
  ) {
    final content = ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: isGlass ? Colors.white : null,
        ),
      ),
      subtitle: Text(
        desc,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Theme.of(context).hintColor,
        ),
      ),
      trailing: Icon(
        LucideIcons.chevronRight,
        size: 18,
        color: Theme.of(context).hintColor,
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(16),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: content,
          );
  }
}
