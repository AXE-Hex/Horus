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
      case InvoiceStatus.refunded:
        return Colors.blueAccent;
      case InvoiceStatus.unknown:
        return Colors.grey;
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
      case InvoiceStatus.refunded:
        return LucideIcons.minusCircle;
      case InvoiceStatus.unknown:
        return LucideIcons.circleHelp;
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
                child: Icon(LucideIcons.receipt, color: _statusColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic && invoice.descriptionAr?.isNotEmpty == true
                          ? invoice.descriptionAr!
                          : invoice.description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isGlass ? Colors.white : null,
                      ),
                    ),
                    Text(
                      invoice.id,
                      style: TextStyle(
                        fontSize: 11,
                        color: isGlass ? Colors.white54 : Colors.grey.shade500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                      invoice.status.label,
                      style: TextStyle(
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
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: isGlass ? Colors.white : null,
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
                    style: TextStyle(
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
                style: TextStyle(
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
                  style: TextStyle(
                    fontSize: 11,
                    color: invoice.isOverdue
                        ? Colors.redAccent
                        : (isGlass ? Colors.white38 : Colors.grey.shade500),
                    fontWeight: invoice.isOverdue ? FontWeight.bold : null,
                  ),
                ),
              ],
              const Spacer(),
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
}
