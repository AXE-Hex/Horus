import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/shared/widgets/app_button.dart';
import 'package:horus/shared/widgets/app_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccessPendingScreen extends ConsumerWidget {
  const AccessPendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copy = t.auth.access_pending;
    final authError = ref.watch(authControllerProvider).error;
    final detail = switch (authError) {
      'profile_missing' => copy.profile_missing,
      'profile_load_failed' => copy.profile_load_failed,
      _ => copy.body,
    };
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.shieldAlert,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      copy.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(detail, textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(
                      text: copy.sign_out,
                      onPressed: () async {
                        await ref
                            .read(authControllerProvider.notifier)
                            .signOut();
                        if (context.mounted) context.go('/login');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
