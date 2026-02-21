// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../empty_state.dart';
import 'empty_state_theme_defaults.dart';
import 'empty_state_theme_tokens.dart';

class EmptyStateThemeConfig {
  const EmptyStateThemeConfig._();

  static const EmptyStateTheme? global = null;
  static const String globalType = 'EmptyStateTheme';
  static const EmptyStateThemeDefaults defaults = EmptyStateThemeDefaults();
  static const EmptyStateThemeTokens tokens = emptyStateThemeTokens;

  static T? resolve<T extends EmptyStateTheme>() {
    if (T == EmptyStateTheme) {
      return global as T?;
    }
    return null;
  }
}
