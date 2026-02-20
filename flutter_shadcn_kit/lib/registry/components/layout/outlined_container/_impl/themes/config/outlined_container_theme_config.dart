// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'outlined_container_theme_defaults.dart';
import 'outlined_container_theme_tokens.dart';

class OutlinedContainerThemeConfig {
  const OutlinedContainerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'OutlinedContainerTheme';
  static const OutlinedContainerThemeDefaults defaults =
      OutlinedContainerThemeDefaults();
  static const OutlinedContainerThemeTokens tokens =
      outlinedContainerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
