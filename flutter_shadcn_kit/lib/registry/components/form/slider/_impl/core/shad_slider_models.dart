import 'package:flutter/material.dart';

typedef ShadTrackBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);
typedef ShadFillBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);
typedef ShadThumbBuilder =
    Widget Function(BuildContext context, ShadThumbStateView thumb);
typedef ShadTicksBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);
typedef ShadOverlayBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);

sealed class ShadSnap {
  const ShadSnap();
  const factory ShadSnap.none() = ShadSnapNone;
  const factory ShadSnap.steps(int steps) = ShadSnapSteps;
  const factory ShadSnap.values(List<double> values) = ShadSnapValues;
}

class ShadSnapNone extends ShadSnap {
  const ShadSnapNone();
}

class ShadSnapSteps extends ShadSnap {
  const ShadSnapSteps(this.steps) : assert(steps > 0);
  final int steps;
}

class ShadSnapValues extends ShadSnap {
  const ShadSnapValues(this.values);
  final List<double> values;
}

class ShadRangeValue {
  const ShadRangeValue(
    this.start,
    this.end, {
    this.minRange = 0,
    this.allowSwap = false,
  });

  final double start;
  final double end;
  final double minRange;
  final bool allowSwap;

  ShadRangeValue copyWith({
    double? start,
    double? end,
    double? minRange,
    bool? allowSwap,
  }) {
    return ShadRangeValue(
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
    required this.t0,
    required this.t1,
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
  final ShadRangeValue? rangeValue;

  final double? t;
  final double? t0;
  final double? t1;

  final Rect? activeRect;
  final Rect? rangeRect;

  final List<ShadThumbStateView> thumbs;
  final List<ShadMarkLayout> marks;
}

class ShadThumbStateView {
  const ShadThumbStateView({
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

class ShadMarkLayout {
  const ShadMarkLayout({
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

class ShadUpdateResult {
  const ShadUpdateResult({this.singleValue, this.rangeValue});
  final double? singleValue;
  final ShadRangeValue? rangeValue;
}

class ShadHitResult {
  const ShadHitResult({required this.activeThumb});
  final int? activeThumb;
}
