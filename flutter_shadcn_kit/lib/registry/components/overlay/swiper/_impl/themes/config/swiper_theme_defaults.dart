// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class SwiperThemeDefaults {
  final Object? expands;
  final Object? draggable;
  final Object? barrierDismissible;
  final Object? backdropBuilder;
  final Object? useSafeArea;
  final Object? showDragHandle;
  final Object? borderRadius;
  final Object? dragHandleSize;
  final Object? transformBackdrop;
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? barrierColor;
  final Object? behavior;

  const SwiperThemeDefaults({
    this.expands,
    this.draggable,
    this.barrierDismissible,
    this.backdropBuilder,
    this.useSafeArea,
    this.showDragHandle,
    this.borderRadius,
    this.dragHandleSize,
    this.transformBackdrop,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.behavior = 'HitTestBehavior.translucent',
  });
}
