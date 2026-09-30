import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:horus/features/shared/data/shared_data_providers.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:horus/shared/widgets/horus_error_state.dart';
import 'package:horus/shared/widgets/app_card.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SessionsScreen extends ConsumerWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(userSessionsProvider);
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(
        title: Text(t.shared.active_sessions),
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => context.pop(),
          icon: const Icon(LucideIcons.arrowLeft),
        ),
      ),
      body: sessions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => HorusErrorState(
          message: t.enrollment.error_loading,
          onRetry: () => ref.invalidate(userSessionsProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return HorusEmptyState(
              icon: LucideIcons.monitorSmartphone,
              title: t.academic.no_data,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final session = items[index];
              final date = DateFormat.yMMMd(
                isArabic ? 'ar' : 'en',
              ).add_jm().format(session.lastActive.toLocal());
              final device = session.deviceName?.trim().isNotEmpty == true
                  ? session.deviceName!.trim()
                  : t.shared.device;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(_deviceIcon(session.deviceType)),
                    title: Text(device),
                    subtitle: Text(
                      session.location == null || session.location!.isEmpty
                          ? date
                          : '${session.location} · $date',
                    ),
                    trailing: session.isActive
                        ? Icon(
                            LucideIcons.circleCheck,
                            color: Theme.of(context).colorScheme.primary,
                            semanticLabel: t.shared.active_sessions,
                          )
                        : null,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _deviceIcon(SessionDevice type) => switch (type) {
    SessionDevice.mobile => LucideIcons.smartphone,
    SessionDevice.desktop => LucideIcons.monitor,
    SessionDevice.tablet => LucideIcons.tablet,
    SessionDevice.unknown => LucideIcons.monitorSmartphone,
  };
}
