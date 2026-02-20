/// Global token override entrypoint for the dot_indicator component.
class DotIndicatorThemeTokensConfig {
  const DotIndicatorThemeTokensConfig._();

  /// Global component theme override for `DotIndicatorTheme`.
  static Object? global;
  static const String globalType = 'DotIndicatorTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'spacing': null,
    'padding': null,
    'dotBuilder': null,
    'size': null,
    'borderRadius': null,
    'activeColor': null,
    'inactiveColor': null,
    'inactiveBorderColor': null,
    'inactiveBorderWidth': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
