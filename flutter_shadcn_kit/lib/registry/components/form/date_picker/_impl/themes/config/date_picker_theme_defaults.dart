// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class DatePickerThemeDefaults {
  final Object? mode;
  final Object? initialView;

  /// Widget fallback: CalendarViewType.date
  final Object? initialViewType;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? popoverPadding;

  const DatePickerThemeDefaults({
    this.mode,
    this.initialView,
    this.initialViewType,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
  });
}
