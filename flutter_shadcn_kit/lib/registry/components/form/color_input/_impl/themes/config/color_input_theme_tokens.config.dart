/// Global token override entrypoint for the color_input component.
class ColorInputThemeTokensConfig {
  const ColorInputThemeTokensConfig._();

  /// Global component theme override for `ColorInputTheme`.
  static Object? global;
  static const String globalType = 'ColorInputTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'showAlpha': null,
    'popoverAlignment': null,
    'popoverAnchorAlignment': null,
    'popoverPadding': null,
    'mode': null,
    'pickerMode': null,
    'enableEyeDropper': null,
    'showLabel': null,
    'orientation': null,
    'showHistory': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
