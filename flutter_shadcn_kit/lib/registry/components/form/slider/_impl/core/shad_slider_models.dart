import 'package:flutter/material.dart';

/// Builds the base track layer for the current slider state.
typedef ShadTrackBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);

/// Builds active/remaining fill layers for the current slider state.
typedef ShadFillBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);

/// Builds a single thumb widget from a thumb state snapshot.
typedef ShadThumbBuilder =
    Widget Function(BuildContext context, ShadThumbStateView thumb);

/// Builds ticks/marks layer.
typedef ShadTicksBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);

/// Builds optional overlay layer above thumbs.
typedef ShadOverlayBuilder =
    Widget Function(BuildContext context, ShadSliderStateView state);

/// Defines snapping behavior for slider values.
sealed class ShadSnap {
  const ShadSnap();
  const factory ShadSnap.none() = ShadSnapNone;
  const factory ShadSnap.steps(int steps) = ShadSnapSteps;
  const factory ShadSnap.values(List<double> values) = ShadSnapValues;
}

class ShadSnapNone extends ShadSnap {
  const ShadSnapNone();
}

/// Snap to equally-spaced steps in `[min, max]`.
class ShadSnapSteps extends ShadSnap {
  const ShadSnapSteps(this.steps) : assert(steps > 0);
  final int steps;
}

class ShadSnapValues extends ShadSnap {
  const ShadSnapValues(this.values);
  final List<double> values;
}

/// Value model for range sliders.
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
    required this.remainingRect,
    required this.rangeRect,
    required this.leftGapRect,
    required this.rightGapRect,
    required this.leftRemainingRect,
    required this.rightRemainingRect,
    required this.thumbs,
    required this.marks,
  });

  final double min;
  final double max;
  final bool enabled;
  final bool dragging;
  final int? activeThumb;
  final TextDirection textDirection;

  /// Track layout rect in the slider canvas.
  final Rect trackRect;

  /// Track corner radius used by renderers.
  final double trackRadius;

  /// Effective horizontal inset used by value<->pixel mapping.
  final double thumbInset;

  final bool isRange;
  final double? value;
  final ShadRangeValue? rangeValue;

  final double? t;
  final double? t0;
  final double? t1;

  /// Single-value active segment.
  final Rect? activeRect;

  /// Single-value remaining segment.
  final Rect? remainingRect;

  /// Selected segment for range sliders.
  final Rect? rangeRect;

  /// Gap around left/single thumb.
  final Rect? leftGapRect;

  /// Gap around right thumb in range mode.
  final Rect? rightGapRect;

  /// Left remaining segment in range mode.
  final Rect? leftRemainingRect;

  /// Right remaining segment in range mode.
  final Rect? rightRemainingRect;

  final List<ShadThumbStateView> thumbs;
  final List<ShadMarkLayout> marks;
}

/// Immutable layout/state snapshot for one thumb.
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

  /// Thumb center point in slider canvas coordinates.
  final Offset center;

  /// Logical size used for layout and gesture hit area.
  final Size size;
  final bool active;
  final bool enabled;
}

/// Mark/tick layout entry.
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

/// Output model for drag/tap update calculations.
class ShadUpdateResult {
  const ShadUpdateResult({this.singleValue, this.rangeValue});
  final double? singleValue;
  final ShadRangeValue? rangeValue;
}

/// Output model for hit-testing which thumb is active.
class ShadHitResult {
  const ShadHitResult({required this.activeThumb});
  final int? activeThumb;
}
