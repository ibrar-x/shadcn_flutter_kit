import 'package:flutter/widgets.dart';

import '../core/shad_slider_renderers.dart';
import '../core/shad_slider_models.dart';
import '../../slider.dart';

/// Shared single-slider variant base.
abstract class SingleSliderVariantBase extends StatelessWidget {
  const SingleSliderVariantBase({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.enabled = true,
    this.snap = const ShadSnap.none(),
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
    this.trackBuilder,
    this.fillBuilder,
    this.thumbBuilder,
    this.ticksBuilder,
    this.overlayBuilder,
    this.segmentLayout,
    this.trackRenderer,
    this.semanticLabel,
  });

  final double value;
  final ValueChanged<double> onChanged;

  final double min;
  final double max;
  final bool enabled;
  final ShadSnap snap;

  final double? trackHeight;
  final double? trackRadius;
  final double? thumbInset;
  final Size? thumbSize;
  final double? thumbRadius;
  final double? thumbEdgeOffsetPx;
  final double? thumbVerticalOffsetPx;
  final double? joinGapPx;

  final bool? fillStopsAtThumbCenter;
  final double? fillEdgeBiasPx;

  final ShadTrackBuilder? trackBuilder;
  final ShadFillBuilder? fillBuilder;
  final ShadThumbBuilder? thumbBuilder;
  final ShadTicksBuilder? ticksBuilder;
  final ShadOverlayBuilder? overlayBuilder;
  final ShadSegmentLayout? segmentLayout;
  final ShadTrackRenderer? trackRenderer;

  final String? semanticLabel;

  String get presetName;

  ShadSnap get resolvedSnap => snap;

  @override
  Widget build(BuildContext context) {
    return Slider.single(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      enabled: enabled,
      snap: resolvedSnap,
      trackHeight: trackHeight,
      trackRadius: trackRadius,
      thumbInset: thumbInset,
      thumbSize: thumbSize,
      thumbRadius: thumbRadius,
      thumbEdgeOffsetPx: thumbEdgeOffsetPx,
      thumbVerticalOffsetPx: thumbVerticalOffsetPx,
      joinGapPx: joinGapPx,
      fillStopsAtThumbCenter: fillStopsAtThumbCenter,
      fillEdgeBiasPx: fillEdgeBiasPx,
      preset: presetName,
      trackBuilder: trackBuilder,
      fillBuilder: fillBuilder,
      thumbBuilder: thumbBuilder,
      ticksBuilder: ticksBuilder,
      overlayBuilder: overlayBuilder,
      segmentLayout: segmentLayout,
      trackRenderer: trackRenderer,
      semanticLabel: semanticLabel,
    );
  }
}

/// Shared range-slider variant base.
abstract class RangeSliderVariantBase extends StatelessWidget {
  const RangeSliderVariantBase({
    super.key,
    required this.rangeValue,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.enabled = true,
    this.snap = const ShadSnap.none(),
    this.trackHeight,
    this.trackRadius,
    this.thumbInset,
    this.thumbSize,
    this.thumbRadius,
    this.thumbEdgeOffsetPx,
    this.thumbVerticalOffsetPx,
    this.joinGapPx,
    this.minRange = 0,
    this.allowSwap = false,
    this.fillStopsAtThumbCenter,
    this.fillEdgeBiasPx,
    this.trackBuilder,
    this.fillBuilder,
    this.thumbBuilder,
    this.ticksBuilder,
    this.overlayBuilder,
    this.segmentLayout,
    this.trackRenderer,
    this.semanticLabel,
  });

  final ShadRangeValue rangeValue;
  final ValueChanged<ShadRangeValue> onChanged;

  final double min;
  final double max;
  final bool enabled;
  final ShadSnap snap;

  final double? trackHeight;
  final double? trackRadius;
  final double? thumbInset;
  final Size? thumbSize;
  final double? thumbRadius;
  final double? thumbEdgeOffsetPx;
  final double? thumbVerticalOffsetPx;
  final double? joinGapPx;
  final double minRange;
  final bool allowSwap;

  final bool? fillStopsAtThumbCenter;
  final double? fillEdgeBiasPx;

  final ShadTrackBuilder? trackBuilder;
  final ShadFillBuilder? fillBuilder;
  final ShadThumbBuilder? thumbBuilder;
  final ShadTicksBuilder? ticksBuilder;
  final ShadOverlayBuilder? overlayBuilder;
  final ShadSegmentLayout? segmentLayout;
  final ShadTrackRenderer? trackRenderer;

  final String? semanticLabel;

  String get presetName;

  ShadSnap get resolvedSnap => snap;

  @override
  Widget build(BuildContext context) {
    return Slider.range(
      rangeValue: rangeValue,
      onChanged: onChanged,
      min: min,
      max: max,
      enabled: enabled,
      snap: resolvedSnap,
      trackHeight: trackHeight,
      trackRadius: trackRadius,
      thumbInset: thumbInset,
      thumbSize: thumbSize,
      thumbRadius: thumbRadius,
      thumbEdgeOffsetPx: thumbEdgeOffsetPx,
      thumbVerticalOffsetPx: thumbVerticalOffsetPx,
      joinGapPx: joinGapPx,
      minRange: minRange,
      allowSwap: allowSwap,
      fillStopsAtThumbCenter: fillStopsAtThumbCenter,
      fillEdgeBiasPx: fillEdgeBiasPx,
      preset: presetName,
      trackBuilder: trackBuilder,
      fillBuilder: fillBuilder,
      thumbBuilder: thumbBuilder,
      ticksBuilder: ticksBuilder,
      overlayBuilder: overlayBuilder,
      segmentLayout: segmentLayout,
      trackRenderer: trackRenderer,
      semanticLabel: semanticLabel,
    );
  }
}
