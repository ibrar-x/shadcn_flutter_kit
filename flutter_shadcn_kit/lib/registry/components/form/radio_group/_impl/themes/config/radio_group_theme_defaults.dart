// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class RadioGroupThemeConfigGlobalDefaults {
  final Object? enabledCursor;
  final Object? disabledCursor;
  final Object? hoverColor;
  final Object? color;
  final Object? borderWidth;
  final Object? selectedBorderWidth;
  final Object? borderRadius;
  final Object? padding;
  final Object? borderColor;
  final Object? selectedBorderColor;

  const RadioGroupThemeConfigGlobalDefaults({
    this.enabledCursor,
    this.disabledCursor,
    this.hoverColor,
    this.color,
    this.borderWidth,
    this.selectedBorderWidth,
    this.borderRadius,
    this.padding,
    this.borderColor,
    this.selectedBorderColor,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'enabledCursor': enabledCursor,
    'disabledCursor': disabledCursor,
    'hoverColor': hoverColor,
    'color': color,
    'borderWidth': borderWidth,
    'selectedBorderWidth': selectedBorderWidth,
    'borderRadius': borderRadius,
    'padding': padding,
    'borderColor': borderColor,
    'selectedBorderColor': selectedBorderColor,
  };
}

class RadioGroupThemeConfigRadioThemeDefaults {
  final Object? activeColor;
  final Object? borderColor;
  final Object? size;
  final Object? backgroundColor;

  const RadioGroupThemeConfigRadioThemeDefaults({
    this.activeColor,
    this.borderColor,
    this.size,
    this.backgroundColor,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'activeColor': activeColor,
    'borderColor': borderColor,
    'size': size,
    'backgroundColor': backgroundColor,
  };
}

const radioGroupThemeTokensConfigGlobalDefaults = RadioGroupThemeConfigGlobalDefaults();
const radioGroupThemeTokensConfigRadioThemeDefaults = RadioGroupThemeConfigRadioThemeDefaults();
