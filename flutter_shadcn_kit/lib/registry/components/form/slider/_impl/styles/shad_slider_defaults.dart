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

  final ShadSliderTrackBuilder trackBuilder;
  final ShadSliderFillBuilder fillBuilder;
  final ShadSliderThumbBuilder thumbBuilder;
  final ShadSliderTicksBuilder ticksBuilder;
  final ShadSliderOverlayBuilder overlayBuilder;

  static ShadSliderDefaults of(BuildContext context) {
    final theme = Theme.of(context);

    return ShadSliderDefaults(
      trackBuilder: (context, state) {
        final radius = BorderRadius.circular(state.trackRadius);
        final inactive = theme.colorScheme.surfaceContainerHighest.withOpacity(
          state.enabled ? 0.65 : 0.35,
        );

        return ClipRRect(
          borderRadius: radius,
          child: Container(
            width: state.trackRect.width,
            height: state.trackRect.height,
            color: inactive,
          ),
        );
      },
      fillBuilder: (context, state) {
        final active = theme.colorScheme.primary.withOpacity(
          state.enabled ? 0.95 : 0.35,
        );

        if (!state.isRange) {
          final rect = state.activeRect ?? Rect.zero;
          final atMax = ((state.value ?? state.min) - state.max).abs() < 1e-9;

          final radius = BorderRadius.only(
            topLeft: Radius.circular(state.trackRadius),
            bottomLeft: Radius.circular(state.trackRadius),
            topRight: Radius.circular(atMax ? state.trackRadius : 0),
            bottomRight: Radius.circular(atMax ? state.trackRadius : 0),
          );

          return ClipRRect(
            borderRadius: radius,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: rect.width,
                height: state.trackRect.height,
                color: active,
              ),
            ),
          );
        }

        final rect = state.rangeRect ?? Rect.zero;
        final touchesMin = (state.rangeValue!.start - state.min).abs() < 1e-9;
        final touchesMax = (state.rangeValue!.end - state.max).abs() < 1e-9;
        final radius = BorderRadius.only(
          topLeft: Radius.circular(touchesMin ? state.trackRadius : 0),
          bottomLeft: Radius.circular(touchesMin ? state.trackRadius : 0),
          topRight: Radius.circular(touchesMax ? state.trackRadius : 0),
          bottomRight: Radius.circular(touchesMax ? state.trackRadius : 0),
        );

        return Positioned.fromRect(
          rect: rect,
          child: ClipRRect(
            borderRadius: radius,
            child: ColoredBox(color: active),
          ),
        );
      },
      thumbBuilder: (context, thumb) {
        final h = thumb.size.height;
        final barHeight = math.max(0.0, h - 10);

        return IgnorePointer(
          ignoring: true,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            width: 6,
            height: barHeight,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(thumb.enabled ? 1 : 0.6),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  blurRadius: thumb.active ? 10 : 6,
                  offset: const Offset(0, 2),
                  color: thumb.active ? Colors.black26 : Colors.black12,
                ),
              ],
            ),
          ),
        );
      },
      ticksBuilder: (context, state) => const SizedBox.shrink(),
      overlayBuilder: (context, state) => const SizedBox.shrink(),
    );
  }
}
