import '../core/shad_slider_models.dart';
import 'base_slider_variant.dart';

/// Preset wrapper for `stepsDots` single slider.
class StepsDotsSlider extends SingleSliderVariantBase {
  const StepsDotsSlider({
    super.key,
    required super.value,
    required super.onChanged,
    this.steps = 10,
    super.min,
    super.max,
    super.enabled,
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
  }) : assert(steps > 0);

  final int steps;

  @override
  String get presetName => 'stepsDots';

  @override
  ShadSnap get resolvedSnap => ShadSnap.steps(steps);
}
