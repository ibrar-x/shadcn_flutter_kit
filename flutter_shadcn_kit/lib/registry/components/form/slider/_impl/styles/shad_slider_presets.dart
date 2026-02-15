import 'package:flutter/material.dart' hide Theme;

import '../../../../../shared/theme/theme.dart';

import '../core/shad_slider_models.dart';
import 'shad_slider_defaults.dart';

enum ShadSliderPreset { brightness, rangeSoft, stepsDots, waveform }

/// Resolved preset output: builders + tuned layout values.
class ShadPresetResolved {
  const ShadPresetResolved({
    required this.trackBuilder,
    required this.fillBuilder,
    required this.thumbBuilder,
    required this.ticksBuilder,
    required this.overlayBuilder,
    required this.trackHeight,
    required this.thumbInset,
    required this.fillEdgeBiasPx,
  });

  final ShadTrackBuilder trackBuilder;
  final ShadFillBuilder fillBuilder;
  final ShadThumbBuilder thumbBuilder;
  final ShadTicksBuilder ticksBuilder;
  final ShadOverlayBuilder overlayBuilder;

  final double trackHeight;
  final double thumbInset;
  final double fillEdgeBiasPx;
}

ShadPresetResolved resolveShadSliderPreset(
  BuildContext context, {
  required ShadSliderPreset preset,
  required double trackHeight,
  required double thumbInset,
  required double fillEdgeBiasPx,
  ShadTrackBuilder? trackBuilder,
  ShadFillBuilder? fillBuilder,
  ShadThumbBuilder? thumbBuilder,
  ShadTicksBuilder? ticksBuilder,
  ShadOverlayBuilder? overlayBuilder,
}) {
  // Presets only fill missing inputs; explicit widget/theme inputs win.
  final defaults = ShadSliderDefaults.of(context);

  ShadTrackBuilder tb = trackBuilder ?? defaults.trackBuilder;
  ShadFillBuilder fb = fillBuilder ?? defaults.fillBuilder;
  ShadThumbBuilder thb = thumbBuilder ?? defaults.thumbBuilder;
  ShadTicksBuilder tix = ticksBuilder ?? defaults.ticksBuilder;
  ShadOverlayBuilder ob = overlayBuilder ?? defaults.overlayBuilder;

  double h = trackHeight;
  double inset = thumbInset;
  double bias = fillEdgeBiasPx;

  switch (preset) {
    case ShadSliderPreset.brightness:
      break;
    case ShadSliderPreset.rangeSoft:
      h = trackHeight + 2;
      thb = thumbBuilder ?? ShadSliderDefaults.circleThumb;
      bias = 0;
      break;
    case ShadSliderPreset.stepsDots:
      h = (trackHeight - 2).clamp(16.0, 9999.0);
      thb = thumbBuilder ?? ShadSliderDefaults.circleThumb;
      tix = ticksBuilder ?? ShadSliderDefaults.dotsTicks;
      bias = 0;
      break;
    case ShadSliderPreset.waveform:
      thb = thumbBuilder ?? ShadSliderDefaults.circleThumb;
      tix = ticksBuilder ?? ShadSliderDefaults.subtleBarsTicks;
      bias = 0;
      break;
  }

  return ShadPresetResolved(
    trackBuilder: tb,
    fillBuilder: fb,
    thumbBuilder: thb,
    ticksBuilder: tix,
    overlayBuilder: ob,
    trackHeight: h,
    thumbInset: inset,
    fillEdgeBiasPx: bias,
  );
}
