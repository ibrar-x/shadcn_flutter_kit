/// Global token override entrypoint for the color_input component.
class ColorInputThemeTokensConfig {
  const ColorInputThemeTokensConfig._();

  /// Global component theme override for `ColorInputTheme`.
  static Object? global;
  static const String globalType = 'ColorInputTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'showAlpha': true,
    'popoverAlignment': 'Alignment.topCenter',
    'popoverAnchorAlignment': 'Alignment.bottomCenter',
    'popoverPadding': null,
    'mode': null,
    'pickerMode': null,
    'enableEyeDropper': true,
    'showLabel': false,
    'orientation': null,
    'showHistory': true,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
