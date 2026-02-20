// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'divider_theme_defaults.dart';
import 'divider_theme_tokens.dart';

class DividerThemeConfig {
  const DividerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'DividerTheme';
  static const DividerThemeDefaults defaults = DividerThemeDefaults();
  static const DividerThemeTokens tokens = dividerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
