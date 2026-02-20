/// Global token override entrypoint for the spinner component.
class SpinnerThemeTokensConfig {
  const SpinnerThemeTokensConfig._();

  /// Global component theme override for `SpinnerTheme`.
  static Object? global;
  static const String globalType = 'SpinnerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'color': null,
    'size': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
