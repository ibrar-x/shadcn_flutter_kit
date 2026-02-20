// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class SelectThemeTokens {
  final Object? popupConstraints;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? borderRadius;
  final Object? padding;
  final Object? disableHoverEffect;
  final Object? canUnselect;
  final Object? autoClosePopover;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const SelectThemeTokens({
    this.popupConstraints,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.borderRadius,
    this.padding,
    this.disableHoverEffect,
    this.canUnselect,
    this.autoClosePopover,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const selectThemeTokens = SelectThemeTokens();
