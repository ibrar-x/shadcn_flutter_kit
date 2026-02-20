/// Global token override entrypoint for the switch component.
class SwitchThemeTokensConfig {
  const SwitchThemeTokensConfig._();

  /// Global component theme override for `SwitchTheme`.
  static Object? global;
  static const String globalType = 'SwitchTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'activeColor': 'theme.colorScheme.primary',
    'inactiveColor': 'theme.colorScheme.input',
    'activeThumbColor': 'theme.colorScheme.background',
    'inactiveThumbColor': 'theme.colorScheme.foreground',
    'gap': '8 * scaling',
    'borderRadius': 'BorderRadius.circular(theme.radiusXl)',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
