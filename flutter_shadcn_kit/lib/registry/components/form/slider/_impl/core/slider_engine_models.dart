part of '../../slider.dart';

enum _SliderSnapMode { none, steps, customValues }

typedef SliderTrackBuilder =
    Widget Function(BuildContext context, SliderStateView state);
typedef SliderFillBuilder =
    Widget Function(BuildContext context, SliderStateView state);
typedef SliderThumbBuilder =
    Widget Function(BuildContext context, SliderThumbStateView state);
typedef SliderTicksBuilder =
    Widget Function(BuildContext context, SliderStateView state);
typedef SliderOverlayBuilder =
    Widget Function(BuildContext context, SliderStateView state);

/// Describes snapping behavior for slider interactions.
class SliderSnap {
  final _SliderSnapMode _mode;
  final int? stepCount;
  final List<double>? snapValues;

  const SliderSnap.none()
    : _mode = _SliderSnapMode.none,
      stepCount = null,
      snapValues = null;

  const SliderSnap.steps(this.stepCount)
    : _mode = _SliderSnapMode.steps,
      snapValues = null;

  const SliderSnap.values(this.snapValues)
    : _mode = _SliderSnapMode.customValues,
      stepCount = null;
}

/// Geometry and interaction snapshot used by render builders.
class SliderStateView {
  final Rect trackRect;
  final Rect activeRect;
  final bool isRange;
  final double t;
  final double tStart;
  final double tEnd;
  final double value;
  final double valueStart;
  final double valueEnd;
  final bool hovering;
  final bool dragging;
  final bool enabled;
  final int? divisions;
  final TextDirection textDirection;

  const SliderStateView({
    required this.trackRect,
    required this.activeRect,
    required this.isRange,
    required this.t,
    required this.tStart,
    required this.tEnd,
    required this.value,
    required this.valueStart,
    required this.valueEnd,
    required this.hovering,
    required this.dragging,
    required this.enabled,
    required this.divisions,
    required this.textDirection,
  });
}

/// Geometry and interaction snapshot used by thumb builders.
class SliderThumbStateView {
  final Rect trackRect;
  final Offset center;
  final bool isStartThumb;
  final bool isEndThumb;
  final bool isActiveThumb;
  final bool focused;
  final bool dragging;
  final bool enabled;
  final double t;
  final double value;
  final double size;
  final Color color;
  final Color borderColor;
  final double borderWidth;

  const SliderThumbStateView({
    required this.trackRect,
    required this.center,
    required this.isStartThumb,
    required this.isEndThumb,
    required this.isActiveThumb,
    required this.focused,
    required this.dragging,
    required this.enabled,
    required this.t,
    required this.value,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.borderWidth,
  });
}

enum _ActiveThumb { single, start, end }
