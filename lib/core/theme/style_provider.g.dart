// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StyleController)
final styleControllerProvider = StyleControllerProvider._();

final class StyleControllerProvider
    extends $AsyncNotifierProvider<StyleController, AppStyle> {
  StyleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'styleControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$styleControllerHash();

  @$internal
  @override
  StyleController create() => StyleController();
}

String _$styleControllerHash() => r'6bcbadfe79ca384eb61098c0efe3448eb18888cd';

abstract class _$StyleController extends $AsyncNotifier<AppStyle> {
  FutureOr<AppStyle> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppStyle>, AppStyle>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppStyle>, AppStyle>,
              AsyncValue<AppStyle>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
