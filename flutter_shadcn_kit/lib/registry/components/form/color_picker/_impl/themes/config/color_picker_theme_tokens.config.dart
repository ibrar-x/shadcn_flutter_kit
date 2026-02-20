/// Global token override entrypoint for the color_picker component.
class ColorPickerThemeTokensConfig {
  const ColorPickerThemeTokensConfig._();

  /// Global component theme override for `ColorPickerTheme`.
  static Object? global;
  static const String globalType = 'ColorPickerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'spacing': null,
    'controlSpacing': null,
    'orientation': null,
    'enableEyeDropper': null,
    'sliderSize': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
