// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class SwiperThemeDefaults {
  /// Widget fallback: true
  final Object? expands;

  /// Widget fallback: true
  final Object? draggable;

  /// Widget fallback: true
  final Object? barrierDismissible;

  /// Widget fallback: compTheme?.backdropBuilder
  final Object? backdropBuilder;

  /// Widget fallback: true
  final Object? useSafeArea;

  /// Widget fallback: true
  final Object? showDragHandle;

  /// Widget fallback: compTheme?.borderRadius
  final Object? borderRadius;

  /// Widget fallback: compTheme?.dragHandleSize
  final Object? dragHandleSize;

  /// Widget fallback: true
  final Object? transformBackdrop;

  /// Widget fallback: compTheme?.surfaceOpacity
  final Object? surfaceOpacity;

  /// Widget fallback: compTheme?.surfaceBlur
  final Object? surfaceBlur;

  /// Widget fallback: compTheme?.barrierColor
  final Object? barrierColor;

  /// Widget fallback: compTheme?.behavior ?? HitTestBehavior.translucent
  final Object? behavior;

  const SwiperThemeDefaults({
    this.expands = true,
    this.draggable = true,
    this.barrierDismissible = true,
    this.backdropBuilder,
    this.useSafeArea = true,
    this.showDragHandle = true,
    this.borderRadius,
    this.dragHandleSize,
    this.transformBackdrop = true,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.behavior,
  });
}
