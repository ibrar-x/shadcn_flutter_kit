/// Global token override entrypoint for the stepper component.
class StepperThemeTokensConfigGlobalDefaults {
  final Object? direction;
  final Object? size;
  final Object? variant;

  const StepperThemeTokensConfigGlobalDefaults({
    this.direction,
    this.size,
    this.variant,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'direction': direction,
    'size': size,
    'variant': variant,
  };
}

class StepperThemeTokensConfigGlobalTokens {
  const StepperThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class StepperThemeTokensConfig {
  const StepperThemeTokensConfig._();

  /// Global component theme override for `StepperTheme`.
  static Object? global;
  static const String globalType = 'StepperTheme';
  static const StepperThemeTokensConfigGlobalDefaults globalDefaults =
      StepperThemeTokensConfigGlobalDefaults();
  static const StepperThemeTokensConfigGlobalTokens globalTokens =
      StepperThemeTokensConfigGlobalTokens();
}
