part of 'invoices_screen.dart';

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
