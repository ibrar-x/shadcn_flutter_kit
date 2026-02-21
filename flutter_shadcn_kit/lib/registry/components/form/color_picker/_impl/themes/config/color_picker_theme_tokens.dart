import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror ColorPickerThemeDefaults
// ═══════════════════════════════════════════════════════════

class ColorPickerThemeTokens {
  const ColorPickerThemeTokens({
    this.spacing = 12.0,
    this.controlSpacing = 8.0,
    this.orientation = Axis.vertical,
    this.enableEyeDropper = true,
    this.sliderSize = 24.0,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final double spacing;
  final double controlSpacing;
  final Axis orientation;
  final bool enableEyeDropper;
  final double sliderSize;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const colorPickerThemeTokens = ColorPickerThemeTokens();
