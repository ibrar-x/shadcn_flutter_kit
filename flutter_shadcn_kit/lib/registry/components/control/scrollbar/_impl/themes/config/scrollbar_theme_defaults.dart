// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class ScrollbarThemeConfigGlobalDefaults {
  final Object? color;
  final Object? thickness;
  final Object? radius;

  const ScrollbarThemeConfigGlobalDefaults({
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

const scrollbarThemeTokensConfigGlobalDefaults = ScrollbarThemeConfigGlobalDefaults();
