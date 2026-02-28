// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../collapsible.dart';
import 'collapsible_theme_defaults.dart';
import 'collapsible_theme_tokens.dart';

class CollapsibleThemeConfig {
  const CollapsibleThemeConfig._();

  static const CollapsibleTheme? global = null;
  static const String globalType = 'CollapsibleTheme';
  static const CollapsibleThemeDefaults defaults = CollapsibleThemeDefaults();
  static const CollapsibleThemeTokens tokens = collapsibleThemeTokens;

  static T? resolve<T extends CollapsibleTheme>() {
    if (T == CollapsibleTheme) {
      return global as T?;
    }
    return null;
  }
}
