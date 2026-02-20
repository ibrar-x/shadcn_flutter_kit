// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'calendar_theme_defaults.dart';
import 'calendar_theme_tokens.dart';

class CalendarThemeConfig {
  const CalendarThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'CalendarTheme';
  static const CalendarThemeDefaults defaults = CalendarThemeDefaults();
  static const CalendarThemeTokens tokens = calendarThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
