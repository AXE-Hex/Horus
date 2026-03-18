import 'package:hue/core/i18n/strings.g.dart';

enum InvoiceStatus { paid, unpaid, overdue, partial }

extension InvoiceStatusX on InvoiceStatus {
  String get dbValue => name;

  String label({bool isArabic = false}) {
    switch (this) {
      case InvoiceStatus.paid:
        return LocaleSettings.instance.currentTranslations.enrollment.paid;
      case InvoiceStatus.unpaid:
        return LocaleSettings.instance.currentTranslations.enrollment.unpaid;
      case InvoiceStatus.overdue:
        return LocaleSettings.instance.currentTranslations.enrollment.overdue;
      case InvoiceStatus.partial:
        return LocaleSettings.instance.currentTranslations.enrollment.partial;
    }
  }

  static InvoiceStatus fromString(String s) {
    return InvoiceStatus.values.firstWhere(
      (e) => e.name == s,
      orElse: () => InvoiceStatus.unpaid,
    );
  }
}

enum InvoiceType { tuition, registration, library, exam, dormitory, other }

extension InvoiceTypeX on InvoiceType {
  String label({bool isArabic = false}) {
    switch (this) {
      case InvoiceType.tuition:
        return LocaleSettings
            .instance
            .currentTranslations
            .enrollment
            .tuition_fee;
      case InvoiceType.registration:
        return LocaleSettings
            .instance
            .currentTranslations
            .enrollment
            .registration_fee;
      case InvoiceType.library:
        return LocaleSettings
            .instance
            .currentTranslations
            .enrollment
            .library_fee;
      case InvoiceType.exam:
        return LocaleSettings.instance.currentTranslations.enrollment.exam_fee;
      case InvoiceType.dormitory:
        return LocaleSettings
            .instance
            .currentTranslations
            .enrollment
            .dormitory_fee;
      case InvoiceType.other:
        return LocaleSettings.instance.currentTranslations.enrollment.other;
    }
  }

  static InvoiceType fromString(String? s) {
    return InvoiceType.values.firstWhere(
      (e) => e.name == s,
      orElse: () => InvoiceType.other,
    );
  }
}

class Invoice {
  final String id;
  final String studentId;
  final String invoiceNumber;
  final InvoiceType type;
  final InvoiceStatus status;
  final double amount;
  final double paidAmount;
  final String? semester;
  final DateTime? dueDate;
  final DateTime? paidAt;
  final String? receiptUrl;
  final String? notes;
  final DateTime createdAt;

  Invoice({
    required this.id,
    required this.studentId,
    required this.invoiceNumber,
    required this.type,
    required this.status,
    required this.amount,
    this.paidAmount = 0.0,
    this.semester,
    this.dueDate,
    this.paidAt,
    this.receiptUrl,
    this.notes,
    required this.createdAt,
  });

  double get remainingAmount => amount - paidAmount;
  bool get isPaid => status == InvoiceStatus.paid;
  bool get isOverdue =>
      status == InvoiceStatus.overdue ||
      (dueDate != null &&
          dueDate!.isBefore(DateTime.now()) &&
          status == InvoiceStatus.unpaid);

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] ?? '',
      studentId: json['student_id'] ?? '',
      invoiceNumber: json['invoice_number'] ?? json['id'] ?? '',
      type: InvoiceTypeX.fromString(json['type']),
      status: InvoiceStatusX.fromString(json['status'] ?? 'unpaid'),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      paidAmount: (json['paid_amount'] as num?)?.toDouble() ?? 0.0,
      semester: json['semester'],
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'])
          : null,
      paidAt: json['paid_at'] != null ? DateTime.parse(json['paid_at']) : null,
      receiptUrl: json['receipt_url'],
      notes: json['notes'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'student_id': studentId,
    'invoice_number': invoiceNumber,
    'type': type.name,
    'status': status.dbValue,
    'amount': amount,
    'paid_amount': paidAmount,
    'semester': semester,
    'due_date': dueDate?.toIso8601String(),
    'paid_at': paidAt?.toIso8601String(),
    'receipt_url': receiptUrl,
    'notes': notes,
  };

  Invoice copyWith({
    InvoiceStatus? status,
    double? paidAmount,
    DateTime? paidAt,
    String? receiptUrl,
  }) {
    return Invoice(
      id: id,
      studentId: studentId,
      invoiceNumber: invoiceNumber,
      type: type,
      status: status ?? this.status,
      amount: amount,
      paidAmount: paidAmount ?? this.paidAmount,
      semester: semester,
      dueDate: dueDate,
      paidAt: paidAt ?? this.paidAt,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      notes: notes,
      createdAt: createdAt,
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

    for (final inv in invoices) {
      if (inv.isPaid) {
        paid += inv.amount;
      } else {
        unpaid += inv.remainingAmount;
        unpaidCount++;
        if (inv.isOverdue) overdueCount++;
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
