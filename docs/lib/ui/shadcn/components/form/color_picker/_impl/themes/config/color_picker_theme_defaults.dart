import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in color picker widgets
// ═══════════════════════════════════════════════════════════

class ColorPickerThemeDefaults {
  const ColorPickerThemeDefaults({
    this.spacing = 12.0,
    this.controlSpacing = 8.0,
    this.orientation = Axis.vertical,
    this.enableEyeDropper = true,
    this.sliderSize = 24.0,
  });

  /// From `ColorPickerState`: `defaultValue: 12.0`
  final double spacing;

  /// From color picker controls/state: `defaultValue: 8.0`
  final double controlSpacing;

  /// From color picker state: `defaultValue: Axis.vertical`
  final Axis orientation;

  /// From `ColorControls`: `defaultValue: true`
  final bool enableEyeDropper;

  /// From `ColorPickerState.buildSliders`: `defaultValue: 24.0`
  final double sliderSize;
}
