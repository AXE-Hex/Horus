import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/enrollment/presentation/providers/invoice_provider.dart';
import 'package:horus/shared/widgets/app_card.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:horus/shared/widgets/horus_error_state.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(invoiceSummaryProvider);
    final colors = Theme.of(context).colorScheme;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(t.payment.title),
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => context.pop(),
          icon: const Icon(LucideIcons.arrowLeft),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: summary.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => HorusErrorState(
                message: t.enrollment.failed_to_load_invoices,
                onRetry: () => ref.invalidate(invoiceSummaryProvider),
              ),
              data: (value) {
                if (value.invoiceCount == 0) {
                  return HorusEmptyState(
                    icon: LucideIcons.receipt,
                    title: t.enrollment.no_invoices_found,
                  );
                }
                final locale = isArabic ? 'ar' : 'en';
                final amount = NumberFormat.currency(
                  locale: locale,
                  symbol: 'EGP ',
                  decimalDigits: 2,
                ).format(value.totalBalance);
                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    AppCard(
                      variant: AppCardVariant.academic,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              LucideIcons.wallet,
                              color: colors.primary,
                              size: 26,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              t.payment.outstanding,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              amount,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${value.unpaidCount} ${t.invoices.unpaid}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppCard(
                      child: ListTile(
                        leading: Icon(
                          LucideIcons.info,
                          color: colors.onSurfaceVariant,
                        ),
                        title: Text(t.invoices.title),
                        trailing: const Icon(LucideIcons.chevronRight),
                        onTap: () => context.push('/invoices'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () => context.push('/invoices'),
                      icon: const Icon(LucideIcons.receipt),
                      label: Text(t.invoices.title),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
