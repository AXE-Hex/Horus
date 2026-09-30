import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/router/route_guard.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/shared/widgets/app_card.dart';

class ControlDashboardScreen extends ConsumerWidget {
  const ControlDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final actions =
        <(String, String, IconData)>[
              (
                '/dean-assignment',
                t.academic.students,
                Icons.supervisor_account_outlined,
              ),
              (
                '/advisor-approval',
                t.registration.title,
                Icons.fact_check_outlined,
              ),
              ('/registration', t.registration.title, Icons.app_registration),
              ('/courses', t.academic.course_management, Icons.school_outlined),
              (
                '/professor-dashboard',
                t.academic.academic_results,
                Icons.analytics_outlined,
              ),
              (
                '/attendance',
                t.attendance.title,
                Icons.event_available_outlined,
              ),
              ('/invoices', t.invoices.title, Icons.receipt_long_outlined),
              (
                '/home',
                t.students.horus_university,
                Icons.account_balance_outlined,
              ),
            ]
            .where((action) => canAccessRoute(action.$1, auth.permissionCodes))
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(t.control.title),
        actions: [
          IconButton(
            tooltip: t.settings.title,
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            children: [
              AppCard(
                variant: AppCardVariant.academic,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auth.profile?.fullName ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      auth.profile?.roles
                              .map((role) => role.displayName())
                              .join(' · ') ??
                          '',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(t.control.subtitle),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 900
                      ? 3
                      : constraints.maxWidth >= 580
                      ? 2
                      : 1;
                  final width =
                      (constraints.maxWidth - AppSpacing.lg * (columns - 1)) /
                      columns;
                  return Wrap(
                    spacing: AppSpacing.lg,
                    runSpacing: AppSpacing.lg,
                    children: [
                      for (final action in actions)
                        SizedBox(
                          width: width,
                          child: AppCard(
                            onTap: () => context.push(action.$1),
                            child: Row(
                              children: [
                                Icon(
                                  action.$3,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(child: Text(action.$2)),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
