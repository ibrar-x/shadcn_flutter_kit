// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class SelectThemeDefaults {
  final Object? popupConstraints;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? borderRadius;
  final Object? padding;
  final Object? disableHoverEffect;
  final Object? canUnselect;

  /// Widget fallback: true
  final Object? autoClosePopover;

  const SelectThemeDefaults({
    this.popupConstraints,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.borderRadius,
    this.padding,
    this.disableHoverEffect,
    this.canUnselect,
    this.autoClosePopover = true,
  });
}
