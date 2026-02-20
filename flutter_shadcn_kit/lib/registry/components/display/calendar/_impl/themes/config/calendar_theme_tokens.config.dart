/// Global token override entrypoint for the calendar component.
class CalendarThemeTokensConfigGlobalDefaults {
  final Object? arrowIconColor;

  const CalendarThemeTokensConfigGlobalDefaults({this.arrowIconColor});

  Map<String, Object?> toMap() => <String, Object?>{
    'arrowIconColor': arrowIconColor,
  };
}

class CalendarThemeTokensConfigGlobalTokens {
  const CalendarThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class CalendarThemeTokensConfig {
  const CalendarThemeTokensConfig._();

  /// Global component theme override for `CalendarTheme`.
  static Object? global;
  static const String globalType = 'CalendarTheme';
  static const CalendarThemeTokensConfigGlobalDefaults globalDefaults =
      CalendarThemeTokensConfigGlobalDefaults();
  static const CalendarThemeTokensConfigGlobalTokens globalTokens =
      CalendarThemeTokensConfigGlobalTokens();
}
