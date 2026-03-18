part of 'admin_stats_provider.dart';

@ProviderFor(adminStats)
final adminStatsProvider = AdminStatsProvider._();

final class AdminStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<RoleCategory, int>>,
          Map<RoleCategory, int>,
          FutureOr<Map<RoleCategory, int>>
        >
    with
        $FutureModifier<Map<RoleCategory, int>>,
        $FutureProvider<Map<RoleCategory, int>> {
  AdminStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminStatsHash();

  @$internal
  @override
  $FutureProviderElement<Map<RoleCategory, int>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<RoleCategory, int>> create(Ref ref) {
    return adminStats(ref);
  }
}

String _$adminStatsHash() => r'c497945ddb95aabc9e0feb8a1eea86925c8a96dd';

@ProviderFor(totalStaffCount)
final totalStaffCountProvider = TotalStaffCountProvider._();

final class TotalStaffCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  TotalStaffCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalStaffCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalStaffCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return totalStaffCount(ref);
  }
}

String _$totalStaffCountHash() => r'a4a79837d86b3e238cfcc4a3c5fafbfeda007d41';

@ProviderFor(totalStudentCount)
final totalStudentCountProvider = TotalStudentCountProvider._();

final class TotalStudentCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  TotalStudentCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalStudentCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalStudentCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return totalStudentCount(ref);
  }
}

String _$totalStudentCountHash() => r'4835acda98019128ab8c407a5352935d289b4c14';
