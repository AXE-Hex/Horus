import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'style_provider.g.dart';

enum AppStyle { classic, glass }

@Riverpod(keepAlive: true)
class StyleController extends _$StyleController {

  @override
  Future<AppStyle> build() async {
    return AppStyle.classic;
  }

  Future<void> setStyle(AppStyle style) async {
    state = const AsyncValue.data(AppStyle.classic);
  }
}
