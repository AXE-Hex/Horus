import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/enrollment/data/models/invoice_models.dart';
import 'package:hue/features/enrollment/presentation/providers/invoice_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

// ──────────────────────────────────────────────────────────────────────────────
// InvoicesScreen — Complete Rebuild with full Supabase-connected sections
// ──────────────────────────────────────────────────────────────────────────────
class InvoicesScreen extends ConsumerWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ── 1. Immersive App Bar ────────────────────────────────────────────
        _InvoicesAppBar(isArabic: isArabic, isGlass: isGlass),

        // ── 2. Financial Summary Card ────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: _FinancialSummaryCard(isArabic: isArabic, isGlass: isGlass),
          ),
        ),

        // ── 3. Quick Actions Row ────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: _QuickActionsRow(isArabic: isArabic, isGlass: isGlass),
          ),
        ),

        // ── 4. Filter Tabs ───────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: _FilterTabBar(isArabic: isArabic, isGlass: isGlass),
          ),
        ),

        // ── 5. Section title: Invoices ───────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Text(
              t.enrollment.invoices,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ),
        ),

        // ── 6. Invoices List ─────────────────────────────────────────────────
        _InvoicesList(isArabic: isArabic, isGlass: isGlass),

        // bottom padding
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 1. Immersive App Bar
// ──────────────────────────────────────────────────────────────────────────────
class _InvoicesAppBar extends StatelessWidget {
  final bool isArabic;
  final bool isGlass;

  const _InvoicesAppBar({required this.isArabic, required this.isGlass});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: isGlass ? Colors.transparent : null,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          isArabic ? LucideIcons.arrowRight : LucideIcons.arrowLeft,
          color: Colors.white,
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient background
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF10B981),
                    const Color(0xFF059669),
                    const Color(0xFF047857),
                  ],
                ),
              ),
            ),
            // Decorative icon background
            Positioned(
              right: isArabic ? null : -40,
              left: isArabic ? -40 : null,
              bottom: -60,
              child: Opacity(
                opacity: 0.07,
                child: Icon(
                  LucideIcons.receipt,
                  size: 280,
                  color: Colors.white,
                ),
              ),
            ),
            // Header content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        t.enrollment.financial_portal,
                        style: GoogleFonts.shareTechMono(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t.enrollment.my_invoices,
                      style: GoogleFonts.outfit(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      t.enrollment.manage_your_tuition_and_paymen,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 2. Financial Summary Card — connects to invoiceSummaryProvider
// ──────────────────────────────────────────────────────────────────────────────
class _FinancialSummaryCard extends ConsumerWidget {
  final bool isArabic;
  final bool isGlass;

  const _FinancialSummaryCard({required this.isArabic, required this.isGlass});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(invoiceSummaryProvider);

    return summaryAsync.when(
      loading: () => _SummaryCardShimmer(isGlass: isGlass),
      error: (e, _) => _SummaryCardError(
        isArabic: isArabic,
        isGlass: isGlass,
        error: e.toString(),
      ),
      data: (summary) {
        final content = Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      LucideIcons.wallet,
                      color: Color(0xFF10B981),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      t.enrollment.financial_summary,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isGlass ? Colors.white70 : null,
                      ),
                    ),
                  ),
                  if (summary.overdueCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        t.enrollment.summaryoverduecount_overdue(count: summary.overdueCount),
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              // Outstanding balance (big)
              Text(
                _formatAmount(summary.totalBalance),
                style: GoogleFonts.shareTechMono(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: summary.totalBalance > 0
                      ? Colors.redAccent
                      : const Color(0xFF10B981),
                ),
              ),
              Text(
                t.enrollment.outstanding_balance,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: isGlass ? Colors.white60 : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),
              // Mini stats row
              Row(
                children: [
                  _MiniStat(
                    label: t.enrollment.paid,
                    value: _formatAmount(summary.paidTotal),
                    color: const Color(0xFF10B981),
                    isGlass: isGlass,
                  ),
                  _VertDivider(isGlass: isGlass),
                  _MiniStat(
                    label: t.enrollment.total_invoices,
                    value: summary.invoiceCount.toString(),
                    color: const Color(0xFF6366F1),
                    isGlass: isGlass,
                  ),
                  _VertDivider(isGlass: isGlass),
                  _MiniStat(
                    label: t.enrollment.unpaid,
                    value: summary.unpaidCount.toString(),
                    color: Colors.orangeAccent,
                    isGlass: isGlass,
                  ),
                ],
              ),
              // Pay now button if there's balance
              if (summary.totalBalance > 0) ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.push('/payment'),
                    icon: const Icon(LucideIcons.creditCard, size: 18),
                    label: Text(
                      t.enrollment.pay_now,
                      style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );

        return (isGlass
                ? GlassContainer(
                    borderRadius: BorderRadius.circular(28),
                    padding: EdgeInsets.zero,
                    border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.2),
                    ),
                    child: content,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: const Color(0xFF10B981).withValues(alpha: 0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF10B981,
                          ).withValues(alpha: 0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: content,
                  ))
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.1, end: 0);
      },
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 3. Quick Actions Row
// ──────────────────────────────────────────────────────────────────────────────
class _QuickActionsRow extends ConsumerWidget {
  final bool isArabic;
  final bool isGlass;

  const _QuickActionsRow({required this.isArabic, required this.isGlass});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = [
      (
        icon: LucideIcons.creditCard,
        label: t.enrollment.pay,
        color: const Color(0xFF6366F1),
        onTap: () => context.push('/payment'),
      ),
      (
        icon: LucideIcons.fileDown,
        label: t.enrollment.download,
        color: const Color(0xFF10B981),
        onTap: () => _showDownloadSnack(context, isArabic),
      ),
      (
        icon: LucideIcons.history,
        label: t.enrollment.history,
        color: const Color(0xFFF59E0B),
        onTap: () {
          ref
              .read(invoiceFilterProvider.notifier)
              .setFilter(InvoiceStatus.paid);
        },
      ),
      (
        icon: LucideIcons.helpCircle,
        label: t.enrollment.help,
        color: Colors.pinkAccent,
        onTap: () => context.push('/support'),
      ),
    ];

    return Row(
      children: actions
          .map(
            (a) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _QuickActionBtn(
                  icon: a.icon,
                  label: a.label,
                  color: a.color,
                  isGlass: isGlass,
                  onTap: a.onTap,
                ),
              ),
            ),
          )
          .toList(),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }

  void _showDownloadSnack(BuildContext context, bool isArabic) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF10B981),
        content: Text(t.enrollment.preparing_pdf_statement),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _QuickActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isGlass;
  final VoidCallback onTap;

  const _QuickActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.isGlass,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final inner = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isGlass ? 0.08 : 0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
    return inner;
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 4. Filter Tab Bar — connected to invoiceFilterProvider
// ──────────────────────────────────────────────────────────────────────────────
class _FilterTabBar extends ConsumerWidget {
  final bool isArabic;
  final bool isGlass;

  const _FilterTabBar({required this.isArabic, required this.isGlass});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(invoiceFilterProvider);

    final tabs = [
      (value: null, label: t.enrollment.all),
      (value: InvoiceStatus.unpaid, label: t.enrollment.unpaid),
      (value: InvoiceStatus.paid, label: t.enrollment.paid),
      (value: InvoiceStatus.overdue, label: t.enrollment.overdue),
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final tab = tabs[i];
          final isActive = selected == tab.value;
          return GestureDetector(
            onTap: () {
              ref.read(invoiceFilterProvider.notifier).setFilter(tab.value);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF10B981)
                    : (isGlass
                          ? Colors.white.withValues(alpha: 0.08)
                          : Theme.of(context).cardColor),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isActive
                      ? const Color(0xFF10B981)
                      : Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                tab.label,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? Colors.white
                      : (isGlass ? Colors.white60 : Colors.grey.shade600),
                ),
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(delay: 300.ms);
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 5. Invoices List — connected to filteredInvoicesProvider
// ──────────────────────────────────────────────────────────────────────────────
class _InvoicesList extends ConsumerWidget {
  final bool isArabic;
  final bool isGlass;

  const _InvoicesList({required this.isArabic, required this.isGlass});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(filteredInvoicesProvider);

    return invoicesAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: _ErrorWidget(
          isArabic: isArabic,
          isGlass: isGlass,
          error: e.toString(),
        ),
      ),
      data: (invoices) {
        if (invoices.isEmpty) {
          return SliverToBoxAdapter(
            child: _EmptyState(isArabic: isArabic, isGlass: isGlass),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child:
                    _InvoiceCard(
                          invoice: invoices[index],
                          isArabic: isArabic,
                          isGlass: isGlass,
                        )
                        .animate(delay: (index * 80).ms)
                        .fadeIn()
                        .slideY(begin: 0.08, end: 0),
              );
            }, childCount: invoices.length),
          ),
        );
      },
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Invoice Card — rich design with status color coding
// ──────────────────────────────────────────────────────────────────────────────
class _InvoiceCard extends ConsumerWidget {
  final Invoice invoice;
  final bool isArabic;
  final bool isGlass;

  const _InvoiceCard({
    required this.invoice,
    required this.isArabic,
    required this.isGlass,
  });

  Color get _statusColor {
    switch (invoice.status) {
      case InvoiceStatus.paid:
        return const Color(0xFF10B981);
      case InvoiceStatus.unpaid:
        return Colors.orangeAccent;
      case InvoiceStatus.overdue:
        return Colors.redAccent;
      case InvoiceStatus.partial:
        return Colors.blueAccent;
    }
  }

  IconData get _statusIcon {
    switch (invoice.status) {
      case InvoiceStatus.paid:
        return LucideIcons.checkCircle2;
      case InvoiceStatus.unpaid:
        return LucideIcons.clock;
      case InvoiceStatus.overdue:
        return LucideIcons.alertTriangle;
      case InvoiceStatus.partial:
        return LucideIcons.minusCircle;
    }
  }

  IconData get _typeIcon {
    switch (invoice.type) {
      case InvoiceType.tuition:
        return LucideIcons.graduationCap;
      case InvoiceType.registration:
        return LucideIcons.clipboardList;
      case InvoiceType.library:
        return LucideIcons.bookOpen;
      case InvoiceType.exam:
        return LucideIcons.fileText;
      case InvoiceType.dormitory:
        return LucideIcons.home;
      case InvoiceType.other:
        return LucideIcons.receipt;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateStr = DateFormat(
      t.enrollment.mmm_dd_yyyy,
    ).format(invoice.createdAt);
    final dueDateStr = invoice.dueDate != null
        ? DateFormat(t.enrollment.mmm_dd_yyyy).format(invoice.dueDate!)
        : null;

    final content = Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: type icon + invoice number + status badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(_typeIcon, color: _statusColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.type.label(isArabic: isArabic),
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isGlass ? Colors.white : null,
                      ),
                    ),
                    Text(
                      '#${invoice.invoiceNumber}',
                      style: GoogleFonts.shareTechMono(
                        fontSize: 11,
                        color: isGlass ? Colors.white54 : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_statusIcon, size: 12, color: _statusColor),
                    const SizedBox(width: 4),
                    Text(
                      invoice.status.label(isArabic: isArabic),
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(
            color: isGlass
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.grey.withValues(alpha: 0.1),
            height: 1,
          ),
          const SizedBox(height: 16),

          // Middle: amount + semester
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatAmount(invoice.amount),
                    style: GoogleFonts.shareTechMono(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: isGlass ? Colors.white : null,
                    ),
                  ),
                  if (!invoice.isPaid && invoice.paidAmount > 0)
                    Text(
                      '${t.enrollment.remaining}${_formatAmount(invoice.remainingAmount)}',
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              if (invoice.semester != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    invoice.semester!,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      color: const Color(0xFF6366F1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Bottom row: dates
          Row(
            children: [
              Icon(
                LucideIcons.calendar,
                size: 12,
                color: isGlass ? Colors.white38 : Colors.grey.shade400,
              ),
              const SizedBox(width: 4),
              Text(
                dateStr,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: isGlass ? Colors.white38 : Colors.grey.shade500,
                ),
              ),
              if (dueDateStr != null) ...[
                const SizedBox(width: 12),
                Icon(
                  LucideIcons.alertCircle,
                  size: 12,
                  color: invoice.isOverdue
                      ? Colors.redAccent
                      : (isGlass ? Colors.white38 : Colors.grey.shade400),
                ),
                const SizedBox(width: 4),
                Text(
                  '${t.enrollment.due}$dueDateStr',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: invoice.isOverdue
                        ? Colors.redAccent
                        : (isGlass ? Colors.white38 : Colors.grey.shade500),
                    fontWeight: invoice.isOverdue ? FontWeight.bold : null,
                  ),
                ),
              ],
              const Spacer(),
              // Pay button for unpaid invoices
              if (!invoice.isPaid)
                GestureDetector(
                  onTap: () => _showPayDialog(context, ref),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      t.enrollment.pay,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(24),
            padding: EdgeInsets.zero,
            border: Border.all(color: _statusColor.withValues(alpha: 0.15)),
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _statusColor.withValues(alpha: 0.15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: content,
          );
  }

  void _showPayDialog(BuildContext context, WidgetRef ref) {
    final isArabicLocal = isArabic;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Colors.white10),
        ),
        title: Text(
          isArabicLocal ? 'تأكيد الدفع' : 'Confirm Payment',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              LucideIcons.creditCard,
              color: Color(0xFF10B981),
              size: 50,
            ),
            const SizedBox(height: 16),
            Text(
              _formatAmount(invoice.remainingAmount),
              style: GoogleFonts.shareTechMono(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              invoice.type.label(isArabic: isArabicLocal),
              style: GoogleFonts.outfit(fontSize: 14, color: Colors.white60),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              isArabicLocal ? 'إلغاء' : 'Cancel',
              style: const TextStyle(color: Colors.white60),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref
                  .read(invoiceActionsProvider.notifier)
                  .markAsPaid(invoice.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF10B981),
                    content: Text(
                      isArabicLocal ? 'تم الدفع بنجاح!' : 'Payment successful!',
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            child: Text(
              isArabicLocal ? 'تأكيد' : 'Confirm',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Helper Widgets
// ──────────────────────────────────────────────────────────────────────────────
class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isGlass;

  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
    required this.isGlass,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.shareTechMono(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: isGlass ? Colors.white54 : Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _VertDivider extends StatelessWidget {
  final bool isGlass;
  const _VertDivider({required this.isGlass});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: isGlass ? Colors.white12 : Colors.grey.withValues(alpha: 0.15),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isArabic;
  final bool isGlass;

  const _EmptyState({required this.isArabic, required this.isGlass});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Icon(
            LucideIcons.receipt,
            size: 72,
            color: isGlass ? Colors.white24 : Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          Text(
            t.enrollment.no_invoices_found,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isGlass ? Colors.white60 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.enrollment.your_account_is_clearnno_invoi,
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: isGlass ? Colors.white38 : Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9));
  }
}

class _ErrorWidget extends StatelessWidget {
  final bool isArabic;
  final bool isGlass;
  final String error;

  const _ErrorWidget({
    required this.isArabic,
    required this.isGlass,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(LucideIcons.serverCrash, size: 50, color: Colors.redAccent),
          const SizedBox(height: 12),
          Text(
            t.enrollment.failed_to_load_invoices,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            error,
            style: GoogleFonts.outfit(
              fontSize: 11,
              color: isGlass ? Colors.white38 : Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SummaryCardShimmer extends StatelessWidget {
  final bool isGlass;
  const _SummaryCardShimmer({required this.isGlass});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: isGlass
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _SummaryCardError extends StatelessWidget {
  final bool isArabic;
  final bool isGlass;
  final String error;

  const _SummaryCardError({
    required this.isArabic,
    required this.isGlass,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: Text(
          t.enrollment.error_loading_summary,
          style: GoogleFonts.outfit(color: Colors.redAccent),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Utility
// ──────────────────────────────────────────────────────────────────────────────
String _formatAmount(double amount) {
  final formatted = NumberFormat('#,##0', 'en').format(amount);
  return '$formatted EGP';
}
