import 'dart:math' as math;

import 'package:flutter/material.dart';

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

        final bg = cs.surfaceContainerHighest.withOpacity(
          s.enabled ? 0.55 : 0.35,
        );
        final border = cs.onSurface.withOpacity(s.enabled ? 0.08 : 0.06);

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

        if (!s.isRange) {
          final rect = s.activeRect ?? Rect.zero;
          final atMax = ((s.value ?? s.min) - s.max).abs() < 1e-9;

          // Flat trailing edge unless max.
          final br = BorderRadius.only(
            topLeft: Radius.circular(s.trackRadius),
            bottomLeft: Radius.circular(s.trackRadius),
            topRight: Radius.circular(atMax ? s.trackRadius : 0),
            bottomRight: Radius.circular(atMax ? s.trackRadius : 0),
          );

          return ClipRRect(
            borderRadius: br,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: rect.width,
                height: s.trackRect.height,
                color: active,
              ),
            ),
          );
        } else {
          final rect = s.rangeRect ?? Rect.zero;
          final touchesMin = ((s.rangeValue!.start - s.min).abs() < 1e-9);
          final touchesMax = ((s.rangeValue!.end - s.max).abs() < 1e-9);

          final br = BorderRadius.only(
            topLeft: Radius.circular(touchesMin ? s.trackRadius : 0),
            bottomLeft: Radius.circular(touchesMin ? s.trackRadius : 0),
            topRight: Radius.circular(touchesMax ? s.trackRadius : 0),
            bottomRight: Radius.circular(touchesMax ? s.trackRadius : 0),
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

        return IgnorePointer(
          ignoring: true,
          child: Container(
            width: w,
            height: barH,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(t.enabled ? 1 : 0.6),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withOpacity(0.10),
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

  static Widget circleThumb(BuildContext context, ShadThumbStateView t) {
    final cs = Theme.of(context).colorScheme;
    final border = cs.onSurface.withOpacity(0.14);
    final ring = cs.primary.withOpacity(t.enabled ? 0.95 : 0.45);

    return IgnorePointer(
      ignoring: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cs.surface,
          border: Border.all(color: border, width: 1),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: ring),
          ),
        ),
      ),
    );
  }

  static Widget squareThumb(BuildContext context, ShadThumbStateView t) {
    final cs = Theme.of(context).colorScheme;
    final border = cs.onSurface.withOpacity(0.14);
    return IgnorePointer(
      ignoring: true,
      child: Container(
        width: 18,
        height: 24,
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: border, width: 1),
        ),
      ),
    );
  }

  static Widget pinThumb(BuildContext context, ShadThumbStateView t) {
    final cs = Theme.of(context).colorScheme;
    final border = cs.onSurface.withOpacity(0.14);
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
                color: cs.surface,
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

  static Widget dotsTicks(BuildContext context, ShadSliderStateView s) {
    final cs = Theme.of(context).colorScheme;
    final activeT = s.t ?? 0;
    final active = cs.primary.withOpacity(0.95);
    final inactive = cs.onSurface.withOpacity(0.18);

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

  static Widget subtleBarsTicks(BuildContext context, ShadSliderStateView s) {
    final cs = Theme.of(context).colorScheme;
    final w = s.trackRect.width;
    final h = s.trackRect.height;
    const bars = 56;
    final barW = w / bars;
    final maxBarH = h * 0.75;

    final activeT = s.t ?? 0;
    final activeX = w * activeT;

    final active = cs.primary.withOpacity(0.95);
    final inactive = cs.onSurface.withOpacity(0.18);

    return IgnorePointer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(s.trackRadius),
        child: Stack(
          children: [
            for (int i = 0; i < bars; i++)
              Positioned(
                left: i * barW,
                top: (h - (maxBarH * (0.30 + 0.70 * ((i % 13) / 13)))) / 2,
                child: Container(
                  width: math.max(1, barW * 0.55),
                  height: maxBarH * (0.30 + 0.70 * ((i % 13) / 13)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: ((i * barW) <= activeX) ? active : inactive,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
