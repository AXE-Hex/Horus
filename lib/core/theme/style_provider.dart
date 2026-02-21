// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'style_provider.g.dart';

enum AppStyle { classic, glass }

@Riverpod(keepAlive: true)
class StyleController extends _$StyleController {
  static const _styleKey = 'app_style';

  @override
  Future<AppStyle> build() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStyle = prefs.getString(_styleKey);
    if (savedStyle == 'glass') return AppStyle.glass;
    return AppStyle.classic;
  }

  Future<void> setStyle(AppStyle style) async {
    if (state.value == style) return;

    state = AsyncData(style);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _styleKey,
      style == AppStyle.glass ? 'glass' : 'classic',
    );
  }
}