// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'carousel_theme_defaults.dart';
import 'carousel_theme_tokens.dart';

class CarouselThemeConfig {
  const CarouselThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'CarouselTheme';
  static const CarouselThemeDefaults defaults = CarouselThemeDefaults();
  static const CarouselThemeTokens tokens = carouselThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
