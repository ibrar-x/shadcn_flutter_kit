/// Global token override entrypoint for the switch component.
class SwitchThemeTokensConfigGlobalDefaults {
  final Object? activeColor;
  final Object? inactiveColor;
  final Object? activeThumbColor;
  final Object? inactiveThumbColor;
  final Object? gap;
  final Object? borderRadius;

  const SwitchThemeTokensConfigGlobalDefaults({
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

class SwitchThemeTokensConfigGlobalTokens {
  const SwitchThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class SwitchThemeTokensConfig {
  const SwitchThemeTokensConfig._();

  /// Global component theme override for `SwitchTheme`.
  static Object? global;
  static const String globalType = 'SwitchTheme';
  static const SwitchThemeTokensConfigGlobalDefaults globalDefaults =
      SwitchThemeTokensConfigGlobalDefaults();
  static const SwitchThemeTokensConfigGlobalTokens globalTokens =
      SwitchThemeTokensConfigGlobalTokens();
}
