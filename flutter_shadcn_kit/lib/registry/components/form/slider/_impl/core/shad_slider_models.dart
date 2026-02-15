import 'package:flutter/widgets.dart';

typedef ShadSliderTrackBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);
typedef ShadSliderFillBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);
typedef ShadSliderThumbBuilder =
    Widget Function(BuildContext context, ShadSliderThumbStateView thumb);
typedef ShadSliderTicksBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);
typedef ShadSliderOverlayBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);

sealed class ShadSliderSnap {
  const ShadSliderSnap();
  const factory ShadSliderSnap.none() = ShadSliderSnapNone;
  const factory ShadSliderSnap.steps(int steps) = ShadSliderSnapSteps;
  const factory ShadSliderSnap.values(List<double> values) =
      ShadSliderSnapValues;
}

class ShadSliderSnapNone extends ShadSliderSnap {
  const ShadSliderSnapNone();
}

class ShadSliderSnapSteps extends ShadSliderSnap {
  const ShadSliderSnapSteps(this.steps) : assert(steps > 0);
  final int steps;
}

class ShadSliderSnapValues extends ShadSliderSnap {
  const ShadSliderSnapValues(this.values);
  final List<double> values;
}

class ShadSliderRangeValue {
  const ShadSliderRangeValue(
    this.start,
    this.end, {
    this.minRange = 0,
    this.allowSwap = false,
  });

  final double start;
  final double end;
  final double minRange;
  final bool allowSwap;

  ShadSliderRangeValue copyWith({
    double? start,
    double? end,
    double? minRange,
    bool? allowSwap,
  }) {
    return ShadSliderRangeValue(
      start ?? this.start,
      end ?? this.end,
      minRange: minRange ?? this.minRange,
      allowSwap: allowSwap ?? this.allowSwap,
    );
  }
}

class ShadSliderStateView {
  const ShadSliderStateView({
    required this.min,
    required this.max,
    required this.enabled,
    required this.dragging,
    required this.activeThumb,
    required this.textDirection,
    required this.trackRect,
    required this.trackRadius,
    required this.thumbInset,
    required this.isRange,
    required this.value,
    required this.rangeValue,
    required this.t,
    required this.tStart,
    required this.tEnd,
    required this.activeRect,
    required this.rangeRect,
    required this.thumbs,
    required this.marks,
  });

  final double min;
  final double max;
  final bool enabled;
  final bool dragging;
  final int? activeThumb;
  final TextDirection textDirection;

  final Rect trackRect;
  final double trackRadius;
  final double thumbInset;

  final bool isRange;
  final double? value;
  final ShadSliderRangeValue? rangeValue;

  final double? t;
  final double? tStart;
  final double? tEnd;

  final Rect? activeRect;
  final Rect? rangeRect;

  final List<ShadSliderThumbStateView> thumbs;
  final List<ShadSliderMarkLayout> marks;
}

class ShadSliderThumbStateView {
  const ShadSliderThumbStateView({
    required this.index,
    required this.value,
    required this.t,
    required this.center,
    required this.size,
    required this.active,
    required this.enabled,
  });

  final int index;
  final double value;
  final double t;
  final Offset center;
  final Size size;
  final bool active;
  final bool enabled;
}

class ShadSliderMarkLayout {
  const ShadSliderMarkLayout({
    required this.value,
    required this.t,
    required this.x,
    this.label,
    this.isMajor = true,
  });

  final double value;
  final double t;
  final double x;
  final String? label;
  final bool isMajor;
}

class ShadSliderUpdateResult {
  const ShadSliderUpdateResult({
    this.singleValue,
    this.rangeValue,
    this.activeThumb,
  });

  final double? singleValue;
  final ShadSliderRangeValue? rangeValue;
  final int? activeThumb;
}

class ShadSliderHitResult {
  const ShadSliderHitResult({required this.activeThumb});

  final int activeThumb;
}
