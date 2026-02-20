// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'swiper_theme_defaults.dart';
import 'swiper_theme_tokens.dart';

class SwiperThemeConfig {
  const SwiperThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'SwiperTheme';
  static const SwiperThemeDefaults defaults = SwiperThemeDefaults();
  static const SwiperThemeTokens tokens = swiperThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
