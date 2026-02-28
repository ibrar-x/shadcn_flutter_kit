// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../calendar.dart';
import 'calendar_theme_defaults.dart';
import 'calendar_theme_tokens.dart';

class CalendarThemeConfig {
  const CalendarThemeConfig._();

  static const CalendarTheme? global = null;
  static const String globalType = 'CalendarTheme';
  static const CalendarThemeDefaults defaults = CalendarThemeDefaults();
  static const CalendarThemeTokens tokens = calendarThemeTokens;

  static T? resolve<T extends CalendarTheme>() {
    if (T == CalendarTheme) {
      return global as T?;
    }
    return null;
  }
}
