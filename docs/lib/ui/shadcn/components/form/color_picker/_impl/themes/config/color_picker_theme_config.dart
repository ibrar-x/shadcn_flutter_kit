// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../color_picker.dart';
import 'color_picker_theme_defaults.dart';
import 'color_picker_theme_tokens.dart';

class ColorPickerThemeConfig {
  const ColorPickerThemeConfig._();

  static const ColorPickerTheme? global = null;
  static const String globalType = 'ColorPickerTheme';
  static const ColorPickerThemeDefaults defaults = ColorPickerThemeDefaults();
  static const ColorPickerThemeTokens tokens = colorPickerThemeTokens;

  static T? resolve<T extends ColorPickerTheme>() {
    if (T == ColorPickerTheme) {
      return global as T?;
    }
    return null;
  }
}
