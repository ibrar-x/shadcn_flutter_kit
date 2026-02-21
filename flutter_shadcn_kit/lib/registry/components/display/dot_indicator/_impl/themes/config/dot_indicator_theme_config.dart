// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../dot_indicator.dart';
import 'dot_indicator_theme_defaults.dart';
import 'dot_indicator_theme_tokens.dart';

class DotIndicatorThemeConfig {
  const DotIndicatorThemeConfig._();

  static const DotIndicatorTheme? global = null;
  static const String globalType = 'DotIndicatorTheme';
  static const DotIndicatorThemeDefaults defaults = DotIndicatorThemeDefaults();
  static const DotIndicatorThemeTokens tokens = dotIndicatorThemeTokens;

  static T? resolve<T extends DotIndicatorTheme>() {
    if (T == DotIndicatorTheme) {
      return global as T?;
    }
    return null;
  }
}
