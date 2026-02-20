/// Global token override entrypoint for the time_picker component.
class TimePickerThemeTokensConfigGlobalDefaults {
  final Object? mode;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? popoverPadding;
  final Object? use24HourFormat;
  final Object? showSeconds;
  final Object? dialogTitle;

  const TimePickerThemeTokensConfigGlobalDefaults({
    this.mode,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.use24HourFormat,
    this.showSeconds,
    this.dialogTitle,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'mode': mode,
    'popoverAlignment': popoverAlignment,
    'popoverAnchorAlignment': popoverAnchorAlignment,
    'popoverPadding': popoverPadding,
    'use24HourFormat': use24HourFormat,
    'showSeconds': showSeconds,
    'dialogTitle': dialogTitle,
  };
}

class TimePickerThemeTokensConfigGlobalTokens {
  const TimePickerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TimePickerThemeTokensConfig {
  const TimePickerThemeTokensConfig._();

  /// Global component theme override for `TimePickerTheme`.
  static Object? global;
  static const String globalType = 'TimePickerTheme';
  static const TimePickerThemeTokensConfigGlobalDefaults globalDefaults =
      TimePickerThemeTokensConfigGlobalDefaults();
  static const TimePickerThemeTokensConfigGlobalTokens globalTokens =
      TimePickerThemeTokensConfigGlobalTokens();
}
