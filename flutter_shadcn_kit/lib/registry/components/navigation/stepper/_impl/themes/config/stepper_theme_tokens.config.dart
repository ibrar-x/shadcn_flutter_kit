/// Global token override entrypoint for the stepper component.
class StepperThemeTokensConfig {
  const StepperThemeTokensConfig._();

  /// Global component theme override for `StepperTheme`.
  static Object? global;
  static const String globalType = 'StepperTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'direction': null,
    'size': null,
    'variant': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
