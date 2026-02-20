// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class ColorPickerThemeConfigGlobalDefaults {
  final Object? spacing;
  final Object? controlSpacing;
  final Object? orientation;
  final Object? enableEyeDropper;
  final Object? sliderSize;

  const ColorPickerThemeConfigGlobalDefaults({
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

const colorPickerThemeTokensConfigGlobalDefaults = ColorPickerThemeConfigGlobalDefaults();
