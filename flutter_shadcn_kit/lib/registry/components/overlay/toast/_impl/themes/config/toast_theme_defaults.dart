// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class ToastThemeDefaults {
  final Object? padding;
  final Object? margin;

  /// Widget fallback: defaultDuration
  final Object? duration;
  final Object? animationDuration;

  /// Widget fallback: Curves.easeOut
  final Object? animationCurve;
  final Object? width;
  final Object? borderRadius;
  final Object? backgroundColor;

  /// Widget fallback: toastTheme?.pauseOnHover ?? false
  final Object? pauseOnHover;
  final Object? dismissDirections;
  final Object? dismissDragThreshold;
  final Object? overlapStackWhenMultiple;
  final Object? overlapStackOffset;
  final Object? pauseAutoDismissWhenMultiple;
  final Object? stackAnimationDuration;
  final Object? stackAnimationCurve;
  final Object? maxVisibleCount;
  final Object? dismissWholeStackWhenMultiple;

  const ToastThemeDefaults({
    this.padding,
    this.margin,
    this.duration,
    this.animationDuration,
    this.animationCurve,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.pauseOnHover,
    this.dismissDirections,
    this.dismissDragThreshold,
    this.overlapStackWhenMultiple,
    this.overlapStackOffset,
    this.pauseAutoDismissWhenMultiple,
    this.stackAnimationDuration,
    this.stackAnimationCurve,
    this.maxVisibleCount,
    this.dismissWholeStackWhenMultiple,
  });
}
