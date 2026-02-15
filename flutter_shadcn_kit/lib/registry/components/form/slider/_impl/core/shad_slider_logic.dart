import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'shad_slider_models.dart';

class ShadSliderLogic {
  ShadSliderStateView buildView({
    required double min,
    required double max,
    required ShadSnap snap,
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
    required ShadRangeValue? rangeValue,
    required Size thumbSize,
  }) {
    final isRange = rangeValue != null;
    final usableW = math.max(0.0, trackRect.width - thumbInset * 2);

    double dxForT(double t) {
      final x = thumbInset + usableW * t;
      return textDirection == TextDirection.rtl ? (trackRect.width - x) : x;
    }

    double tForValue(double v) {
      final range = max - min;
      if (range == 0) return 0;
      return ((v - min) / range).clamp(0.0, 1.0);
    }

    Rect rectFromX(double rightX) {
      final w = (rightX - trackRect.left).clamp(0.0, trackRect.width);
      return Rect.fromLTWH(trackRect.left, trackRect.top, w, trackRect.height);
    }

    Rect rectBetweenX(double x0, double x1) {
      final l = math.min(x0, x1).clamp(0.0, trackRect.width);
      final r = math.max(x0, x1).clamp(0.0, trackRect.width);
      return Rect.fromLTWH(
        l,
        trackRect.top,
        (r - l).clamp(0.0, trackRect.width),
        trackRect.height,
      );
    }

    List<ShadThumbStateView> thumbs = [];
    Rect? activeRect;
    Rect? rangeRect;
    double? tSingle;
    double? t0;
    double? t1;
    double? vSingle = value?.clamp(min, max);

    ShadRangeValue? rv = rangeValue;

    if (!isRange) {
      final v = vSingle ?? min;
      final t = tForValue(v);
      tSingle = t;

      final cx = dxForT(t);
      final center = Offset(cx, trackRect.center.dy);

      thumbs = [
        ShadThumbStateView(
          index: 0,
          value: v,
          t: t,
          center: center,
          size: thumbSize,
          active: (activeThumb ?? 0) == 0 && dragging,
          enabled: enabled,
        ),
      ];

      final edge = fillStopsAtThumbCenter
          ? (cx - fillEdgeBiasPx)
          : (cx - thumbSize.width / 2 - fillEdgeBiasPx);
      activeRect = rectFromX(edge);
    } else {
      rv = _normalizeRange(rv!, min, max);
      final tStart = tForValue(rv.start);
      final tEnd = tForValue(rv.end);
      t0 = tStart;
      t1 = tEnd;

      final cx0 = dxForT(tStart);
      final cx1 = dxForT(tEnd);

      thumbs = [
        ShadThumbStateView(
          index: 0,
          value: rv.start,
          t: tStart,
          center: Offset(cx0, trackRect.center.dy),
          size: thumbSize,
          active: activeThumb == 0 && dragging,
          enabled: enabled,
        ),
        ShadThumbStateView(
          index: 1,
          value: rv.end,
          t: tEnd,
          center: Offset(cx1, trackRect.center.dy),
          size: thumbSize,
          active: activeThumb == 1 && dragging,
          enabled: enabled,
        ),
      ];

      final leftEdge = fillStopsAtThumbCenter
          ? (cx0 + fillEdgeBiasPx)
          : (cx0 + thumbSize.width / 2 + fillEdgeBiasPx);
      final rightEdge = fillStopsAtThumbCenter
          ? (cx1 - fillEdgeBiasPx)
          : (cx1 - thumbSize.width / 2 - fillEdgeBiasPx);

      rangeRect = rectBetweenX(leftEdge, rightEdge);
    }

    final marks = _defaultMarks(
      min: min,
      max: max,
      snap: snap,
      trackRect: trackRect,
      thumbInset: thumbInset,
      textDirection: textDirection,
    );

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
      isRange: isRange,
      value: vSingle,
      rangeValue: rv,
      t: tSingle,
      t0: t0,
      t1: t1,
      activeRect: activeRect,
      rangeRect: rangeRect,
      thumbs: thumbs,
      marks: marks,
    );
  }

  ShadHitResult hitTest({
    required ShadSliderStateView view,
    required Offset localPosition,
  }) {
    if (!view.isRange) return const ShadHitResult(activeThumb: 0);
    return ShadHitResult(
      activeThumb: pickActiveThumb(view: view, dx: localPosition.dx),
    );
  }

  int pickActiveThumb({required ShadSliderStateView view, required double dx}) {
    if (!view.isRange) return 0;
    final d0 = (dx - view.thumbs[0].center.dx).abs();
    final d1 = (dx - view.thumbs[1].center.dx).abs();
    return d0 <= d1 ? 0 : 1;
  }

  ShadUpdateResult updateFromDx({
    required ShadSliderStateView view,
    required ShadSnap snap,
    required double dx,
    required int thumbIndex,
  }) {
    final min = view.min;
    final max = view.max;

    final t = _dxToT(dx, view);
    final vRaw = _tToValue(t, min, max);
    final v = _applySnap(vRaw, snap, min, max);

    if (!view.isRange) return ShadUpdateResult(singleValue: v);

    final rv = view.rangeValue!;
    final start = rv.start;
    final end = rv.end;

    if (thumbIndex == 0) {
      double ns = v;
      double ne = end;
      if (!rv.allowSwap) {
        ns = math.min(ns, ne - rv.minRange);
      } else if (ns > ne) {
        ns = ne;
        ne = v;
      }
      return ShadUpdateResult(
        rangeValue: _normalizeRange(
          ShadRangeValue(
            ns,
            ne,
            minRange: rv.minRange,
            allowSwap: rv.allowSwap,
          ),
          min,
          max,
        ),
      );
    } else {
      double ns = start;
      double ne = v;
      if (!rv.allowSwap) {
        ne = math.max(ne, ns + rv.minRange);
      } else if (ne < ns) {
        ne = ns;
        ns = v;
      }
      return ShadUpdateResult(
        rangeValue: _normalizeRange(
          ShadRangeValue(
            ns,
            ne,
            minRange: rv.minRange,
            allowSwap: rv.allowSwap,
          ),
          min,
          max,
        ),
      );
    }
  }

  double _dxToT(double dx, ShadSliderStateView view) {
    final w = view.trackRect.width;
    final inset = view.thumbInset;
    final usableW = math.max(0.0, w - inset * 2);
    final x = view.textDirection == TextDirection.rtl ? (w - dx) : dx;
    if (usableW == 0) return 0;
    return ((x - inset) / usableW).clamp(0.0, 1.0);
  }

  double _tToValue(double t, double min, double max) => min + (max - min) * t;

  ShadRangeValue _normalizeRange(ShadRangeValue rv, double min, double max) {
    final s = rv.start.clamp(min, max);
    final e = rv.end.clamp(min, max);
    if (!rv.allowSwap) {
      final s2 = math.min(s, e);
      final e2 = math.max(e, s2 + rv.minRange).clamp(min, max);
      return rv.copyWith(start: s2, end: e2);
    }
    return rv.copyWith(start: s, end: e);
  }

  double _applySnap(double v, ShadSnap snap, double min, double max) {
    if (snap is ShadSnapNone) return v.clamp(min, max);
    if (snap is ShadSnapSteps) {
      final steps = snap.steps;
      if ((max - min).abs() < 1e-9) return min;
      final t = ((v - min) / (max - min)).clamp(0.0, 1.0);
      final qt = (t * steps).round() / steps;
      return (min + (max - min) * qt).clamp(min, max);
    }
    if (snap is ShadSnapValues) {
      double best = snap.values.first;
      double bd = (v - best).abs();
      for (final x in snap.values.skip(1)) {
        final d = (v - x).abs();
        if (d < bd) {
          bd = d;
          best = x;
        }
      }
      return best.clamp(min, max);
    }
    return v.clamp(min, max);
  }

  List<ShadMarkLayout> _defaultMarks({
    required double min,
    required double max,
    required ShadSnap snap,
    required Rect trackRect,
    required double thumbInset,
    required TextDirection textDirection,
  }) {
    final w = trackRect.width;
    final usableW = math.max(0.0, w - thumbInset * 2);

    double xForT(double t) {
      final x = thumbInset + usableW * t;
      return textDirection == TextDirection.rtl ? (w - x) : x;
    }

    if (snap is ShadSnapSteps) {
      final n = snap.steps;
      return List.generate(n + 1, (i) {
        final t = i / n;
        final v = min + (max - min) * t;
        return ShadMarkLayout(value: v, t: t, x: xForT(t));
      });
    }
    if (snap is ShadSnapValues) {
      final out = snap.values.map((v) {
        final t = ((v - min) / (max - min)).clamp(0.0, 1.0);
        return ShadMarkLayout(value: v, t: t, x: xForT(t));
      }).toList();
      out.sort((a, b) => a.t.compareTo(b.t));
      return out;
    }
    return const <ShadMarkLayout>[];
  }
}
