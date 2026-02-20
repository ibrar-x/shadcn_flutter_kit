// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'empty_state_theme_defaults.dart';
import 'empty_state_theme_tokens.dart';

class EmptyStateThemeConfig {
  const EmptyStateThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'EmptyStateTheme';
  static const EmptyStateThemeDefaults defaults = EmptyStateThemeDefaults();
  static const EmptyStateThemeTokens tokens = emptyStateThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
