import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in calendar widgets
// ═══════════════════════════════════════════════════════════

class CalendarThemeDefaults {
  const CalendarThemeDefaults({this.arrowIconColor});

  /// From `_DatePickerDialogState`: `defaultValue: null`
  final Color? arrowIconColor;
}
