// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../divider.dart';
import 'divider_theme_defaults.dart';
import 'divider_theme_tokens.dart';

class DividerThemeConfig {
  const DividerThemeConfig._();

  static const DividerTheme? global = null;
  static const String globalType = 'DividerTheme';
  static const DividerThemeDefaults defaults = DividerThemeDefaults();
  static const DividerThemeTokens tokens = dividerThemeTokens;

  static T? resolve<T extends DividerTheme>() {
    if (T == DividerTheme) {
      return global as T?;
    }
    return null;
  }
}
