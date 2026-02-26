// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(academicRepository)
final academicRepositoryProvider = AcademicRepositoryProvider._();

final class AcademicRepositoryProvider
    extends
        $FunctionalProvider<
          AcademicRepository,
          AcademicRepository,
          AcademicRepository
        >
    with $Provider<AcademicRepository> {
  AcademicRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'academicRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$academicRepositoryHash();

  @$internal
  @override
  $ProviderElement<AcademicRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AcademicRepository create(Ref ref) {
    return academicRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AcademicRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AcademicRepository>(value),
    );
  }
}

String _$academicRepositoryHash() =>
    r'7409266c14b26e24cf4499d22d674d6b04dad6c6';
