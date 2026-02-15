import 'dart:math' as math;
import 'package:flutter/material.dart' hide Theme;

import '../../../../../shared/theme/theme.dart';

import '../core/shad_slider_models.dart';

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

  /// Clean, flat modern defaults (Stripe/Linear-ish).
  static ShadSliderDefaults of(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ShadSliderDefaults(
      trackBuilder: (context, s) {
        final r = BorderRadius.circular(s.trackRadius);

        // Flatter + lighter track like Linear/Stripe
        final bg = cs.background.withOpacity(s.enabled ? 0.92 : 0.80);
        final border = cs.foreground.withOpacity(s.enabled ? 0.06 : 0.05);

        return ClipRRect(
          borderRadius: r,
          child: Container(
            width: s.trackRect.width,
            height: s.trackRect.height,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: r,
              border: Border.all(color: border, width: 1),
            ),
          ),
        );
      },
      fillBuilder: (context, s) {
        final cs = Theme.of(context).colorScheme;
        final active = cs.primary.withOpacity(s.enabled ? 0.92 : 0.35);

        // Epsilon avoids 99.999% not being treated as max.
        bool near(double a, double b) => (a - b).abs() < 0.0001;

        if (!s.isRange) {
          final rect = s.activeRect ?? Rect.zero;
          final v = s.value ?? s.min;
          final atMin = near(v, s.min);
          final atMax = near(v, s.max);

          // Keep a flatter cap while dragging, but preserve full radius at max.
          final trailing = atMax
              ? s.trackRadius
              : (s.trackRadius * 0.45).clamp(2.0, s.trackRadius).toDouble();

          final fillRadius = BorderRadius.only(
            topLeft: Radius.circular(s.trackRadius),
            bottomLeft: Radius.circular(s.trackRadius),
            topRight: Radius.circular(trailing),
            bottomRight: Radius.circular(trailing),
          );

          // If at min, width might be ~0; keep it 0.
          final w = atMin ? 0.0 : rect.width;

          return Align(
            alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: fillRadius,
              child: Container(
                width: w,
                height: s.trackRect.height,
                color: active,
              ),
            ),
          );
        } else {
          final rect = s.rangeRect ?? Rect.zero;

          bool near(double a, double b) => (a - b).abs() < 0.0001;
          final touchesMin = near(s.rangeValue!.start, s.min);
          final touchesMax = near(s.rangeValue!.end, s.max);

          // Flatter middle-range caps; full radius only when touching edges.
          final endR = (s.trackRadius * 0.45)
              .clamp(2.0, s.trackRadius)
              .toDouble();

          final br = BorderRadius.only(
            topLeft: Radius.circular(touchesMin ? s.trackRadius : endR),
            bottomLeft: Radius.circular(touchesMin ? s.trackRadius : endR),
            topRight: Radius.circular(touchesMax ? s.trackRadius : endR),
            bottomRight: Radius.circular(touchesMax ? s.trackRadius : endR),
          );

          return Positioned.fromRect(
            rect: rect,
            child: ClipRRect(
              borderRadius: br,
              child: Container(color: active),
            ),
          );
        }
      },
      thumbBuilder: (context, t) {
        // Default thumb: thin vertical bar (brightness).
        final h = t.size.height;
        final barH = math.max(0.0, h - 12);
        const w = 6.0;

        final cs = Theme.of(context).colorScheme;

        return IgnorePointer(
          ignoring: true,
          child: Container(
            width: w,
            height: barH,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: cs.background.withOpacity(t.enabled ? 1 : 0.7),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: cs.foreground.withOpacity(0.10),
                width: 1,
              ),
            ),
          ),
        );
      },
      ticksBuilder: (context, s) => const SizedBox.shrink(),
      overlayBuilder: (context, s) => const SizedBox.shrink(),
    );
  }

  // ---- Convenience builders for presets ----

  /// Clean "ring" thumb: subtle border + small inner dot.
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
    final cs = Theme.of(context).colorScheme;
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
                borderRadius: BorderRadius.circular(6),
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
