/// Global token override entrypoint for the color_input component.
class ColorInputThemeTokensConfigGlobalDefaults {
  final Object? showAlpha;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? popoverPadding;
  final Object? mode;
  final Object? pickerMode;
  final Object? enableEyeDropper;
  final Object? showLabel;
  final Object? orientation;
  final Object? showHistory;

  const ColorInputThemeTokensConfigGlobalDefaults({
    this.showAlpha = true,
    this.popoverAlignment = 'Alignment.topCenter',
    this.popoverAnchorAlignment = 'Alignment.bottomCenter',
    this.popoverPadding,
    this.mode,
    this.pickerMode,
    this.enableEyeDropper = true,
    this.showLabel = false,
    this.orientation,
    this.showHistory = true,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'showAlpha': showAlpha,
    'popoverAlignment': popoverAlignment,
    'popoverAnchorAlignment': popoverAnchorAlignment,
    'popoverPadding': popoverPadding,
    'mode': mode,
    'pickerMode': pickerMode,
    'enableEyeDropper': enableEyeDropper,
    'showLabel': showLabel,
    'orientation': orientation,
    'showHistory': showHistory,
  };
}

class ColorInputThemeTokensConfigGlobalTokens {
  const ColorInputThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ColorInputThemeTokensConfig {
  const ColorInputThemeTokensConfig._();

  /// Global component theme override for `ColorInputTheme`.
  static Object? global;
  static const String globalType = 'ColorInputTheme';
  static const ColorInputThemeTokensConfigGlobalDefaults globalDefaults =
      ColorInputThemeTokensConfigGlobalDefaults();
  static const ColorInputThemeTokensConfigGlobalTokens globalTokens =
      ColorInputThemeTokensConfigGlobalTokens();
}
