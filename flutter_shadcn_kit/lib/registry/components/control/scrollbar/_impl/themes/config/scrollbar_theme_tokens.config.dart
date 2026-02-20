/// Global token override entrypoint for the scrollbar component.
class ScrollbarThemeTokensConfigGlobalDefaults {
  final Object? color;
  final Object? thickness;
  final Object? radius;

  const ScrollbarThemeTokensConfigGlobalDefaults({
    this.color = '_theme.colorScheme.border',
    this.thickness = '7.0 * _theme.scaling',
    this.radius = 'Radius.circular(_theme.radiusSm)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'color': color,
    'thickness': thickness,
    'radius': radius,
  };
}

class ScrollbarThemeTokensConfigGlobalTokens {
  const ScrollbarThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ScrollbarThemeTokensConfig {
  const ScrollbarThemeTokensConfig._();

  /// Global component theme override for `ScrollbarTheme`.
  static Object? global;
  static const String globalType = 'ScrollbarTheme';
  static const ScrollbarThemeTokensConfigGlobalDefaults globalDefaults =
      ScrollbarThemeTokensConfigGlobalDefaults();
  static const ScrollbarThemeTokensConfigGlobalTokens globalTokens =
      ScrollbarThemeTokensConfigGlobalTokens();
}
