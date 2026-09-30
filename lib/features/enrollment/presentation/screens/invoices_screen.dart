import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/features/enrollment/data/models/invoice_models.dart';
import 'package:horus/features/enrollment/presentation/providers/invoice_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

part 'invoice_summary_widgets.dart';
part 'invoice_actions_widgets.dart';
part 'invoice_list_widgets.dart';
part 'invoice_card_widget.dart';
part 'invoice_state_widgets.dart';

class InvoicesScreen extends ConsumerWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    const isGlass = false;

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _InvoicesAppBar(isArabic: isArabic, isGlass: isGlass),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: _FinancialSummaryCard(isArabic: isArabic, isGlass: isGlass),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: _QuickActionsRow(isGlass: isGlass),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: _FilterTabBar(isArabic: isArabic, isGlass: isGlass),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Text(
              t.enrollment.invoices,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: null,
              ),
            ),
          ),
        ),

        _InvoicesList(isArabic: isArabic, isGlass: isGlass),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    return Scaffold(body: body);
  }
}
