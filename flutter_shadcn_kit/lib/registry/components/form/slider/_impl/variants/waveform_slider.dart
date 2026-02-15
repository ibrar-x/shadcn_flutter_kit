import 'base_slider_variant.dart';

/// Preset wrapper for `waveform` single slider.
class WaveformSlider extends SingleSliderVariantBase {
  const WaveformSlider({
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
    super.segmentLayout,
    super.trackRenderer,
    super.dragPopoverBuilder,
    super.dragPopoverOffset,
    super.dragPopoverVisibility,
    super.semanticLabel,
  });

  @override
  String get presetName => 'waveform';
}
