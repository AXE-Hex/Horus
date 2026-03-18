part of 'audit_repository.dart';

@ProviderFor(auditRepository)
final auditRepositoryProvider = AuditRepositoryProvider._();

final class AuditRepositoryProvider
    extends
        $FunctionalProvider<AuditRepository, AuditRepository, AuditRepository>
    with $Provider<AuditRepository> {
  AuditRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuditRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuditRepository create(Ref ref) {
    return auditRepository(ref);
  }

  Override overrideWithValue(AuditRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuditRepository>(value),
    );
  }
}

String _$auditRepositoryHash() => r'849f249e92a426435245e7d047a0192685e62c78';
