// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class SwitchThemeConfigGlobalDefaults {
  final Object? activeColor;
  final Object? inactiveColor;
  final Object? activeThumbColor;
  final Object? inactiveThumbColor;
  final Object? gap;
  final Object? borderRadius;

  const SwitchThemeConfigGlobalDefaults({
    this.activeColor = 'theme.colorScheme.primary',
    this.inactiveColor = 'theme.colorScheme.input',
    this.activeThumbColor = 'theme.colorScheme.background',
    this.inactiveThumbColor = 'theme.colorScheme.foreground',
    this.gap = '8 * scaling',
    this.borderRadius = 'BorderRadius.circular(theme.radiusXl)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'activeColor': activeColor,
    'inactiveColor': inactiveColor,
    'activeThumbColor': activeThumbColor,
    'inactiveThumbColor': inactiveThumbColor,
    'gap': gap,
    'borderRadius': borderRadius,
  };
}

const switchThemeTokensConfigGlobalDefaults = SwitchThemeConfigGlobalDefaults();
