/// Global token override entrypoint for the scrollbar component.
class ScrollbarThemeTokensConfig {
  const ScrollbarThemeTokensConfig._();

  /// Global component theme override for `ScrollbarTheme`.
  static Object? global;
  static const String globalType = 'ScrollbarTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'color': null,
    'thickness': null,
    'radius': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
