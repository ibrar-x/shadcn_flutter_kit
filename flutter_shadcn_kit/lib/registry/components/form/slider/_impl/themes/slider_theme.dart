import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';
import '../core/shad_slider_renderers.dart';
import '../core/shad_slider_models.dart';

/// Theme data for [Slider] and [WaveSlider].
class SliderTheme extends ComponentThemeData {
  /// Track height in logical pixels.
  final double? trackHeight;

  /// Track radius in logical pixels. Clamped by runtime to half track height.
  final double? trackRadius;

  /// Base horizontal inset used for value-to-position mapping.
  final double? thumbInset;

  /// Thumb layout size used for paint and hit calculations.
  final Size? thumbSize;

  /// Optional corner radius for default bar thumb.
  final double? thumbRadius;

  /// Horizontal thumb edge offset.
  ///
  /// - `0`: inside track
  /// - positive: moves toward/outside edges
  /// - negative: moves further inside
  final double? thumbEdgeOffsetPx;

  /// Vertical thumb offset from track center.
  ///
  /// - positive: down
  /// - negative: up
  final double? thumbVerticalOffsetPx;

  /// Gap between active and remaining segments around thumb centers.
  final double? joinGapPx;

  /// Whether fill computations align to thumb centers.
  final bool? fillStopsAtThumbCenter;

  /// Extra fill edge bias in logical pixels.
  final double? fillEdgeBiasPx;

  /// Preset name (`brightness`, `rangeSoft`, `stepsDots`, `waveform`).
  final String? preset;

  /// Optional custom track builder.
  final ShadTrackBuilder? trackBuilder;

  /// Optional custom fill builder.
  final ShadFillBuilder? fillBuilder;

  /// Optional custom thumb builder.
  final ShadThumbBuilder? thumbBuilder;

  /// Optional custom ticks builder.
  final ShadTicksBuilder? ticksBuilder;

  /// Optional custom overlay builder.
  final ShadOverlayBuilder? overlayBuilder;

  /// Optional segment geometry strategy.
  final ShadSegmentLayout? segmentLayout;

  /// Optional unified track renderer.
  final ShadTrackRenderer? trackRenderer;

  /// Optional drag popover builder shown for active thumb while dragging.
  final ShadDragPopoverBuilder? dragPopoverBuilder;

  /// Popover anchor offset in logical pixels.
  final Offset? dragPopoverOffset;

  /// Guide line color used by default track builder.
  final Color? guideColor;

  /// Active fill color used by default fill builder.
  final Color? fillActiveColor;

  /// Remaining fill color used by default fill builder.
  final Color? fillInactiveColor;

  /// Default thumb fill color (applies to bar/square/circle helpers).
  final Color? thumbFillColor;

  /// Default thumb border color (applies to bar/square/circle helpers).
  final Color? thumbBorderColor;

  /// Active color for default dots ticks.
  final Color? dotsActiveColor;

  /// Inactive color for default dots ticks.
  final Color? dotsInactiveColor;

  /// Active inner-bar color for default waveform ticks.
  final Color? waveformTicksActiveColor;

  /// Inactive inner-bar color for default waveform ticks.
  final Color? waveformTicksInactiveColor;

  /// Wave variant height in logical pixels.
  final double? waveHeight;

  /// Wave variant content padding.
  final EdgeInsets? wavePadding;

  /// Wave bar width in logical pixels.
  final double? waveBarWidth;

  /// Wave bar gap in logical pixels.
  final double? waveBarGap;

  /// Wave minimum bar height in logical pixels.
  final double? waveMinBarHeight;

  /// Wave maximum bar height in logical pixels.
  final double? waveMaxBarHeight;

  /// Wave bar corner radius.
  final double? waveCornerRadius;

  /// Wave active/progressed color.
  final Color? waveActiveColor;

  /// Wave inactive/remaining color.
  final Color? waveInactiveColor;

  /// Wave disabled opacity.
  final double? waveDisabledOpacity;

  /// Whether wave slider shows thumb.
  final bool? waveShowThumb;

  /// Wave thumb radius.
  final double? waveThumbRadius;

  /// Wave thumb fill color.
  final Color? waveThumbColor;

  /// Wave thumb border color.
  final Color? waveThumbBorderColor;

  /// Wave thumb border width.
  final double? waveThumbBorderWidth;

  /// Wave hit slop for easier dragging.
  final double? waveHitSlop;

  /// Enables wave interaction.
  final bool? waveEnabled;

  /// Creates theme overrides for [Slider] and [WaveSlider].
  const SliderTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
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
  });

  /// Returns a copy with selected fields replaced.
  SliderTheme copyWith({
    ValueGetter<double?>? trackHeight,
    ValueGetter<double?>? trackRadius,
    ValueGetter<double?>? thumbInset,
    ValueGetter<Size?>? thumbSize,
    ValueGetter<double?>? thumbRadius,
    ValueGetter<double?>? thumbEdgeOffsetPx,
    ValueGetter<double?>? thumbVerticalOffsetPx,
    ValueGetter<double?>? joinGapPx,
    ValueGetter<bool?>? fillStopsAtThumbCenter,
    ValueGetter<double?>? fillEdgeBiasPx,
    ValueGetter<String?>? preset,
    ValueGetter<ShadTrackBuilder?>? trackBuilder,
    ValueGetter<ShadFillBuilder?>? fillBuilder,
    ValueGetter<ShadThumbBuilder?>? thumbBuilder,
    ValueGetter<ShadTicksBuilder?>? ticksBuilder,
    ValueGetter<ShadOverlayBuilder?>? overlayBuilder,
    ValueGetter<ShadSegmentLayout?>? segmentLayout,
    ValueGetter<ShadTrackRenderer?>? trackRenderer,
    ValueGetter<ShadDragPopoverBuilder?>? dragPopoverBuilder,
    ValueGetter<Offset?>? dragPopoverOffset,
    ValueGetter<Color?>? guideColor,
    ValueGetter<Color?>? fillActiveColor,
    ValueGetter<Color?>? fillInactiveColor,
    ValueGetter<Color?>? thumbFillColor,
    ValueGetter<Color?>? thumbBorderColor,
    ValueGetter<Color?>? dotsActiveColor,
    ValueGetter<Color?>? dotsInactiveColor,
    ValueGetter<Color?>? waveformTicksActiveColor,
    ValueGetter<Color?>? waveformTicksInactiveColor,
    ValueGetter<double?>? waveHeight,
    ValueGetter<EdgeInsets?>? wavePadding,
    ValueGetter<double?>? waveBarWidth,
    ValueGetter<double?>? waveBarGap,
    ValueGetter<double?>? waveMinBarHeight,
    ValueGetter<double?>? waveMaxBarHeight,
    ValueGetter<double?>? waveCornerRadius,
    ValueGetter<Color?>? waveActiveColor,
    ValueGetter<Color?>? waveInactiveColor,
    ValueGetter<double?>? waveDisabledOpacity,
    ValueGetter<bool?>? waveShowThumb,
    ValueGetter<double?>? waveThumbRadius,
    ValueGetter<Color?>? waveThumbColor,
    ValueGetter<Color?>? waveThumbBorderColor,
    ValueGetter<double?>? waveThumbBorderWidth,
    ValueGetter<double?>? waveHitSlop,
    ValueGetter<bool?>? waveEnabled,
  }) {
    return SliderTheme(
      trackHeight: trackHeight == null ? this.trackHeight : trackHeight(),
      trackRadius: trackRadius == null ? this.trackRadius : trackRadius(),
      thumbInset: thumbInset == null ? this.thumbInset : thumbInset(),
      thumbSize: thumbSize == null ? this.thumbSize : thumbSize(),
      thumbRadius: thumbRadius == null ? this.thumbRadius : thumbRadius(),
      thumbEdgeOffsetPx: thumbEdgeOffsetPx == null
          ? this.thumbEdgeOffsetPx
          : thumbEdgeOffsetPx(),
      thumbVerticalOffsetPx: thumbVerticalOffsetPx == null
          ? this.thumbVerticalOffsetPx
          : thumbVerticalOffsetPx(),
      joinGapPx: joinGapPx == null ? this.joinGapPx : joinGapPx(),
      fillStopsAtThumbCenter: fillStopsAtThumbCenter == null
          ? this.fillStopsAtThumbCenter
          : fillStopsAtThumbCenter(),
      fillEdgeBiasPx: fillEdgeBiasPx == null
          ? this.fillEdgeBiasPx
          : fillEdgeBiasPx(),
      preset: preset == null ? this.preset : preset(),
      trackBuilder: trackBuilder == null ? this.trackBuilder : trackBuilder(),
      fillBuilder: fillBuilder == null ? this.fillBuilder : fillBuilder(),
      thumbBuilder: thumbBuilder == null ? this.thumbBuilder : thumbBuilder(),
      ticksBuilder: ticksBuilder == null ? this.ticksBuilder : ticksBuilder(),
      overlayBuilder: overlayBuilder == null
          ? this.overlayBuilder
          : overlayBuilder(),
      segmentLayout: segmentLayout == null
          ? this.segmentLayout
          : segmentLayout(),
      trackRenderer: trackRenderer == null
          ? this.trackRenderer
          : trackRenderer(),
      dragPopoverBuilder: dragPopoverBuilder == null
          ? this.dragPopoverBuilder
          : dragPopoverBuilder(),
      dragPopoverOffset: dragPopoverOffset == null
          ? this.dragPopoverOffset
          : dragPopoverOffset(),
      guideColor: guideColor == null ? this.guideColor : guideColor(),
      fillActiveColor: fillActiveColor == null
          ? this.fillActiveColor
          : fillActiveColor(),
      fillInactiveColor: fillInactiveColor == null
          ? this.fillInactiveColor
          : fillInactiveColor(),
      thumbFillColor: thumbFillColor == null
          ? this.thumbFillColor
          : thumbFillColor(),
      thumbBorderColor: thumbBorderColor == null
          ? this.thumbBorderColor
          : thumbBorderColor(),
      dotsActiveColor: dotsActiveColor == null
          ? this.dotsActiveColor
          : dotsActiveColor(),
      dotsInactiveColor: dotsInactiveColor == null
          ? this.dotsInactiveColor
          : dotsInactiveColor(),
      waveformTicksActiveColor: waveformTicksActiveColor == null
          ? this.waveformTicksActiveColor
          : waveformTicksActiveColor(),
      waveformTicksInactiveColor: waveformTicksInactiveColor == null
          ? this.waveformTicksInactiveColor
          : waveformTicksInactiveColor(),
      waveHeight: waveHeight == null ? this.waveHeight : waveHeight(),
      wavePadding: wavePadding == null ? this.wavePadding : wavePadding(),
      waveBarWidth: waveBarWidth == null ? this.waveBarWidth : waveBarWidth(),
      waveBarGap: waveBarGap == null ? this.waveBarGap : waveBarGap(),
      waveMinBarHeight: waveMinBarHeight == null
          ? this.waveMinBarHeight
          : waveMinBarHeight(),
      waveMaxBarHeight: waveMaxBarHeight == null
          ? this.waveMaxBarHeight
          : waveMaxBarHeight(),
      waveCornerRadius: waveCornerRadius == null
          ? this.waveCornerRadius
          : waveCornerRadius(),
      waveActiveColor: waveActiveColor == null
          ? this.waveActiveColor
          : waveActiveColor(),
      waveInactiveColor: waveInactiveColor == null
          ? this.waveInactiveColor
          : waveInactiveColor(),
      waveDisabledOpacity: waveDisabledOpacity == null
          ? this.waveDisabledOpacity
          : waveDisabledOpacity(),
      waveShowThumb: waveShowThumb == null
          ? this.waveShowThumb
          : waveShowThumb(),
      waveThumbRadius: waveThumbRadius == null
          ? this.waveThumbRadius
          : waveThumbRadius(),
      waveThumbColor: waveThumbColor == null
          ? this.waveThumbColor
          : waveThumbColor(),
      waveThumbBorderColor: waveThumbBorderColor == null
          ? this.waveThumbBorderColor
          : waveThumbBorderColor(),
      waveThumbBorderWidth: waveThumbBorderWidth == null
          ? this.waveThumbBorderWidth
          : waveThumbBorderWidth(),
      waveHitSlop: waveHitSlop == null ? this.waveHitSlop : waveHitSlop(),
      waveEnabled: waveEnabled == null ? this.waveEnabled : waveEnabled(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SliderTheme &&
        other.trackHeight == trackHeight &&
        other.trackRadius == trackRadius &&
        other.thumbInset == thumbInset &&
        other.thumbSize == thumbSize &&
        other.thumbRadius == thumbRadius &&
        other.thumbEdgeOffsetPx == thumbEdgeOffsetPx &&
        other.thumbVerticalOffsetPx == thumbVerticalOffsetPx &&
        other.joinGapPx == joinGapPx &&
        other.fillStopsAtThumbCenter == fillStopsAtThumbCenter &&
        other.fillEdgeBiasPx == fillEdgeBiasPx &&
        other.preset == preset &&
        other.trackBuilder == trackBuilder &&
        other.fillBuilder == fillBuilder &&
        other.thumbBuilder == thumbBuilder &&
        other.ticksBuilder == ticksBuilder &&
        other.overlayBuilder == overlayBuilder &&
        other.segmentLayout == segmentLayout &&
        other.trackRenderer == trackRenderer &&
        other.dragPopoverBuilder == dragPopoverBuilder &&
        other.dragPopoverOffset == dragPopoverOffset &&
        other.guideColor == guideColor &&
        other.fillActiveColor == fillActiveColor &&
        other.fillInactiveColor == fillInactiveColor &&
        other.thumbFillColor == thumbFillColor &&
        other.thumbBorderColor == thumbBorderColor &&
        other.dotsActiveColor == dotsActiveColor &&
        other.dotsInactiveColor == dotsInactiveColor &&
        other.waveformTicksActiveColor == waveformTicksActiveColor &&
        other.waveformTicksInactiveColor == waveformTicksInactiveColor &&
        other.waveHeight == waveHeight &&
        other.wavePadding == wavePadding &&
        other.waveBarWidth == waveBarWidth &&
        other.waveBarGap == waveBarGap &&
        other.waveMinBarHeight == waveMinBarHeight &&
        other.waveMaxBarHeight == waveMaxBarHeight &&
        other.waveCornerRadius == waveCornerRadius &&
        other.waveActiveColor == waveActiveColor &&
        other.waveInactiveColor == waveInactiveColor &&
        other.waveDisabledOpacity == waveDisabledOpacity &&
        other.waveShowThumb == waveShowThumb &&
        other.waveThumbRadius == waveThumbRadius &&
        other.waveThumbColor == waveThumbColor &&
        other.waveThumbBorderColor == waveThumbBorderColor &&
        other.waveThumbBorderWidth == waveThumbBorderWidth &&
        other.waveHitSlop == waveHitSlop &&
        other.waveEnabled == waveEnabled;
  }

  @override
  int get hashCode => Object.hashAll([
    trackHeight,
    trackRadius,
    thumbInset,
    thumbSize,
    thumbRadius,
    thumbEdgeOffsetPx,
    thumbVerticalOffsetPx,
    joinGapPx,
    fillStopsAtThumbCenter,
    fillEdgeBiasPx,
    preset,
    trackBuilder,
    fillBuilder,
    thumbBuilder,
    ticksBuilder,
    overlayBuilder,
    segmentLayout,
    trackRenderer,
    dragPopoverBuilder,
    dragPopoverOffset,
    guideColor,
    fillActiveColor,
    fillInactiveColor,
    thumbFillColor,
    thumbBorderColor,
    dotsActiveColor,
    dotsInactiveColor,
    waveformTicksActiveColor,
    waveformTicksInactiveColor,
    waveHeight,
    wavePadding,
    waveBarWidth,
    waveBarGap,
    waveMinBarHeight,
    waveMaxBarHeight,
    waveCornerRadius,
    waveActiveColor,
    waveInactiveColor,
    waveDisabledOpacity,
    waveShowThumb,
    waveThumbRadius,
    waveThumbColor,
    waveThumbBorderColor,
    waveThumbBorderWidth,
    waveHitSlop,
    waveEnabled,
  ]);
}
