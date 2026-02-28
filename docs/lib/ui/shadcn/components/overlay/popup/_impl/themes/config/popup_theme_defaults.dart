import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class MenuPopupThemeDefaults {
  const MenuPopupThemeDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });

  final double? surfaceOpacity;
  final double? surfaceBlur;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
}
