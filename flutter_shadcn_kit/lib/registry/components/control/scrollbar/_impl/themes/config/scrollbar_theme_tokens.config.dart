/// Global token override entrypoint for the scrollbar component.
class ScrollbarThemeTokensConfig {
  const ScrollbarThemeTokensConfig._();

  /// Global component theme override for `ScrollbarTheme`.
  static Object? global;
  static const String globalType = 'ScrollbarTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'color': '_theme.colorScheme.border',
    'thickness': '7.0 * _theme.scaling',
    'radius': 'Radius.circular(_theme.radiusSm)',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
