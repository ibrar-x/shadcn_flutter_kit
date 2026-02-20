/// Global token override entrypoint for the time_picker component.
class TimePickerThemeTokensConfig {
  const TimePickerThemeTokensConfig._();

  /// Global component theme override for `TimePickerTheme`.
  static Object? global;
  static const String globalType = 'TimePickerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'mode': null,
    'popoverAlignment': null,
    'popoverAnchorAlignment': null,
    'popoverPadding': null,
    'use24HourFormat': null,
    'showSeconds': null,
    'dialogTitle': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
