/// Global token override entrypoint for the tooltip component.
class TooltipThemeTokensConfig {
  const TooltipThemeTokensConfig._();

  /// Global component theme override for `TooltipTheme`.
  static Object? global;
  static const String globalType = 'TooltipTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'surfaceOpacity': null,
    'surfaceBlur': null,
    'padding': null,
    'backgroundColor': null,
    'borderRadius': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
