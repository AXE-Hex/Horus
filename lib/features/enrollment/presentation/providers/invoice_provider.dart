import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/enrollment/data/models/invoice_models.dart';
import 'package:horus/features/enrollment/data/repositories/enrollment_repository.dart';

final studentInvoicesProvider = FutureProvider.autoDispose<List<Invoice>>((
  ref,
) async {
  final auth = ref.watch(authControllerProvider);
  final userId = auth.user?.id;
  if (userId == null) return [];

  final repo = ref.read(enrollmentRepositoryProvider);
  return repo.getStudentInvoices(userId);
});

final invoiceSummaryProvider = FutureProvider.autoDispose<InvoiceSummary>((
  ref,
) async {
  final invoices = await ref.watch(studentInvoicesProvider.future);
  return InvoiceSummary.fromInvoices(invoices);
});

class InvoiceFilterNotifier extends Notifier<InvoiceStatus?> {
  @override
  InvoiceStatus? build() => null;

  void setFilter(InvoiceStatus? status) => state = status;
}

final invoiceFilterProvider =
    NotifierProvider<InvoiceFilterNotifier, InvoiceStatus?>(
      InvoiceFilterNotifier.new,
    );

final filteredInvoicesProvider = FutureProvider.autoDispose<List<Invoice>>((
  ref,
) async {
  final all = await ref.watch(studentInvoicesProvider.future);
  final filter = ref.watch(invoiceFilterProvider);
  if (filter == null) return all;
  return all.where((inv) => inv.status == filter).toList();
});
