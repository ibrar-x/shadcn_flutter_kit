import 'dart:math' as math;

import 'package:flutter/material.dart' hide SliderTheme, Theme;

import '../../../../../shared/theme/theme.dart';
import '../themes/slider_theme.dart';
import 'shad_slider_models.dart';

abstract class ShadTrackRenderer {
  const ShadTrackRenderer();

  Widget build(BuildContext context, ShadSliderStateView view);
}

class ShadLegacyBuildersRenderer extends ShadTrackRenderer {
  const ShadLegacyBuildersRenderer({
    required this.trackBuilder,
    required this.fillBuilder,
    required this.ticksBuilder,
  });

  final ShadTrackBuilder trackBuilder;
  final ShadFillBuilder fillBuilder;
  final ShadTicksBuilder ticksBuilder;

  @override
  Widget build(BuildContext context, ShadSliderStateView view) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        trackBuilder(context, view),
        fillBuilder(context, view),
        ticksBuilder(context, view),
      ],
    );
  }
}

class ShadSegmentedCapsuleRenderer extends ShadTrackRenderer {
  const ShadSegmentedCapsuleRenderer({this.styleResolver});

  final ShadSegmentStyleResolver? styleResolver;

  @override
  Widget build(BuildContext context, ShadSliderStateView view) {
    final cs = Theme.of(context).colorScheme;
    final compTheme = ComponentTheme.maybeOf<SliderTheme>(context);

    ShadSegmentStyle resolve(ShadSegment s) {
      if (styleResolver != null) return styleResolver!(context, view, s);
      switch (s.kind) {
        case ShadSegmentKind.fill:
          return ShadSegmentStyle(
            color: compTheme?.fillActiveColor ?? cs.primary,
            radius: s.radius,
          );
        case ShadSegmentKind.remaining:
          return ShadSegmentStyle(
            color: compTheme?.fillInactiveColor ?? cs.muted,
            radius: s.radius,
          );
        case ShadSegmentKind.gap:
          return const ShadSegmentStyle(color: Colors.transparent);
        case ShadSegmentKind.disabled:
          return ShadSegmentStyle(
            color: (compTheme?.fillInactiveColor ?? cs.muted).withOpacity(0.5),
            radius: s.radius,
          );
        case ShadSegmentKind.custom:
          return ShadSegmentStyle(color: cs.muted, radius: s.radius);
      }
    }

    final ordered = [...view.segments]
      ..sort((a, b) => a.paintOrder.compareTo(b.paintOrder));

    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (final s in ordered)
          if (s.rect.width > 0)
            Positioned.fromRect(
              rect: s.rect,
              child: Builder(
                builder: (context) {
                  final style = resolve(s);
                  final opacity = style.opacity ?? 1.0;
                  return Opacity(
                    opacity: opacity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: style.color,
                        gradient: style.gradient,
                        border: style.border,
                        borderRadius:
                            style.radius ?? s.radius ?? BorderRadius.zero,
                      ),
                    ),
                  );
                },
              ),
            ),
      ],
    );
  }
}

class ShadStepDotsRenderer extends ShadTrackRenderer {
  const ShadStepDotsRenderer({
    this.base = const ShadSegmentedCapsuleRenderer(),
  });

  final ShadTrackRenderer base;

  @override
  Widget build(BuildContext context, ShadSliderStateView view) {
    final cs = Theme.of(context).colorScheme;
    final compTheme = ComponentTheme.maybeOf<SliderTheme>(context);
    final active =
        compTheme?.dotsActiveColor ?? cs.foreground.withOpacity(0.18);
    final inactive =
        compTheme?.dotsInactiveColor ?? cs.foreground.withOpacity(0.08);
    final activeT = view.t ?? 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        base.build(context, view),
        for (final m in view.marks)
          Positioned(
            left: m.x - 3,
            top: view.trackRect.center.dy - 3,
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
    );
  }
}

class ShadWaveformRenderer extends ShadTrackRenderer {
  const ShadWaveformRenderer({
    this.base = const ShadSegmentedCapsuleRenderer(),
    this.bars = 64,
  });

  final ShadTrackRenderer base;
  final int bars;

  @override
  Widget build(BuildContext context, ShadSliderStateView view) {
    final cs = Theme.of(context).colorScheme;
    final compTheme = ComponentTheme.maybeOf<SliderTheme>(context);
    final w = view.trackRect.width;
    final h = view.trackRect.height;
    final barW = w / bars;
    final maxBarH = h * 0.75;
    final activeX = w * (view.t ?? 0);
    final active =
        compTheme?.waveformTicksActiveColor ?? cs.background.withOpacity(0.52);
    final inactive =
        compTheme?.waveformTicksInactiveColor ??
        cs.foreground.withOpacity(0.40);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        base.build(context, view),
        ClipRRect(
          borderRadius: BorderRadius.circular(view.trackRadius),
          child: Stack(
            children: [
              for (int i = 0; i < bars; i++)
                Positioned(
                  left: i * barW,
                  top: () {
                    final t = i / (bars - 1);
                    final amp = (math.sin(t * math.pi) * 0.85 + 0.15);
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
      ],
    );
  }
}
