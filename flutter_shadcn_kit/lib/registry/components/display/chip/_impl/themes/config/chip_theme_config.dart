// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'chip_theme_defaults.dart';
import 'chip_theme_tokens.dart';

class ChipThemeConfig {
  const ChipThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'ChipTheme';
  static const ChipThemeDefaults defaults = ChipThemeDefaults();
  static const ChipThemeTokens tokens = chipThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
