import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/enrollment/data/models/invoice_models.dart';

void main() {
  group('invoice database contract', () {
    test('maps the real SQL fields and payment status enum', () {
      final invoice = Invoice.fromJson({
        'id': 'fixture-invoice-id',
        'student_id': 'fixture-student-id',
        'semester': '2026-fall',
        'description': 'Tuition balance',
        'description_ar': 'رسوم دراسية',
        'currency': 'EGP',
        'status': 'pending',
        'amount': 1250.50,
        'due_date': '2026-10-15',
        'paid_at': null,
        'receipt_url': null,
        'created_at': '2026-09-01T12:00:00Z',
      });

      expect(invoice.description, 'Tuition balance');
      expect(invoice.descriptionAr, 'رسوم دراسية');
      expect(invoice.currency, 'EGP');
      expect(invoice.status, InvoiceStatus.unpaid);
      expect(invoice.amount, 1250.50);
      expect(invoice.remainingAmount, 1250.50);
    });

    test('unknown persisted statuses do not become unpaid', () {
      expect(
        InvoiceStatusX.fromDatabase('manual_review'),
        InvoiceStatus.unknown,
      );
      expect(InvoiceStatusX.fromDatabase('refunded'), InvoiceStatus.refunded);
      expect(InvoiceStatusX.fromDatabase('paid'), InvoiceStatus.paid);
    });

    test(
      'summary excludes refunded and unknown amounts from the due balance',
      () {
        final base = {
          'student_id': 'fixture-student-id',
          'semester': '2026-fall',
          'description': 'Test fixture invoice',
          'currency': 'EGP',
          'amount': 100,
          'created_at': '2026-09-01T12:00:00Z',
        };
        final invoices = [
          Invoice.fromJson({...base, 'id': 'pending', 'status': 'pending'}),
          Invoice.fromJson({...base, 'id': 'paid', 'status': 'paid'}),
          Invoice.fromJson({...base, 'id': 'refunded', 'status': 'refunded'}),
          Invoice.fromJson({
            ...base,
            'id': 'unknown',
            'status': 'manual_review',
          }),
        ];
        final summary = InvoiceSummary.fromInvoices(invoices);

        expect(summary.totalBalance, 100);
        expect(summary.paidTotal, 100);
        expect(summary.unpaidCount, 1);
      },
    );
  });
}
