part of 'invoices_screen.dart';

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
        onPressed: () => context.backToHorus(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
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
                        t.enrollment.summaryoverduecount_overdue(
                          count: summary.overdueCount,
                        ),
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
