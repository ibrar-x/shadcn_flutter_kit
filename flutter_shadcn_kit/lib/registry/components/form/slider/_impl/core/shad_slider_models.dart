import 'dart:math' as math;

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

/// Builds a drag popover anchored to the active thumb.
typedef ShadDragPopoverBuilder =
    Widget Function(
      BuildContext context,
      ShadSliderStateView state,
      ShadThumbStateView thumb,
    );

/// Builds a popover for [WaveSlider].
typedef ShadWavePopoverBuilder =
    Widget Function(
      BuildContext context,
      double normalizedValue,
      double denormalizedValue,
    );

/// Controls when slider popovers are visible.
enum ShadPopoverVisibility {
  /// Never show popover.
  never,

  /// Show popover only while dragging/tapping.
  whileDragging,

  /// Keep popover visible even when idle.
  always,
}

/// Built-in popover shape options used by default helper builders.
enum ShadPopoverShape {
  /// Capsule-like rounded ends.
  pill,

  /// Medium rounded rectangle.
  rounded,

  /// Square rectangle with subtle corners.
  square,
}

/// Resolves per-segment style during segmented rendering.
typedef ShadSegmentStyleResolver =
    ShadSegmentStyle Function(
      BuildContext context,
      ShadSliderStateView view,
      ShadSegment segment,
    );

/// Declarative style for one rendered segment.
class ShadSegmentStyle {
  const ShadSegmentStyle({
    this.color,
    this.gradient,
    this.border,
    this.radius,
    this.opacity,
  });

  final Color? color;
  final Gradient? gradient;
  final BoxBorder? border;
  final BorderRadius? radius;
  final double? opacity;
}

enum ShadSegmentKind { fill, remaining, gap, disabled, custom }

class ShadSegment {
  const ShadSegment({
    required this.kind,
    required this.rect,
    this.radius,
    this.paintOrder = 0,
    this.meta = const <String, Object?>{},
  });

  final ShadSegmentKind kind;
  final Rect rect;

  /// Optional radius override for this segment.
  final BorderRadius? radius;

  /// If you want to draw some things above others.
  final int paintOrder;

  /// Any extra info renderers may need.
  final Map<String, Object?> meta;
}

enum ShadGapEndsPolicy { always, noneAtMinMax, noneAlways }

enum ShadSegmentRadiusPolicy { fullPills, flatJoin, custom }

abstract class ShadSegmentLayout {
  const ShadSegmentLayout();

  List<ShadSegment> buildSegments({
    required Rect trackRect,
    required double trackRadius,
    required TextDirection textDirection,
    required bool isRange,
    required double min,
    required double max,
    required double? value,
    required ShadRangeValue? rangeValue,
    required List<ShadThumbStateView> thumbs,
  });
}

class ShadContinuousLayout extends ShadSegmentLayout {
  const ShadContinuousLayout({
    this.segmentRadius = ShadSegmentRadiusPolicy.fullPills,
  });

  final ShadSegmentRadiusPolicy segmentRadius;

  @override
  List<ShadSegment> buildSegments({
    required Rect trackRect,
    required double trackRadius,
    required TextDirection textDirection,
    required bool isRange,
    required double min,
    required double max,
    required double? value,
    required ShadRangeValue? rangeValue,
    required List<ShadThumbStateView> thumbs,
  }) {
    if (thumbs.isEmpty) return const <ShadSegment>[];
    final segments = <ShadSegment>[];
    const eps = 0.0001;

    BorderRadius? radiusFor(Rect rect) {
      switch (segmentRadius) {
        case ShadSegmentRadiusPolicy.fullPills:
          return BorderRadius.circular(trackRadius);
        case ShadSegmentRadiusPolicy.flatJoin:
          final touchesLeft = (rect.left - trackRect.left).abs() <= eps;
          final touchesRight = (rect.right - trackRect.right).abs() <= eps;
          return BorderRadius.only(
            topLeft: Radius.circular(touchesLeft ? trackRadius : 0),
            bottomLeft: Radius.circular(touchesLeft ? trackRadius : 0),
            topRight: Radius.circular(touchesRight ? trackRadius : 0),
            bottomRight: Radius.circular(touchesRight ? trackRadius : 0),
          );
        case ShadSegmentRadiusPolicy.custom:
          return null;
      }
    }

    Rect rectFromX(double left, double right) {
      final l = left.clamp(trackRect.left, trackRect.right);
      final r = right.clamp(trackRect.left, trackRect.right);
      final x0 = l < r ? l : r;
      final x1 = l < r ? r : l;
      return Rect.fromLTWH(
        x0,
        trackRect.top,
        (x1 - x0).clamp(0.0, trackRect.width),
        trackRect.height,
      );
    }

    if (!isRange) {
      final cx = thumbs.first.center.dx.clamp(trackRect.left, trackRect.right);
      late final Rect fillRect;
      late final Rect remRect;
      if (textDirection == TextDirection.rtl) {
        fillRect = rectFromX(cx, trackRect.right);
        remRect = rectFromX(trackRect.left, cx);
      } else {
        fillRect = rectFromX(trackRect.left, cx);
        remRect = rectFromX(cx, trackRect.right);
      }

      if (fillRect.width > eps) {
        segments.add(
          ShadSegment(
            kind: ShadSegmentKind.fill,
            rect: fillRect,
            radius: radiusFor(fillRect),
            paintOrder: 1,
          ),
        );
      }
      if (remRect.width > eps) {
        segments.add(
          ShadSegment(
            kind: ShadSegmentKind.remaining,
            rect: remRect,
            radius: radiusFor(remRect),
            paintOrder: 3,
          ),
        );
      }
      return segments;
    }

    final cx0 = thumbs[0].center.dx;
    final cx1 = thumbs[1].center.dx;
    final left = math.min(cx0, cx1).clamp(trackRect.left, trackRect.right);
    final right = math.max(cx0, cx1).clamp(trackRect.left, trackRect.right);

    final leftRem = rectFromX(trackRect.left, left);
    final fillRect = rectFromX(left, right);
    final rightRem = rectFromX(right, trackRect.right);

    if (leftRem.width > eps) {
      segments.add(
        ShadSegment(
          kind: ShadSegmentKind.remaining,
          rect: leftRem,
          radius: radiusFor(leftRem),
          paintOrder: 0,
        ),
      );
    }
    if (fillRect.width > eps) {
      segments.add(
        ShadSegment(
          kind: ShadSegmentKind.fill,
          rect: fillRect,
          radius: radiusFor(fillRect),
          paintOrder: 2,
        ),
      );
    }
    if (rightRem.width > eps) {
      segments.add(
        ShadSegment(
          kind: ShadSegmentKind.remaining,
          rect: rightRem,
          radius: radiusFor(rightRem),
          paintOrder: 4,
        ),
      );
    }
    return segments;
  }
}

class ShadJoinGapLayout extends ShadSegmentLayout {
  const ShadJoinGapLayout({
    this.gapPx = 6,
    this.endsPolicy = ShadGapEndsPolicy.noneAtMinMax,
    this.segmentRadius = ShadSegmentRadiusPolicy.fullPills,
  });

  final double gapPx;
  final ShadGapEndsPolicy endsPolicy;
  final ShadSegmentRadiusPolicy segmentRadius;

  @override
  List<ShadSegment> buildSegments({
    required Rect trackRect,
    required double trackRadius,
    required TextDirection textDirection,
    required bool isRange,
    required double min,
    required double max,
    required double? value,
    required ShadRangeValue? rangeValue,
    required List<ShadThumbStateView> thumbs,
  }) {
    if (thumbs.isEmpty) return const <ShadSegment>[];
    const eps = 0.0001;
    final range = (max - min).abs() < eps ? 1.0 : (max - min);
    final segments = <ShadSegment>[];

    Rect rectFromX(double left, double right) {
      final l = left.clamp(trackRect.left, trackRect.right);
      final r = right.clamp(trackRect.left, trackRect.right);
      final x0 = l < r ? l : r;
      final x1 = l < r ? r : l;
      return Rect.fromLTWH(
        x0,
        trackRect.top,
        (x1 - x0).clamp(0.0, trackRect.width),
        trackRect.height,
      );
    }

    BorderRadius? radiusFor(Rect rect) {
      switch (segmentRadius) {
        case ShadSegmentRadiusPolicy.fullPills:
          return BorderRadius.circular(trackRadius);
        case ShadSegmentRadiusPolicy.flatJoin:
          final touchesLeft = (rect.left - trackRect.left).abs() <= eps;
          final touchesRight = (rect.right - trackRect.right).abs() <= eps;
          return BorderRadius.only(
            topLeft: Radius.circular(touchesLeft ? trackRadius : 0),
            bottomLeft: Radius.circular(touchesLeft ? trackRadius : 0),
            topRight: Radius.circular(touchesRight ? trackRadius : 0),
            bottomRight: Radius.circular(touchesRight ? trackRadius : 0),
          );
        case ShadSegmentRadiusPolicy.custom:
          return null;
      }
    }

    double effectiveGap(bool atEdge) {
      switch (endsPolicy) {
        case ShadGapEndsPolicy.always:
          return gapPx;
        case ShadGapEndsPolicy.noneAlways:
          return 0.0;
        case ShadGapEndsPolicy.noneAtMinMax:
          return atEdge ? 0.0 : gapPx;
      }
    }

    if (!isRange) {
      final v = value ?? min;
      final t = ((v - min) / range).clamp(0.0, 1.0);
      final atMin = t <= eps;
      final atMax = t >= 1.0 - eps;
      final cx = thumbs.first.center.dx.clamp(trackRect.left, trackRect.right);
      final gap = effectiveGap(atMin || atMax);
      final gapHalf = gap / 2;
      final gapL = (cx - gapHalf).clamp(trackRect.left, trackRect.right);
      final gapR = (cx + gapHalf).clamp(trackRect.left, trackRect.right);

      late final Rect fillRect;
      late final Rect remRect;
      if (textDirection == TextDirection.rtl) {
        fillRect = rectFromX(gapR, trackRect.right);
        remRect = rectFromX(trackRect.left, gapL);
      } else {
        fillRect = rectFromX(trackRect.left, gapL);
        remRect = rectFromX(gapR, trackRect.right);
      }
      final gapRect = rectFromX(gapL, gapR);

      if (fillRect.width > eps) {
        segments.add(
          ShadSegment(
            kind: ShadSegmentKind.fill,
            rect: fillRect,
            radius: radiusFor(fillRect),
            paintOrder: 1,
          ),
        );
      }
      if (gapRect.width > eps) {
        segments.add(
          ShadSegment(
            kind: ShadSegmentKind.gap,
            rect: gapRect,
            radius: radiusFor(gapRect),
            paintOrder: 2,
          ),
        );
      }
      if (remRect.width > eps) {
        segments.add(
          ShadSegment(
            kind: ShadSegmentKind.remaining,
            rect: remRect,
            radius: radiusFor(remRect),
            paintOrder: 3,
          ),
        );
      }
      return segments;
    }

    final rv = rangeValue ?? ShadRangeValue(min, max);
    final startT = ((rv.start - min) / range).clamp(0.0, 1.0);
    final endT = ((rv.end - min) / range).clamp(0.0, 1.0);
    final leftAtMin = startT <= eps;
    final rightAtMax = endT >= 1.0 - eps;
    final cx0 = thumbs[0].center.dx;
    final cx1 = thumbs[1].center.dx;
    final leftCx = math.min(cx0, cx1).clamp(trackRect.left, trackRect.right);
    final rightCx = math.max(cx0, cx1).clamp(trackRect.left, trackRect.right);

    final gapLeft = effectiveGap(leftAtMin);
    final gapRight = effectiveGap(rightAtMax);
    final g0L = (leftCx - gapLeft / 2).clamp(trackRect.left, trackRect.right);
    final g0R = (leftCx + gapLeft / 2).clamp(trackRect.left, trackRect.right);
    final g1L = (rightCx - gapRight / 2).clamp(trackRect.left, trackRect.right);
    final g1R = (rightCx + gapRight / 2).clamp(trackRect.left, trackRect.right);

    final leftRem = rectFromX(trackRect.left, g0L);
    final leftGap = rectFromX(g0L, g0R);
    final fillRect = rectFromX(g0R, g1L);
    final rightGap = rectFromX(g1L, g1R);
    final rightRem = rectFromX(g1R, trackRect.right);

    if (leftRem.width > eps) {
      segments.add(
        ShadSegment(
          kind: ShadSegmentKind.remaining,
          rect: leftRem,
          radius: radiusFor(leftRem),
          paintOrder: 0,
        ),
      );
    }
    if (leftGap.width > eps) {
      segments.add(
        ShadSegment(
          kind: ShadSegmentKind.gap,
          rect: leftGap,
          radius: radiusFor(leftGap),
          paintOrder: 1,
        ),
      );
    }
    if (fillRect.width > eps) {
      segments.add(
        ShadSegment(
          kind: ShadSegmentKind.fill,
          rect: fillRect,
          radius: radiusFor(fillRect),
          paintOrder: 2,
        ),
      );
    }
    if (rightGap.width > eps) {
      segments.add(
        ShadSegment(
          kind: ShadSegmentKind.gap,
          rect: rightGap,
          radius: radiusFor(rightGap),
          paintOrder: 3,
        ),
      );
    }
    if (rightRem.width > eps) {
      segments.add(
        ShadSegment(
          kind: ShadSegmentKind.remaining,
          rect: rightRem,
          radius: radiusFor(rightRem),
          paintOrder: 4,
        ),
      );
    }
    return segments;
  }
}

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
    required this.segments,
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

  /// Canonical segment model for rendering.
  final List<ShadSegment> segments;

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
