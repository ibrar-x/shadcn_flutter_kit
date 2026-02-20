/// Global token override entrypoint for the color_picker component.
class ColorPickerThemeTokensConfigGlobalDefaults {
  final Object? spacing;
  final Object? controlSpacing;
  final Object? orientation;
  final Object? enableEyeDropper;
  final Object? sliderSize;

  const ColorPickerThemeTokensConfigGlobalDefaults({
    this.spacing = 12.0,
    this.controlSpacing = 8.0,
    this.orientation = 'Axis.vertical',
    this.enableEyeDropper,
    this.sliderSize = 24.0,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'spacing': spacing,
    'controlSpacing': controlSpacing,
    'orientation': orientation,
    'enableEyeDropper': enableEyeDropper,
    'sliderSize': sliderSize,
  };
}

class ColorPickerThemeTokensConfigGlobalTokens {
  const ColorPickerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ColorPickerThemeTokensConfig {
  const ColorPickerThemeTokensConfig._();

  /// Global component theme override for `ColorPickerTheme`.
  static Object? global;
  static const String globalType = 'ColorPickerTheme';
  static const ColorPickerThemeTokensConfigGlobalDefaults globalDefaults =
      ColorPickerThemeTokensConfigGlobalDefaults();
  static const ColorPickerThemeTokensConfigGlobalTokens globalTokens =
      ColorPickerThemeTokensConfigGlobalTokens();
}
