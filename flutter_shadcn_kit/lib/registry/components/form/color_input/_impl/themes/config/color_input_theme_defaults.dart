import 'package:flutter/widgets.dart';

import '../../../../color_picker/color_picker.dart';
import '../../../../form_field/form_field.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class ColorInputThemeDefaults {
  const ColorInputThemeDefaults({
    this.showAlpha = true,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment = Alignment.bottomCenter,
    this.popoverPadding,
    this.mode = PromptMode.popover,
    this.pickerMode = ColorPickerMode.rgb,
    this.enableEyeDropper = true,
    this.showLabel = false,
    this.orientation,
    this.showHistory = true,
  });

  final bool showAlpha;
  final AlignmentGeometry popoverAlignment;
  final AlignmentGeometry popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final PromptMode mode;
  final ColorPickerMode pickerMode;
  final bool enableEyeDropper;
  final bool showLabel;
  final Axis? orientation;
  final bool showHistory;
}
