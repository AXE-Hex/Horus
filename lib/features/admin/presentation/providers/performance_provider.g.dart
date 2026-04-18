// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Performance)
final performanceProvider = PerformanceProvider._();

final class PerformanceProvider
    extends $NotifierProvider<Performance, PerformanceState> {
  PerformanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'performanceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$performanceHash();

  @$internal
  @override
  Performance create() => Performance();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PerformanceState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PerformanceState>(value),
    );
  }
}

String _$performanceHash() => r'bbcf24e203bc1a52611194d19e5004d988fa73c6';

abstract class _$Performance extends $Notifier<PerformanceState> {
  PerformanceState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PerformanceState, PerformanceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PerformanceState, PerformanceState>,
              PerformanceState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
