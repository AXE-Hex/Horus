import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/enrollment/data/models/invoice_models.dart';
import 'package:hue/features/enrollment/data/repositories/enrollment_repository.dart';

// ──────────────────────────────────────────────
// Repository Provider
// ──────────────────────────────────────────────
final enrollmentRepositoryProvider = Provider<EnrollmentRepository>((ref) {
  return EnrollmentRepository(Supabase.instance.client);
});

// ──────────────────────────────────────────────
// Invoices List Provider
// Real-time aware; re-fetches when auth changes.
// ──────────────────────────────────────────────
final studentInvoicesProvider = FutureProvider.autoDispose<List<Invoice>>((
  ref,
) async {
  final auth = ref.watch(authControllerProvider);
  final userId = auth.user?.id;
  if (userId == null) return [];

  final repo = ref.read(enrollmentRepositoryProvider);
  final raw = await repo.getStudentInvoices(userId);
  return raw.map((e) => Invoice.fromJson(e)).toList();
});

// ──────────────────────────────────────────────
// Invoice Summary Provider (derived)
// ──────────────────────────────────────────────
final invoiceSummaryProvider = FutureProvider.autoDispose<InvoiceSummary>((
  ref,
) async {
  final invoices = await ref.watch(studentInvoicesProvider.future);
  return InvoiceSummary.fromInvoices(invoices);
});

// ──────────────────────────────────────────────
// Invoice Filter Notifier (replaces StateProvider)
// Holds the currently selected filter tab
// ──────────────────────────────────────────────
class InvoiceFilterNotifier extends Notifier<InvoiceStatus?> {
  @override
  InvoiceStatus? build() => null;

  void setFilter(InvoiceStatus? status) => state = status;
}

final invoiceFilterProvider =
    NotifierProvider<InvoiceFilterNotifier, InvoiceStatus?>(
      InvoiceFilterNotifier.new,
    );

// ──────────────────────────────────────────────
// Filtered Invoices (combines all + filter)
// ──────────────────────────────────────────────
final filteredInvoicesProvider = FutureProvider.autoDispose<List<Invoice>>((
  ref,
) async {
  final all = await ref.watch(studentInvoicesProvider.future);
  final filter = ref.watch(invoiceFilterProvider);
  if (filter == null) return all;
  return all.where((inv) => inv.status == filter).toList();
});

// ──────────────────────────────────────────────
// Mark Invoice Paid Action
// ──────────────────────────────────────────────
class InvoiceActionsNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> markAsPaid(String invoiceId, {String? receiptUrl}) async {
    final repo = ref.read(enrollmentRepositoryProvider);
    await repo.markInvoicePaid(invoiceId, receiptUrl: receiptUrl);
    ref.invalidate(studentInvoicesProvider);
  }
}

final invoiceActionsProvider =
    AsyncNotifierProvider<InvoiceActionsNotifier, void>(
      InvoiceActionsNotifier.new,
    );
