// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'low_performance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LowPerformanceController)
final lowPerformanceControllerProvider = LowPerformanceControllerProvider._();

final class LowPerformanceControllerProvider
    extends $NotifierProvider<LowPerformanceController, bool> {
  LowPerformanceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lowPerformanceControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lowPerformanceControllerHash();

  @$internal
  @override
  LowPerformanceController create() => LowPerformanceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$lowPerformanceControllerHash() =>
    r'cf82210222b84cae3aa7a5616740c7d6b61a32c6';

abstract class _$LowPerformanceController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
