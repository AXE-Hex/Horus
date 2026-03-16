// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institutional_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(institutionalRepository)
final institutionalRepositoryProvider = InstitutionalRepositoryProvider._();

final class InstitutionalRepositoryProvider
    extends
        $FunctionalProvider<
          InstitutionalRepository,
          InstitutionalRepository,
          InstitutionalRepository
        >
    with $Provider<InstitutionalRepository> {
  InstitutionalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'institutionalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$institutionalRepositoryHash();

  @$internal
  @override
  $ProviderElement<InstitutionalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InstitutionalRepository create(Ref ref) {
    return institutionalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InstitutionalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InstitutionalRepository>(value),
    );
  }
}

String _$institutionalRepositoryHash() =>
    r'6996414a9c2cd59e6c20c853f4568e0ea5b60229';
