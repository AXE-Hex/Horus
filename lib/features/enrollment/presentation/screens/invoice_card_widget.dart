part of 'invoices_screen.dart';

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
  Widget build(BuildContext context, WidgetRef _) {
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

              if (!invoice.isPaid)
                GestureDetector(
                  onTap: () => _showPayDialog(context),
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

  void _showPayDialog(BuildContext context) {
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
            onPressed: () {
              Navigator.pop(ctx);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.orangeAccent,
                    content: Text(t.shared.coming_soon),
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
