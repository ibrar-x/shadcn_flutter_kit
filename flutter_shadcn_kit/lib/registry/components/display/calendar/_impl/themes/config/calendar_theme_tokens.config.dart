/// Global token override entrypoint for the calendar component.
class CalendarThemeTokensConfig {
  const CalendarThemeTokensConfig._();

  /// Global component theme override for `CalendarTheme`.
  static Object? global;
  static const String globalType = 'CalendarTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'arrowIconColor': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
