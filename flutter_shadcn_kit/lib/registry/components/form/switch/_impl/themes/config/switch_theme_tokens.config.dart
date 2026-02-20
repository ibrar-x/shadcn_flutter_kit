/// Global token override entrypoint for the switch component.
class SwitchThemeTokensConfig {
  const SwitchThemeTokensConfig._();

  /// Global component theme override for `SwitchTheme`.
  static Object? global;
  static const String globalType = 'SwitchTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'activeColor': null,
    'inactiveColor': null,
    'activeThumbColor': null,
    'inactiveThumbColor': null,
    'gap': null,
    'borderRadius': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
