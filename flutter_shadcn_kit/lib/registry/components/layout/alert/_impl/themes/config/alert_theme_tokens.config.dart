/// Global token override entrypoint for the alert component.
class AlertThemeTokensConfig {
  const AlertThemeTokensConfig._();

  /// Global component theme override for `AlertTheme`.
  static Object? global;
  static const String globalType = 'AlertTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'padding': null,
    'backgroundColor': null,
    'borderColor': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
