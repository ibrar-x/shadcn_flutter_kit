// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'collapsible_theme_defaults.dart';
import 'collapsible_theme_tokens.dart';

class CollapsibleThemeConfig {
  const CollapsibleThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'CollapsibleTheme';
  static const CollapsibleThemeDefaults defaults = CollapsibleThemeDefaults();
  static const CollapsibleThemeTokens tokens = collapsibleThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
