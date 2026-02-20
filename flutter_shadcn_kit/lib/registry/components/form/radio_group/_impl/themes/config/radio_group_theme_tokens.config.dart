/// Global token override entrypoint for the radio_group component.
class RadioGroupThemeTokensConfigGlobalDefaults {
  final Object? enabledCursor;
  final Object? disabledCursor;
  final Object? hoverColor;
  final Object? color;
  final Object? borderWidth;
  final Object? selectedBorderWidth;
  final Object? borderRadius;
  final Object? padding;
  final Object? borderColor;
  final Object? selectedBorderColor;

  const RadioGroupThemeTokensConfigGlobalDefaults({
    this.enabledCursor,
    this.disabledCursor,
    this.hoverColor,
    this.color,
    this.borderWidth,
    this.selectedBorderWidth,
    this.borderRadius,
    this.padding,
    this.borderColor,
    this.selectedBorderColor,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'enabledCursor': enabledCursor,
    'disabledCursor': disabledCursor,
    'hoverColor': hoverColor,
    'color': color,
    'borderWidth': borderWidth,
    'selectedBorderWidth': selectedBorderWidth,
    'borderRadius': borderRadius,
    'padding': padding,
    'borderColor': borderColor,
    'selectedBorderColor': selectedBorderColor,
  };
}

class RadioGroupThemeTokensConfigGlobalTokens {
  const RadioGroupThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class RadioGroupThemeTokensConfigRadioThemeDefaults {
  final Object? activeColor;
  final Object? borderColor;
  final Object? size;
  final Object? backgroundColor;

  const RadioGroupThemeTokensConfigRadioThemeDefaults({
    this.activeColor,
    this.borderColor,
    this.size,
    this.backgroundColor,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'activeColor': activeColor,
    'borderColor': borderColor,
    'size': size,
    'backgroundColor': backgroundColor,
  };
}

class RadioGroupThemeTokensConfigRadioThemeTokens {
  const RadioGroupThemeTokensConfigRadioThemeTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class RadioGroupThemeTokensConfig {
  const RadioGroupThemeTokensConfig._();

  /// Global component theme override for `RadioCardTheme`.
  static Object? global;
  static const String globalType = 'RadioCardTheme';
  static const RadioGroupThemeTokensConfigGlobalDefaults globalDefaults =
      RadioGroupThemeTokensConfigGlobalDefaults();
  static const RadioGroupThemeTokensConfigGlobalTokens globalTokens =
      RadioGroupThemeTokensConfigGlobalTokens();

  /// Global component theme override for `RadioTheme`.
  static Object? radioTheme;
  static const String radioThemeType = 'RadioTheme';
  static const RadioGroupThemeTokensConfigRadioThemeDefaults
  radioThemeDefaults = RadioGroupThemeTokensConfigRadioThemeDefaults();
  static const RadioGroupThemeTokensConfigRadioThemeTokens radioThemeTokens =
      RadioGroupThemeTokensConfigRadioThemeTokens();
}
