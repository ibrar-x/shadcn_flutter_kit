import 'base_slider_variant.dart';

/// Preset wrapper for `brightness` single slider.
class BrightnessSlider extends SingleSliderVariantBase {
  const BrightnessSlider({
    super.key,
    required super.value,
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
    super.fillStopsAtThumbCenter,
    super.fillEdgeBiasPx,
    super.trackBuilder,
    super.fillBuilder,
    super.thumbBuilder,
    super.ticksBuilder,
    super.overlayBuilder,
    super.semanticLabel,
  });

  @override
  String get presetName => 'brightness';
}
