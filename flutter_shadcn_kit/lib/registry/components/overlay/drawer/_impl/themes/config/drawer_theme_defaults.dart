// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class DrawerThemeDefaults {
  /// Widget fallback: = theme?.surfaceOpacity
  final Object? surfaceOpacity;

  /// Widget fallback: = theme?.surfaceBlur
  final Object? surfaceBlur;

  /// Widget fallback: = theme?.barrierColor
  final Object? barrierColor;

  /// Widget fallback: = theme?.showDragHandle ?? true
  final Object? showDragHandle;

  /// Widget fallback: = theme?.dragHandleSize
  final Object? dragHandleSize;

  const DrawerThemeDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.showDragHandle,
    this.dragHandleSize,
  });
}
