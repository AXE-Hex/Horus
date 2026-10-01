part of 'invoices_screen.dart';

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

String _formatAmount(double amount) {
  final formatted = NumberFormat('#,##0', 'en').format(amount);
  return '$formatted EGP';
}
