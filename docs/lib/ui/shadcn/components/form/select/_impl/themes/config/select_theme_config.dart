// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../select.dart';
import 'select_theme_defaults.dart';
import 'select_theme_tokens.dart';

class SelectThemeConfig {
  const SelectThemeConfig._();

  static const SelectTheme? global = null;
  static const String globalType = 'SelectTheme';
  static const SelectThemeDefaults defaults = SelectThemeDefaults();
  static const SelectThemeTokens tokens = selectThemeTokens;

  static T? resolve<T extends SelectTheme>() {
    if (T == SelectTheme) {
      return global as T?;
    }
    return null;
  }
}
