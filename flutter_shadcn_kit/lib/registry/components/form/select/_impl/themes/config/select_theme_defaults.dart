// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class SelectThemeDefaults {
  final Object? popupConstraints;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? borderRadius;
  final Object? padding;
  final Object? disableHoverEffect;
  final Object? canUnselect;
  final Object? autoClosePopover;

  const SelectThemeDefaults({
    this.popupConstraints,
    this.popoverAlignment = 'Alignment.topCenter',
    this.popoverAnchorAlignment,
    this.borderRadius,
    this.padding,
    this.disableHoverEffect = false,
    this.canUnselect = false,
    this.autoClosePopover = true,
  });
}
