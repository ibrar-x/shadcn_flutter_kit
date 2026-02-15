import 'dart:math' as math;
import 'package:flutter/material.dart' hide Theme;

import '../../../../../shared/theme/theme.dart';

import '../core/shad_slider_models.dart';

/// Default builders used by slider presets.
class ShadSliderDefaults {
  ShadSliderDefaults({
    required this.trackBuilder,
    required this.fillBuilder,
    required this.thumbBuilder,
    required this.ticksBuilder,
    required this.overlayBuilder,
  });

  final ShadTrackBuilder trackBuilder;
  final ShadFillBuilder fillBuilder;
  final ShadThumbBuilder thumbBuilder;
  final ShadTicksBuilder ticksBuilder;
  final ShadOverlayBuilder overlayBuilder;

  /// Resolves default builders from current app theme tokens.
  ///
  /// Defaults are intentionally low-contrast and token-driven.
  static ShadSliderDefaults of(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ShadSliderDefaults(
      trackBuilder: (context, s) {
        final theme = Theme.of(context);
        final guideHeight = (theme.density.baseGap * theme.scaling * 0.25)
            .clamp(1.0, 3.0)
            .toDouble();
        return Positioned.fromRect(
          rect: s.trackRect,
          child: SizedBox(
            width: s.trackRect.width,
            height: s.trackRect.height,
            child: Center(
              child: Container(
                height: guideHeight,
                width: s.trackRect.width,
                decoration: BoxDecoration(
                  color: cs.foreground.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        );
      },
      fillBuilder: (context, s) {
        final cs = Theme.of(context).colorScheme;
        final fillColor = cs.primary.withOpacity(s.enabled ? 0.92 : 0.35);
        final remColor = cs.muted.withOpacity(0.78);
        final capRadius = math.min(s.trackRadius, s.trackRect.height / 2);

        if (!s.isRange) {
          final fill = s.activeRect ?? Rect.zero;
          final rem = s.remainingRect ?? Rect.zero;
          final r = capRadius;

          return Stack(
            children: [
              if (fill.width > 0.5)
                Positioned.fromRect(
                  rect: fill,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(r),
                    child: Container(color: fillColor),
                  ),
                ),

              if (rem.width > 0.5)
                Positioned.fromRect(
                  rect: rem,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(r),
                    child: Container(color: remColor),
                  ),
                ),
            ],
          );
        } else {
          final sel = s.rangeRect ?? Rect.zero;
          final leftRem = s.leftRemainingRect ?? Rect.zero;
          final rightRem = s.rightRemainingRect ?? Rect.zero;
          final r = capRadius;

          return Stack(
            children: [
              if (leftRem.width > 0.5)
                Positioned.fromRect(
                  rect: leftRem,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(r),
                    child: Container(color: remColor),
                  ),
                ),
              if (rightRem.width > 0.5)
                Positioned.fromRect(
                  rect: rightRem,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(r),
                    child: Container(color: remColor),
                  ),
                ),
              if (sel.width > 0.5)
                Positioned.fromRect(
                  rect: sel,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(r),
                    child: Container(color: fillColor),
                  ),
                ),
            ],
          );
        }
      },
      thumbBuilder: barThumb(),
      ticksBuilder: (context, s) => const SizedBox.shrink(),
      overlayBuilder: (context, s) => const SizedBox.shrink(),
    );
  }

  /// Default bar thumb builder with optional radius override.
  ///
  /// The returned builder respects [ShadThumbStateView.size] for layout.
  static ShadThumbBuilder barThumb({double? radius}) {
    return (context, t) {
      final theme = Theme.of(context);
      final baseGap = theme.density.baseGap * theme.scaling;
      final barH = (t.size.height - baseGap * 0.25).clamp(2.0, 200.0);
      final w = (t.size.width - baseGap * 0.25).clamp(2.0, 400.0);
      final barRadius =
          radius ?? (math.min(w, barH) / 2).clamp(1.0, 999.0).toDouble();
      final cs = theme.colorScheme;

      return IgnorePointer(
        ignoring: true,
        child: SizedBox(
          width: t.size.width,
          height: t.size.height,
          child: Center(
            child: Container(
              width: w,
              height: barH,
              decoration: BoxDecoration(
                color: cs.background.withOpacity(t.enabled ? 1 : 0.7),
                borderRadius: BorderRadius.circular(barRadius),
                border: Border.all(
                  color: cs.foreground.withOpacity(0.10),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      );
    };
  }

  // ---- Convenience builders for presets ----

  /// Ring thumb with subtle border and small center dot.
  static Widget circleThumb(BuildContext context, ShadThumbStateView t) {
    final cs = Theme.of(context).colorScheme;
    final border = cs.foreground.withOpacity(0.18);
    final ring = cs.primary.withOpacity(t.enabled ? 0.95 : 0.45);
    final d = t.size.width;

    return IgnorePointer(
      ignoring: true,
      child: SizedBox(
        width: t.size.width,
        height: t.size.height,
        child: Center(
          child: SizedBox(
            width: d,
            height: d,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: border, width: 1),
              ),
              child: Center(
                child: Container(
                  width: d * 0.30,
                  height: d * 0.30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ring,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget squareThumb(BuildContext context, ShadThumbStateView t) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final border = cs.foreground.withOpacity(0.12);
    final w = t.size.width;
    final h = t.size.height * 0.85;

    return IgnorePointer(
      ignoring: true,
      child: SizedBox(
        width: t.size.width,
        height: t.size.height,
        child: Center(
          child: SizedBox(
            width: w,
            height: h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: cs.background,
                borderRadius: BorderRadius.circular(theme.radiusSm),
                border: Border.all(color: border, width: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget pinThumb(BuildContext context, ShadThumbStateView t) {
    final cs = Theme.of(context).colorScheme;
    final border = cs.foreground.withOpacity(0.12);
    final dot = cs.primary.withOpacity(t.enabled ? 0.95 : 0.45);

    return IgnorePointer(
      ignoring: true,
      child: SizedBox(
        width: 22,
        height: 30,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 10,
              child: Container(
                width: 2,
                height: 18,
                decoration: BoxDecoration(
                  color: border,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: cs.background,
                shape: BoxShape.circle,
                border: Border.all(color: border, width: 1),
              ),
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Softer dots (Stripe/Linear low-contrast).
  static Widget dotsTicks(BuildContext context, ShadSliderStateView s) {
    final cs = Theme.of(context).colorScheme;
    final activeT = s.t ?? 0;
    final active = cs.foreground.withOpacity(0.18);
    final inactive = cs.foreground.withOpacity(0.08);

    return IgnorePointer(
      child: Stack(
        children: [
          for (final m in s.marks)
            Positioned(
              left: m.x - 3,
              top: s.trackRect.center.dy - 3,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (m.t <= activeT) ? active : inactive,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Smooth, natural waveform-like bars (no patterned modulo).
  static Widget subtleBarsTicks(BuildContext context, ShadSliderStateView s) {
    final cs = Theme.of(context).colorScheme;
    final w = s.trackRect.width;
    final h = s.trackRect.height;

    const bars = 64;
    final barW = w / bars;
    final maxBarH = h * 0.75;

    final activeT = s.t ?? 0;
    final activeX = w * activeT;

    final active = cs.primary.withOpacity(0.95);
    final inactive = cs.foreground.withOpacity(0.12);

    return IgnorePointer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(s.trackRadius),
        child: Stack(
          children: [
            for (int i = 0; i < bars; i++)
              Positioned(
                left: i * barW,
                top: () {
                  final t = i / (bars - 1);
                  final amp =
                      (math.sin(t * math.pi) * 0.85 + 0.15); // 0.15..1.0
                  final bh = maxBarH * amp;
                  return (h - bh) / 2;
                }(),
                child: Builder(
                  builder: (_) {
                    final t = i / (bars - 1);
                    final amp = (math.sin(t * math.pi) * 0.85 + 0.15);
                    final bh = maxBarH * amp;

                    return Container(
                      width: math.max(1, barW * 0.55),
                      height: bh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: ((i * barW) <= activeX) ? active : inactive,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
