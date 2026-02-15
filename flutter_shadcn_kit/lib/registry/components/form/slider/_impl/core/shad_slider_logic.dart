import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'shad_slider_models.dart';

class ShadSliderLogic {
  ShadSliderStateView buildView({
    required double min,
    required double max,
    required ShadSliderSnap snap,
    required bool enabled,
    required Rect trackRect,
    required double trackRadius,
    required double thumbInset,
    required bool dragging,
    required int? activeThumb,
    required bool fillStopsAtThumbCenter,
    required double fillEdgeBiasPx,
    required TextDirection textDirection,
    required double? value,
    required ShadSliderRangeValue? rangeValue,
  }) {
    final isRange = rangeValue != null;
    final usableWidth = math.max(0.0, trackRect.width - (thumbInset * 2));

    double xForT(double t) {
      final local = thumbInset + (t * usableWidth);
      return textDirection == TextDirection.rtl
          ? trackRect.right - local
          : trackRect.left + local;
    }

    double tForValue(double v) {
      final span = max - min;
      if (span == 0) return 0;
      return ((v - min) / span).clamp(0.0, 1.0);
    }

    final thumbSize = Size(22, trackRect.height);
    final marks = _buildMarks(
      min: min,
      max: max,
      snap: snap,
      trackRect: trackRect,
      thumbInset: thumbInset,
      textDirection: textDirection,
    );

    if (!isRange) {
      final clamped = (value ?? min).clamp(min, max);
      final snapped = _applySnap(clamped, snap, min, max);
      final t = tForValue(snapped);
      final thumbX = xForT(t);

      final fillEnd = fillStopsAtThumbCenter
          ? thumbX - fillEdgeBiasPx
          : thumbX - (thumbSize.width / 2) - fillEdgeBiasPx;

      return ShadSliderStateView(
        min: min,
        max: max,
        enabled: enabled,
        dragging: dragging,
        activeThumb: activeThumb,
        textDirection: textDirection,
        trackRect: trackRect,
        trackRadius: trackRadius,
        thumbInset: thumbInset,
        isRange: false,
        value: snapped,
        rangeValue: null,
        t: t,
        tStart: null,
        tEnd: null,
        activeRect: _rectFromLeftToX(trackRect, fillEnd),
        rangeRect: null,
        thumbs: [
          ShadSliderThumbStateView(
            index: 0,
            value: snapped,
            t: t,
            center: Offset(thumbX, trackRect.center.dy),
            size: thumbSize,
            active: dragging && (activeThumb ?? 0) == 0,
            enabled: enabled,
          ),
        ],
        marks: marks,
      );
    }

    final normalized = _normalizeRange(rangeValue, min, max);
    final startSnapped = _applySnap(normalized.start, snap, min, max);
    final endSnapped = _applySnap(normalized.end, snap, min, max);
    final finalRange = _normalizeRange(
      normalized.copyWith(start: startSnapped, end: endSnapped),
      min,
      max,
    );

    final tStart = tForValue(finalRange.start);
    final tEnd = tForValue(finalRange.end);
    final xStart = xForT(tStart);
    final xEnd = xForT(tEnd);

    final leftEdge = fillStopsAtThumbCenter
        ? xStart + fillEdgeBiasPx
        : xStart + (thumbSize.width / 2) + fillEdgeBiasPx;
    final rightEdge = fillStopsAtThumbCenter
        ? xEnd - fillEdgeBiasPx
        : xEnd - (thumbSize.width / 2) - fillEdgeBiasPx;

    return ShadSliderStateView(
      min: min,
      max: max,
      enabled: enabled,
      dragging: dragging,
      activeThumb: activeThumb,
      textDirection: textDirection,
      trackRect: trackRect,
      trackRadius: trackRadius,
      thumbInset: thumbInset,
      isRange: true,
      value: null,
      rangeValue: finalRange,
      t: null,
      tStart: tStart,
      tEnd: tEnd,
      activeRect: null,
      rangeRect: _rectBetweenX(trackRect, leftEdge, rightEdge),
      thumbs: [
        ShadSliderThumbStateView(
          index: 0,
          value: finalRange.start,
          t: tStart,
          center: Offset(xStart, trackRect.center.dy),
          size: thumbSize,
          active: dragging && activeThumb == 0,
          enabled: enabled,
        ),
        ShadSliderThumbStateView(
          index: 1,
          value: finalRange.end,
          t: tEnd,
          center: Offset(xEnd, trackRect.center.dy),
          size: thumbSize,
          active: dragging && activeThumb == 1,
          enabled: enabled,
        ),
      ],
      marks: marks,
    );
  }

  ShadSliderHitResult hitTest({
    required ShadSliderStateView view,
    required Offset localPosition,
  }) {
    if (!view.isRange) return const ShadSliderHitResult(activeThumb: 0);
    return ShadSliderHitResult(
      activeThumb: pickActiveThumb(view: view, dx: localPosition.dx),
    );
  }

  int pickActiveThumb({required ShadSliderStateView view, required double dx}) {
    if (!view.isRange) return 0;
    final dStart = (dx - view.thumbs[0].center.dx).abs();
    final dEnd = (dx - view.thumbs[1].center.dx).abs();
    if (dStart < dEnd) return 0;
    if (dEnd < dStart) return 1;

    final start = view.rangeValue!.start;
    final end = view.rangeValue!.end;
    final value = _valueFromDx(dx, view);
    final canMoveStart = value <= end;
    final canMoveEnd = value >= start;
    if (canMoveStart && !canMoveEnd) return 0;
    if (canMoveEnd && !canMoveStart) return 1;
    return 0;
  }

  ShadSliderUpdateResult updateFromDx({
    required ShadSliderStateView view,
    required double dx,
    required int thumbIndex,
    required ShadSliderSnap snap,
  }) {
    final min = view.min;
    final max = view.max;
    final raw = _valueFromDx(dx, view);
    final snapped = _applySnap(raw, snap, min, max);

    if (!view.isRange) {
      return ShadSliderUpdateResult(singleValue: snapped, activeThumb: 0);
    }

    final current = view.rangeValue!;
    double start = current.start;
    double end = current.end;
    var active = thumbIndex;

    if (thumbIndex == 0) {
      start = snapped;
      if (!current.allowSwap) {
        start = math.min(start, end - current.minRange);
      } else if (start > end) {
        final swap = start;
        start = end;
        end = swap;
        active = 1;
      }
    } else {
      end = snapped;
      if (!current.allowSwap) {
        end = math.max(end, start + current.minRange);
      } else if (end < start) {
        final swap = end;
        end = start;
        start = swap;
        active = 0;
      }
    }

    final out = _normalizeRange(
      ShadSliderRangeValue(
        start,
        end,
        minRange: current.minRange,
        allowSwap: current.allowSwap,
      ),
      min,
      max,
    );

    return ShadSliderUpdateResult(rangeValue: out, activeThumb: active);
  }

  double _valueFromDx(double dx, ShadSliderStateView view) {
    final width = view.trackRect.width;
    final usableWidth = math.max(0.0, width - (view.thumbInset * 2));
    if (usableWidth == 0) return view.min;

    final local = view.textDirection == TextDirection.rtl
        ? view.trackRect.right - dx
        : dx - view.trackRect.left;

    final t = ((local - view.thumbInset) / usableWidth).clamp(0.0, 1.0);
    return view.min + (view.max - view.min) * t;
  }

  ShadSliderRangeValue _normalizeRange(
    ShadSliderRangeValue value,
    double min,
    double max,
  ) {
    var start = value.start.clamp(min, max);
    var end = value.end.clamp(min, max);

    if (!value.allowSwap) {
      if (start > end) {
        final tmp = start;
        start = end;
        end = tmp;
      }

      end = math.max(end, start + value.minRange).clamp(min, max);
      start = math.min(start, end - value.minRange).clamp(min, max);
    }

    return value.copyWith(start: start, end: end);
  }

  double _applySnap(double value, ShadSliderSnap snap, double min, double max) {
    if (snap is ShadSliderSnapNone) return value.clamp(min, max);

    if (snap is ShadSliderSnapSteps) {
      final t = ((value - min) / (max - min)).clamp(0.0, 1.0);
      final quantized = (t * snap.steps).round() / snap.steps;
      return (min + (max - min) * quantized).clamp(min, max);
    }

    if (snap is ShadSliderSnapValues) {
      var best = snap.values.first;
      var bestDiff = (value - best).abs();
      for (final candidate in snap.values.skip(1)) {
        final diff = (value - candidate).abs();
        if (diff < bestDiff) {
          best = candidate;
          bestDiff = diff;
        }
      }
      return best.clamp(min, max);
    }

    return value.clamp(min, max);
  }

  Rect _rectFromLeftToX(Rect trackRect, double rightX) {
    final width = (rightX - trackRect.left).clamp(0.0, trackRect.width);
    return Rect.fromLTWH(
      trackRect.left,
      trackRect.top,
      width,
      trackRect.height,
    );
  }

  Rect _rectBetweenX(Rect trackRect, double a, double b) {
    final left = math.min(a, b).clamp(trackRect.left, trackRect.right);
    final right = math.max(a, b).clamp(trackRect.left, trackRect.right);
    return Rect.fromLTWH(left, trackRect.top, right - left, trackRect.height);
  }

  List<ShadSliderMarkLayout> _buildMarks({
    required double min,
    required double max,
    required ShadSliderSnap snap,
    required Rect trackRect,
    required double thumbInset,
    required TextDirection textDirection,
  }) {
    final usableWidth = math.max(0.0, trackRect.width - (thumbInset * 2));

    double xForT(double t) {
      final local = thumbInset + (t * usableWidth);
      return textDirection == TextDirection.rtl
          ? trackRect.right - local
          : trackRect.left + local;
    }

    if (snap is ShadSliderSnapSteps) {
      return List.generate(snap.steps + 1, (index) {
        final t = index / snap.steps;
        final value = min + ((max - min) * t);
        return ShadSliderMarkLayout(value: value, t: t, x: xForT(t));
      });
    }

    if (snap is ShadSliderSnapValues) {
      final marks = snap.values.map((value) {
        final t = ((value - min) / (max - min)).clamp(0.0, 1.0);
        return ShadSliderMarkLayout(value: value, t: t, x: xForT(t));
      }).toList();
      marks.sort((a, b) => a.t.compareTo(b.t));
      return marks;
    }

    return const [];
  }
}
