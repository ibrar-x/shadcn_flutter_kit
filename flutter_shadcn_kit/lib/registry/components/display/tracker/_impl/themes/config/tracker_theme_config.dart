// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'tracker_theme_defaults.dart';
import 'tracker_theme_tokens.dart';

class TrackerThemeConfig {
  const TrackerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'TrackerTheme';
  static const TrackerThemeDefaults defaults = TrackerThemeDefaults();
  static const TrackerThemeTokens tokens = trackerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
