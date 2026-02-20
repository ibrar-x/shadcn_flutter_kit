/// Global token override entrypoint for the outlined_container component.
class OutlinedContainerThemeTokensConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? borderColor;
  final Object? borderRadius;
  final Object? borderStyle;
  final Object? borderWidth;
  final Object? boxShadow;
  final Object? padding;
  final Object? surfaceOpacity;
  final Object? surfaceBlur;

  const OutlinedContainerThemeTokensConfigGlobalDefaults({
    this.backgroundColor = 'theme.colorScheme.background',
    this.borderColor = 'theme.colorScheme.muted',
    this.borderRadius = 'theme.borderRadiusXl',
    this.borderStyle = 'BorderStyle.solid',
    this.borderWidth = '1.0 * theme.scaling',
    this.boxShadow,
    this.padding = 'EdgeInsets.zero',
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'backgroundColor': backgroundColor,
    'borderColor': borderColor,
    'borderRadius': borderRadius,
    'borderStyle': borderStyle,
    'borderWidth': borderWidth,
    'boxShadow': boxShadow,
    'padding': padding,
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
  };
}

class OutlinedContainerThemeTokensConfigGlobalTokens {
  const OutlinedContainerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class OutlinedContainerThemeTokensConfig {
  const OutlinedContainerThemeTokensConfig._();

  /// Global component theme override for `OutlinedContainerTheme`.
  static Object? global;
  static const String globalType = 'OutlinedContainerTheme';
  static const OutlinedContainerThemeTokensConfigGlobalDefaults globalDefaults =
      OutlinedContainerThemeTokensConfigGlobalDefaults();
  static const OutlinedContainerThemeTokensConfigGlobalTokens globalTokens =
      OutlinedContainerThemeTokensConfigGlobalTokens();
}
