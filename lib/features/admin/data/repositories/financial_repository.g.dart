part of 'financial_repository.dart';

@ProviderFor(financialRepository)
final financialRepositoryProvider = FinancialRepositoryProvider._();

final class FinancialRepositoryProvider
    extends
        $FunctionalProvider<
          FinancialRepository,
          FinancialRepository,
          FinancialRepository
        >
    with $Provider<FinancialRepository> {
  FinancialRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financialRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financialRepositoryHash();

  @$internal
  @override
  $ProviderElement<FinancialRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FinancialRepository create(Ref ref) {
    return financialRepository(ref);
  }

  Override overrideWithValue(FinancialRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinancialRepository>(value),
    );
  }
}

String _$financialRepositoryHash() =>
    r'8910495913372d971882ccec95e5cc84eb0759f4';
