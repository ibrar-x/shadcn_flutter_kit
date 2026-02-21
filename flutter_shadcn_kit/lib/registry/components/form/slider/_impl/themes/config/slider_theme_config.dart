// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../base/slider_theme.dart';
import 'slider_theme_defaults.dart';
import 'slider_theme_tokens.dart';

class SliderThemeConfig {
  const SliderThemeConfig._();

  static const SliderTheme? global = null;
  static const String globalType = 'SliderTheme';
  static const SliderThemeDefaults defaults = SliderThemeDefaults();
  static const SliderThemeTokens tokens = sliderThemeTokens;

  static T? resolve<T extends SliderTheme>() {
    if (T == SliderTheme) {
      return global as T?;
    }
    return null;
  }
}
