// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class SliderThemeDefaults {
  final Object? trackHeight;
  final Object? trackRadius;
  final Object? thumbInset;
  final Object? thumbSize;
  final Object? thumbRadius;
  final Object? thumbEdgeOffsetPx;
  final Object? thumbVerticalOffsetPx;
  final Object? joinGapPx;
  final Object? fillStopsAtThumbCenter;
  final Object? fillEdgeBiasPx;
  final Object? preset;

  /// Widget fallback: defaults.trackBuilder
  final Object? trackBuilder;

  /// Widget fallback: defaults.fillBuilder
  final Object? fillBuilder;

  /// Widget fallback: defaults.thumbBuilder
  final Object? thumbBuilder;

  /// Widget fallback: defaults.ticksBuilder
  final Object? ticksBuilder;

  /// Widget fallback: defaults.overlayBuilder
  final Object? overlayBuilder;
  final Object? segmentLayout;
  final Object? trackRenderer;
  final Object? dragPopoverBuilder;
  final Object? dragPopoverOffset;
  final Object? dragPopoverVisibility;
  final Object? popoverShape;

  /// Widget fallback: cs.primary
  final Object? popoverBackgroundColor;

  /// Widget fallback: cs.background
  final Object? popoverForegroundColor;

  /// Widget fallback: cs.foreground.withOpacity(0.06
  final Object? guideColor;

  /// Widget fallback: cs.primary
  final Object? fillActiveColor;

  /// Widget fallback: cs.muted
  final Object? fillInactiveColor;

  /// Widget fallback: cs.background
  final Object? thumbFillColor;

  /// Widget fallback: cs.foreground.withOpacity(0.10
  final Object? thumbBorderColor;

  /// Widget fallback: cs.foreground.withOpacity(0.18
  final Object? dotsActiveColor;

  /// Widget fallback: cs.foreground.withOpacity(0.08
  final Object? dotsInactiveColor;

  /// Widget fallback: cs.background.withOpacity(0.52
  final Object? waveformTicksActiveColor;
  final Object? waveformTicksInactiveColor;
  final Object? waveHeight;
  final Object? wavePadding;
  final Object? waveBarWidth;
  final Object? waveBarGap;
  final Object? waveMinBarHeight;
  final Object? waveMaxBarHeight;
  final Object? waveCornerRadius;
  final Object? waveActiveColor;
  final Object? waveInactiveColor;
  final Object? waveDisabledOpacity;
  final Object? waveShowThumb;
  final Object? waveThumbRadius;
  final Object? waveThumbColor;
  final Object? waveThumbBorderColor;
  final Object? waveThumbBorderWidth;
  final Object? waveHitSlop;
  final Object? waveEnabled;
  final Object? wavePopoverBuilder;
  final Object? wavePopoverOffset;
  final Object? wavePopoverVisibility;

  const SliderThemeDefaults({
    this.trackHeight,
    this.trackRadius,
    this.thumbInset,
    this.thumbSize,
    this.thumbRadius,
    this.thumbEdgeOffsetPx,
    this.thumbVerticalOffsetPx,
    this.joinGapPx,
    this.fillStopsAtThumbCenter,
    this.fillEdgeBiasPx,
    this.preset,
    this.trackBuilder,
    this.fillBuilder,
    this.thumbBuilder,
    this.ticksBuilder,
    this.overlayBuilder,
    this.segmentLayout,
    this.trackRenderer,
    this.dragPopoverBuilder,
    this.dragPopoverOffset,
    this.dragPopoverVisibility,
    this.popoverShape,
    this.popoverBackgroundColor,
    this.popoverForegroundColor,
    this.guideColor,
    this.fillActiveColor,
    this.fillInactiveColor,
    this.thumbFillColor,
    this.thumbBorderColor,
    this.dotsActiveColor,
    this.dotsInactiveColor,
    this.waveformTicksActiveColor,
    this.waveformTicksInactiveColor,
    this.waveHeight,
    this.wavePadding,
    this.waveBarWidth,
    this.waveBarGap,
    this.waveMinBarHeight,
    this.waveMaxBarHeight,
    this.waveCornerRadius,
    this.waveActiveColor,
    this.waveInactiveColor,
    this.waveDisabledOpacity,
    this.waveShowThumb,
    this.waveThumbRadius,
    this.waveThumbColor,
    this.waveThumbBorderColor,
    this.waveThumbBorderWidth,
    this.waveHitSlop,
    this.waveEnabled,
    this.wavePopoverBuilder,
    this.wavePopoverOffset,
    this.wavePopoverVisibility,
  });
}
