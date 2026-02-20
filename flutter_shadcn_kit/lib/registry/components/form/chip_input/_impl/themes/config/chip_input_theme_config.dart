// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'chip_input_theme_defaults.dart';
import 'chip_input_theme_tokens.dart';

class ChipInputThemeConfig {
  const ChipInputThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'ChipInputTheme';
  static const ChipInputThemeDefaults defaults = ChipInputThemeDefaults();
  static const ChipInputThemeTokens tokens = chipInputThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
