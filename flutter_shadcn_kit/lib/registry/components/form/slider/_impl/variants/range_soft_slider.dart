import 'base_slider_variant.dart';

/// Preset wrapper for `rangeSoft` range slider.
class RangeSoftSlider extends RangeSliderVariantBase {
  const RangeSoftSlider({
    super.key,
    required super.rangeValue,
    required super.onChanged,
    super.min,
    super.max,
    super.enabled,
    super.snap,
    super.trackHeight,
    super.trackRadius,
    super.thumbInset,
    super.thumbSize,
    super.thumbRadius,
    super.thumbEdgeOffsetPx,
    super.thumbVerticalOffsetPx,
    super.joinGapPx,
    super.minRange,
    super.allowSwap,
    super.fillStopsAtThumbCenter,
    super.fillEdgeBiasPx,
    super.trackBuilder,
    super.fillBuilder,
    super.thumbBuilder,
    super.ticksBuilder,
    super.overlayBuilder,
    super.segmentLayout,
    super.trackRenderer,
    super.dragPopoverBuilder,
    super.dragPopoverOffset,
    super.semanticLabel,
  });

  @override
  String get presetName => 'rangeSoft';
}
