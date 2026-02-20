/// Global token override entrypoint for the checkbox component.
class CheckboxThemeTokensConfig {
  const CheckboxThemeTokensConfig._();

  /// Global component theme override for `CheckboxTheme`.
  static Object? global;
  static const String globalType = 'CheckboxTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'backgroundColor': 'theme.colorScheme.input.scaleAlpha(0.3)',
    'activeColor': 'theme.colorScheme.primary',
    'borderColor': 'theme.colorScheme.border',
    'size': '16 * scaling',
    'gap': '8 * scaling',
    'borderRadius': 'BorderRadius.circular(theme.radiusSm)',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
