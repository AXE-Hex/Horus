part of 'invoices_screen.dart';

class _InvoicesList extends ConsumerWidget {
  final bool isArabic;
  final bool isGlass;

  const _InvoicesList({required this.isArabic, required this.isGlass});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(filteredInvoicesProvider);

    return invoicesAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: _ErrorWidget(
          isArabic: isArabic,
          isGlass: isGlass,
          error: e.toString(),
        ),
      ),
      data: (invoices) {
        if (invoices.isEmpty) {
          return SliverToBoxAdapter(
            child: _EmptyState(isArabic: isArabic, isGlass: isGlass),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child:
                    _InvoiceCard(
                          invoice: invoices[index],
                          isArabic: isArabic,
                          isGlass: isGlass,
                        )
                        .animate(delay: (index * 80).ms)
                        .fadeIn()
                        .slideY(begin: 0.08, end: 0),
              );
            }, childCount: invoices.length),
          ),
        );
      },
    );
  }
}
