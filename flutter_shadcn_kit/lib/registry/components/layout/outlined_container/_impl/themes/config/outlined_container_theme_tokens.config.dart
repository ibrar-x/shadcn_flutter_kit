/// Global token override entrypoint for the outlined_container component.
class OutlinedContainerThemeTokensConfig {
  const OutlinedContainerThemeTokensConfig._();

  /// Global component theme override for `OutlinedContainerTheme`.
  static Object? global;
  static const String globalType = 'OutlinedContainerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'backgroundColor': 'theme.colorScheme.background',
    'borderColor': 'theme.colorScheme.muted',
    'borderRadius': 'theme.borderRadiusXl',
    'borderStyle': 'BorderStyle.solid',
    'borderWidth': '1.0 * theme.scaling',
    'boxShadow': null,
    'padding': 'EdgeInsets.zero',
    'surfaceOpacity': null,
    'surfaceBlur': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
