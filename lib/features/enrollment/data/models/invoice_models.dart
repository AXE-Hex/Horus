import 'package:horus/core/data/db_row.dart';
import 'package:horus/core/i18n/strings.g.dart';

enum InvoiceStatus { paid, unpaid, overdue, refunded, unknown }

extension InvoiceStatusX on InvoiceStatus {
  String get dbValue => switch (this) {
    InvoiceStatus.unpaid => 'pending',
    InvoiceStatus.paid => 'paid',
    InvoiceStatus.overdue => 'overdue',
    InvoiceStatus.refunded => 'refunded',
    InvoiceStatus.unknown => throw StateError(
      'Unknown invoice status cannot be written.',
    ),
  };

  String get label {
    final enrollment = LocaleSettings.instance.currentTranslations.enrollment;
    return switch (this) {
      InvoiceStatus.paid => enrollment.paid,
      InvoiceStatus.unpaid => enrollment.unpaid,
      InvoiceStatus.overdue => enrollment.overdue,
      InvoiceStatus.refunded => enrollment.refunded,
      InvoiceStatus.unknown => enrollment.unknown_status,
    };
  }

  static InvoiceStatus fromDatabase(String? status) => switch (status) {
    'paid' => InvoiceStatus.paid,
    'pending' => InvoiceStatus.unpaid,
    'overdue' => InvoiceStatus.overdue,
    'refunded' => InvoiceStatus.refunded,
    _ => InvoiceStatus.unknown,
  };
}

class Invoice {
  const Invoice({
    required this.id,
    required this.studentId,
    required this.description,
    this.descriptionAr,
    required this.currency,
    required this.status,
    required this.amount,
    this.semester,
    this.dueDate,
    this.paidAt,
    this.receiptUrl,
    required this.createdAt,
  });

  final String id;
  final String studentId;
  final String description;
  final String? descriptionAr;
  final String currency;
  final InvoiceStatus status;
  final double amount;
  final String? semester;
  final DateTime? dueDate;
  final DateTime? paidAt;
  final String? receiptUrl;
  final DateTime createdAt;

  double get paidAmount => status == InvoiceStatus.paid ? amount : 0;

  double get remainingAmount => switch (status) {
    InvoiceStatus.unpaid || InvoiceStatus.overdue => amount,
    _ => 0,
  };

  bool get isPaid => status == InvoiceStatus.paid;

  bool get isOverdue =>
      status == InvoiceStatus.overdue ||
      (dueDate != null &&
          dueDate!.isBefore(DateTime.now()) &&
          status == InvoiceStatus.unpaid);

  factory Invoice.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'invoices');
    return Invoice(
      id: row.requiredString('id'),
      studentId: row.requiredString('student_id'),
      description: row.requiredString('description'),
      descriptionAr: row.optionalString('description_ar'),
      currency: row.requiredString('currency'),
      status: InvoiceStatusX.fromDatabase(row.optionalString('status')),
      amount: row.requiredDouble('amount'),
      semester: row.optionalString('semester'),
      dueDate: row.optionalDateTime('due_date'),
      paidAt: row.optionalDateTime('paid_at'),
      receiptUrl: row.optionalString('receipt_url'),
      createdAt: row.requiredDateTime('created_at'),
    );
  }
}

class InvoiceSummary {
  final double totalBalance;
  final double paidTotal;
  final double unpaidTotal;
  final int invoiceCount;
  final int unpaidCount;
  final int overdueCount;

  const InvoiceSummary({
    required this.totalBalance,
    required this.paidTotal,
    required this.unpaidTotal,
    required this.invoiceCount,
    required this.unpaidCount,
    required this.overdueCount,
  });

  factory InvoiceSummary.fromInvoices(List<Invoice> invoices) {
    double paid = 0, unpaid = 0;
    int unpaidCount = 0, overdueCount = 0;

    for (final invoice in invoices) {
      if (invoice.isPaid) {
        paid += invoice.amount;
      } else if (invoice.status == InvoiceStatus.unpaid ||
          invoice.status == InvoiceStatus.overdue) {
        unpaid += invoice.remainingAmount;
        unpaidCount++;
        if (invoice.isOverdue) overdueCount++;
      }
    }

    return InvoiceSummary(
      totalBalance: unpaid,
      paidTotal: paid,
      unpaidTotal: unpaid,
      invoiceCount: invoices.length,
      unpaidCount: unpaidCount,
      overdueCount: overdueCount,
    );
  }
}
