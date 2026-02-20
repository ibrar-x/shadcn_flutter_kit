/// Global token override entrypoint for the color_picker component.
class ColorPickerThemeTokensConfig {
  const ColorPickerThemeTokensConfig._();

  /// Global component theme override for `ColorPickerTheme`.
  static Object? global;
  static const String globalType = 'ColorPickerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'spacing': 12.0,
    'controlSpacing': 8.0,
    'orientation': 'Axis.vertical',
    'enableEyeDropper': null,
    'sliderSize': 24.0,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
