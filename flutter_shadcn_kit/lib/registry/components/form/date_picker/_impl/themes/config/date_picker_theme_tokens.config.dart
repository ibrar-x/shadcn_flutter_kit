/// Global token override entrypoint for the date_picker component.
class DatePickerThemeTokensConfig {
  const DatePickerThemeTokensConfig._();

  /// Global component theme override for `DatePickerTheme`.
  static Object? global;
  static const String globalType = 'DatePickerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'mode': null,
    'initialView': null,
    'initialViewType': null,
    'popoverAlignment': null,
    'popoverAnchorAlignment': null,
    'popoverPadding': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
