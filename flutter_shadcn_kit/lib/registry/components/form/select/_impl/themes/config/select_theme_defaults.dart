import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class SelectThemeDefaults {
  const SelectThemeDefaults({
    this.popupConstraints,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.borderRadius,
    this.padding,
    this.disableHoverEffect = false,
    this.canUnselect = false,
    this.autoClosePopover = true,
  });

  final BoxConstraints? popupConstraints;
  final AlignmentGeometry popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool disableHoverEffect;
  final bool canUnselect;
  final bool autoClosePopover;
}
