/// Global token override entrypoint for the checkbox component.
class CheckboxThemeTokensConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? activeColor;
  final Object? borderColor;
  final Object? size;
  final Object? gap;
  final Object? borderRadius;

  const CheckboxThemeTokensConfigGlobalDefaults({
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

class CheckboxThemeTokensConfigGlobalTokens {
  const CheckboxThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class CheckboxThemeTokensConfig {
  const CheckboxThemeTokensConfig._();

  /// Global component theme override for `CheckboxTheme`.
  static Object? global;
  static const String globalType = 'CheckboxTheme';
  static const CheckboxThemeTokensConfigGlobalDefaults globalDefaults =
      CheckboxThemeTokensConfigGlobalDefaults();
  static const CheckboxThemeTokensConfigGlobalTokens globalTokens =
      CheckboxThemeTokensConfigGlobalTokens();
}
