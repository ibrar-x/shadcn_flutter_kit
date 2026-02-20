// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'refresh_trigger_theme_defaults.dart';
import 'refresh_trigger_theme_tokens.dart';

class RefreshTriggerThemeConfig {
  const RefreshTriggerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'RefreshTriggerTheme';
  static const RefreshTriggerThemeDefaults defaults =
      RefreshTriggerThemeDefaults();
  static const RefreshTriggerThemeTokens tokens = refreshTriggerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
