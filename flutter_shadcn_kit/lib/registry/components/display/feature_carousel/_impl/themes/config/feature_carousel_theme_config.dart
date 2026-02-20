// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'feature_carousel_theme_defaults.dart';
import 'feature_carousel_theme_tokens.dart';

class FeatureCarouselThemeConfig {
  const FeatureCarouselThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'FeatureCarouselTheme';
  static const FeatureCarouselThemeDefaults defaults =
      FeatureCarouselThemeDefaults();
  static const FeatureCarouselThemeTokens tokens = featureCarouselThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
