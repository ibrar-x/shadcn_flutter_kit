// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../chip.dart';
import 'chip_theme_defaults.dart';
import 'chip_theme_tokens.dart';

class ChipThemeConfig {
  const ChipThemeConfig._();

  static const ChipTheme? global = null;
  static const String globalType = 'ChipTheme';
  static const ChipThemeDefaults defaults = ChipThemeDefaults();
  static const ChipThemeTokens tokens = chipThemeTokens;

  static T? resolve<T extends ChipTheme>() {
    if (T == ChipTheme) {
      return global as T?;
    }
    return null;
  }
}
