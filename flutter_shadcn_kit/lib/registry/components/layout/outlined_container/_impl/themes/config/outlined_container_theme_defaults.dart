// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class OutlinedContainerThemeConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? borderColor;
  final Object? borderRadius;
  final Object? borderStyle;
  final Object? borderWidth;
  final Object? boxShadow;
  final Object? padding;
  final Object? surfaceOpacity;
  final Object? surfaceBlur;

  const OutlinedContainerThemeConfigGlobalDefaults({
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

const outlinedContainerThemeTokensConfigGlobalDefaults = OutlinedContainerThemeConfigGlobalDefaults();
