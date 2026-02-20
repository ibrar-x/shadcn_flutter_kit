/// Global token override entrypoint for the radio_group component.
class RadioGroupThemeTokensConfig {
  const RadioGroupThemeTokensConfig._();

  /// Global component theme override for `RadioCardTheme`.
  static Object? global;
  static const String globalType = 'RadioCardTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'enabledCursor': null,
    'disabledCursor': null,
    'hoverColor': null,
    'color': null,
    'borderWidth': null,
    'selectedBorderWidth': null,
    'borderRadius': null,
    'padding': null,
    'borderColor': null,
    'selectedBorderColor': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};

  /// Global component theme override for `RadioTheme`.
  static Object? radioTheme;
  static const String radioThemeType = 'RadioTheme';
  static const Map<String, Object?> radioThemeDefaults = <String, Object?>{
    'activeColor': null,
    'borderColor': null,
    'size': null,
    'backgroundColor': null,
  };
  static const Map<String, Object?> radioThemeTokens = <String, Object?>{};
}
