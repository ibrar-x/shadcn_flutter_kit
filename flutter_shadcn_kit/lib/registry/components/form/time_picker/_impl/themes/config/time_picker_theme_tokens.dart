// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class TimePickerThemeTokens {
  final Object? mode;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? popoverPadding;
  final Object? use24HourFormat;
  final Object? showSeconds;
  final Object? dialogTitle;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const TimePickerThemeTokens({
    this.mode,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.use24HourFormat,
    this.showSeconds,
    this.dialogTitle,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const timePickerThemeTokens = TimePickerThemeTokens();
