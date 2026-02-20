/// Global token override entrypoint for the card component.
class CardThemeTokensConfig {
  const CardThemeTokensConfig._();

  /// Global component theme override for `CardTheme`.
  static Object? global;
  static const String globalType = 'CardTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'padding': null,
    'filled': null,
    'fillColor': null,
    'borderRadius': null,
    'borderColor': null,
    'borderWidth': null,
    'clipBehavior': null,
    'boxShadow': null,
    'surfaceOpacity': null,
    'surfaceBlur': null,
    'duration': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
