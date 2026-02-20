/// Global token override entrypoint for the dot_indicator component.
class DotIndicatorThemeTokensConfigGlobalDefaults {
  final Object? spacing;
  final Object? padding;
  final Object? dotBuilder;
  final Object? size;
  final Object? borderRadius;
  final Object? activeColor;
  final Object? inactiveColor;
  final Object? inactiveBorderColor;
  final Object? inactiveBorderWidth;

  const DotIndicatorThemeTokensConfigGlobalDefaults({
    this.spacing,
    this.padding,
    this.dotBuilder,
    this.size,
    this.borderRadius,
    this.activeColor,
    this.inactiveColor,
    this.inactiveBorderColor,
    this.inactiveBorderWidth,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'spacing': spacing,
    'padding': padding,
    'dotBuilder': dotBuilder,
    'size': size,
    'borderRadius': borderRadius,
    'activeColor': activeColor,
    'inactiveColor': inactiveColor,
    'inactiveBorderColor': inactiveBorderColor,
    'inactiveBorderWidth': inactiveBorderWidth,
  };
}

class DotIndicatorThemeTokensConfigGlobalTokens {
  const DotIndicatorThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class DotIndicatorThemeTokensConfig {
  const DotIndicatorThemeTokensConfig._();

  /// Global component theme override for `DotIndicatorTheme`.
  static Object? global;
  static const String globalType = 'DotIndicatorTheme';
  static const DotIndicatorThemeTokensConfigGlobalDefaults globalDefaults =
      DotIndicatorThemeTokensConfigGlobalDefaults();
  static const DotIndicatorThemeTokensConfigGlobalTokens globalTokens =
      DotIndicatorThemeTokensConfigGlobalTokens();
}
