// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'dot_indicator_theme_defaults.dart';
import 'dot_indicator_theme_tokens.dart';

class DotIndicatorThemeConfig {
  const DotIndicatorThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'DotIndicatorTheme';
  static const DotIndicatorThemeDefaults defaults = DotIndicatorThemeDefaults();
  static const DotIndicatorThemeTokens tokens = dotIndicatorThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
