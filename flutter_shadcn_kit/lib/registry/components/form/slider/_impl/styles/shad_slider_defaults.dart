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

  static ShadSliderDefaults of(BuildContext context) {
    final theme = Theme.of(context);

    return ShadSliderDefaults(
      trackBuilder: (context, s) {
        final r = BorderRadius.circular(s.trackRadius);
        final surface = theme.colorScheme.surfaceContainerHighest.withOpacity(
          s.enabled ? 0.55 : 0.35,
        );

        return Container(
          width: s.trackRect.width,
          height: s.trackRect.height,
          decoration: BoxDecoration(
            color: surface,
            borderRadius: r,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 6),
                color: Colors.black.withOpacity(0.08),
              ),
              BoxShadow(
                blurRadius: 1,
                offset: const Offset(0, 1),
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: r,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.45),
                    Colors.white.withOpacity(0.00),
                    Colors.black.withOpacity(0.03),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      fillBuilder: (context, s) {
        final active = theme.colorScheme.primary.withOpacity(
          s.enabled ? 0.95 : 0.35,
        );

        if (!s.isRange) {
          final rect = s.activeRect ?? Rect.zero;
          final atMax = ((s.value ?? s.min) - s.max).abs() < 1e-9;

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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      active.withOpacity(0.96),
                      active.withOpacity(0.90),
                    ],
                  ),
                ),
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
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      active.withOpacity(0.55),
                      active.withOpacity(0.95),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      thumbBuilder: (context, t) {
        final h = t.size.height;
        final barH = math.max(0.0, h - 12);
        const w = 6.0;
        return IgnorePointer(
          ignoring: true,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            width: w,
            height: barH,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(t.enabled ? 1 : 0.6),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  blurRadius: t.active ? 14 : 10,
                  offset: const Offset(0, 6),
                  color: Colors.black.withOpacity(0.14),
                ),
              ],
            ),
          ),
        );
      },
      ticksBuilder: (context, s) => const SizedBox.shrink(),
      overlayBuilder: (context, s) => const SizedBox.shrink(),
    );
  }

  static Widget circleThumb(BuildContext context, ShadThumbStateView t) {
    final c = Theme.of(context).colorScheme.primary;
    return IgnorePointer(
      ignoring: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: c, width: 3),
          boxShadow: [
            BoxShadow(
              blurRadius: t.active ? 18 : 14,
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.16),
            ),
          ],
        ),
      ),
    );
  }

  static Widget squareThumb(BuildContext context, ShadThumbStateView t) {
    final c = Theme.of(context).colorScheme.primary;
    return IgnorePointer(
      ignoring: true,
      child: Container(
        width: 18,
        height: 26,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: c, width: 2),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.14),
            ),
          ],
        ),
      ),
    );
  }

  static Widget pinThumb(BuildContext context, ShadThumbStateView t) {
    final c = Theme.of(context).colorScheme.primary;
    return IgnorePointer(
      ignoring: true,
      child: SizedBox(
        width: 22,
        height: 34,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 10,
              child: Container(
                width: 3,
                height: 22,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                      color: Colors.black.withOpacity(0.10),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                    color: Colors.black.withOpacity(0.14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget dotsTicks(BuildContext context, ShadSliderStateView s) {
    final activeT = s.t ?? 0;
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(
      context,
    ).colorScheme.onSurface.withOpacity(0.18);
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
                  color: (m.t <= activeT) ? activeColor : inactiveColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Widget subtleBarsTicks(BuildContext context, ShadSliderStateView s) {
    final w = s.trackRect.width;
    final h = s.trackRect.height;
    const bars = 48;
    final barW = w / bars;
    final maxBarH = h * 0.75;
    final activeT = s.t ?? 0;
    final activeX = w * activeT;
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(
      context,
    ).colorScheme.onSurface.withOpacity(0.16);

    return IgnorePointer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(s.trackRadius),
        child: Stack(
          children: [
            for (int i = 0; i < bars; i++)
              Positioned(
                left: i * barW,
                top: (h - (maxBarH * (0.25 + 0.75 * (i % 9) / 9))) / 2,
                child: Container(
                  width: math.max(1, barW * 0.55),
                  height: maxBarH * (0.25 + 0.75 * (i % 9) / 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: ((i * barW) <= activeX)
                        ? activeColor
                        : inactiveColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
