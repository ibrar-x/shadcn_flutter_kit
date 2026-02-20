// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'filter_bar_theme_defaults.dart';
import 'filter_bar_theme_tokens.dart';

class FilterBarThemeConfig {
  const FilterBarThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'FilterBarTheme';
  static const FilterBarThemeDefaults defaults = FilterBarThemeDefaults();
  static const FilterBarThemeTokens tokens = filterBarThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
