// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class ColorInputThemeConfigGlobalDefaults {
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

  const ColorInputThemeConfigGlobalDefaults({
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

const colorInputThemeTokensConfigGlobalDefaults = ColorInputThemeConfigGlobalDefaults();
