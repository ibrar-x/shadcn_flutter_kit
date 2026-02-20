// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class ToastThemeTokens {
  final Object? padding;
  final Object? margin;
  final Object? duration;
  final Object? animationDuration;
  final Object? animationCurve;
  final Object? width;
  final Object? borderRadius;
  final Object? backgroundColor;
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
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const ToastThemeTokens({
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
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const toastThemeTokens = ToastThemeTokens();
