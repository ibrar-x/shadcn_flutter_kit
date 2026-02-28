// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../color_input.dart';
import 'color_input_theme_defaults.dart';
import 'color_input_theme_tokens.dart';

class ColorInputThemeConfig {
  const ColorInputThemeConfig._();

  static const ColorInputTheme? global = null;
  static const String globalType = 'ColorInputTheme';
  static const ColorInputThemeDefaults defaults = ColorInputThemeDefaults();
  static const ColorInputThemeTokens tokens = colorInputThemeTokens;

  static T? resolve<T extends ColorInputTheme>() {
    if (T == ColorInputTheme) {
      return global as T?;
    }
    return null;
  }
}
