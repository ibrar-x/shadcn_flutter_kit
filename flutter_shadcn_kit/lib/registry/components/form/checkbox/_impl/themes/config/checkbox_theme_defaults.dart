// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class CheckboxThemeConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? activeColor;
  final Object? borderColor;
  final Object? size;
  final Object? gap;
  final Object? borderRadius;

  const CheckboxThemeConfigGlobalDefaults({
    this.backgroundColor = 'theme.colorScheme.input.scaleAlpha(0.3)',
    this.activeColor = 'theme.colorScheme.primary',
    this.borderColor = 'theme.colorScheme.border',
    this.size = '16 * scaling',
    this.gap = '8 * scaling',
    this.borderRadius = 'BorderRadius.circular(theme.radiusSm)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'backgroundColor': backgroundColor,
    'activeColor': activeColor,
    'borderColor': borderColor,
    'size': size,
    'gap': gap,
    'borderRadius': borderRadius,
  };
}

const checkboxThemeTokensConfigGlobalDefaults = CheckboxThemeConfigGlobalDefaults();
