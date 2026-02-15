import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide SliderTheme, Theme;

import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/utils/style_value.dart';
import '../themes/slider_theme.dart';

/// A waveform-based slider (no linear track).
///
/// - Renders vertical wave bars as the slider body.
/// - [value] is normalized in `[0..1]`.
/// - [samples] are normalized amplitudes in `[0..1]`.
/// - All visual parameters resolve through [SliderTheme] when not provided.
class WaveSlider extends StatelessWidget {
  const WaveSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.samples,
    this.height,
    this.padding,
    this.barWidth,
    this.barGap,
    this.minBarHeight,
    this.maxBarHeight,
    this.cornerRadius,
    this.activeColor,
    this.inactiveColor,
    this.disabledOpacity,
    this.showThumb,
    this.thumbRadius,
    this.thumbColor,
    this.thumbBorderColor,
    this.thumbBorderWidth,
    this.hitSlop,
    this.enabled,
    this.semanticsLabel,
  });

  /// Normalized slider value in `[0..1]`.
  final double value;

  /// Called when user scrubs via tap/drag.
  final ValueChanged<double> onChanged;

  /// Wave amplitudes in `[0..1]`.
  final List<double> samples;

  /// Total widget height.
  final double? height;

  /// Insets around waveform paint content.
  final EdgeInsets? padding;

  /// Bar width in logical pixels.
  final double? barWidth;

  /// Gap between bars in logical pixels.
  final double? barGap;

  /// Minimum bar height in logical pixels.
  final double? minBarHeight;

  /// Maximum bar height in logical pixels.
  final double? maxBarHeight;

  /// Corner radius for each bar.
  final double? cornerRadius;

  /// Color for progressed bars (left of current value).
  final Color? activeColor;

  /// Color for remaining bars (right of current value).
  final Color? inactiveColor;

  /// Overall opacity when [enabled] is false.
  final double? disabledOpacity;

  /// Whether to paint a thumb marker.
  final bool? showThumb;

  /// Thumb radius in logical pixels.
  final double? thumbRadius;

  /// Thumb fill color.
  final Color? thumbColor;

  /// Thumb border color.
  final Color? thumbBorderColor;

  /// Thumb border width in logical pixels.
  final double? thumbBorderWidth;

  /// Extra vertical hit target padding.
  final double? hitSlop;

  /// Whether user interaction is enabled.
  final bool? enabled;

  /// Optional semantics label.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final compTheme = ComponentTheme.maybeOf<SliderTheme>(context);
    final baseGap = theme.density.baseGap * theme.scaling;

    final resolvedEnabled = styleValue(
      widgetValue: enabled,
      themeValue: compTheme?.waveEnabled,
      defaultValue: true,
    );
    final resolvedHeight = styleValue(
      widgetValue: height,
      themeValue: compTheme?.waveHeight,
      defaultValue: baseGap * 5.5,
    );
    final resolvedPadding = styleValue(
      widgetValue: padding,
      themeValue: compTheme?.wavePadding,
      defaultValue: EdgeInsets.symmetric(horizontal: baseGap),
    );
    final resolvedBarWidth = styleValue(
      widgetValue: barWidth,
      themeValue: compTheme?.waveBarWidth,
      defaultValue: (baseGap * 0.5).clamp(2.0, 6.0).toDouble(),
    );
    final resolvedBarGap = styleValue(
      widgetValue: barGap,
      themeValue: compTheme?.waveBarGap,
      defaultValue: (baseGap * 0.25).clamp(1.0, 4.0).toDouble(),
    );
    final resolvedMinBarHeight = styleValue(
      widgetValue: minBarHeight,
      themeValue: compTheme?.waveMinBarHeight,
      defaultValue: (baseGap * 0.75).clamp(2.0, 12.0).toDouble(),
    );
    final resolvedMaxBarHeight = styleValue(
      widgetValue: maxBarHeight,
      themeValue: compTheme?.waveMaxBarHeight,
      defaultValue: (baseGap * 5.0).clamp(10.0, 80.0).toDouble(),
    );
    final resolvedCornerRadius = styleValue(
      widgetValue: cornerRadius,
      themeValue: compTheme?.waveCornerRadius,
      defaultValue: theme.radiusLg,
    );
    final resolvedActive = styleValue(
      widgetValue: activeColor,
      themeValue: compTheme?.waveActiveColor,
      defaultValue: cs.primary,
    );
    final resolvedInactive = styleValue(
      widgetValue: inactiveColor,
      themeValue: compTheme?.waveInactiveColor,
      defaultValue: cs.muted.withOpacity(0.75),
    );
    final resolvedDisabledOpacity = styleValue(
      widgetValue: disabledOpacity,
      themeValue: compTheme?.waveDisabledOpacity,
      defaultValue: 0.45,
    );
    final resolvedShowThumb = styleValue(
      widgetValue: showThumb,
      themeValue: compTheme?.waveShowThumb,
      defaultValue: true,
    );
    final resolvedThumbRadius = styleValue(
      widgetValue: thumbRadius,
      themeValue: compTheme?.waveThumbRadius,
      defaultValue: (baseGap * 1.25).clamp(6.0, 14.0).toDouble(),
    );
    final resolvedThumbColor = styleValue(
      widgetValue: thumbColor,
      themeValue: compTheme?.waveThumbColor,
      defaultValue: cs.background,
    );
    final resolvedThumbBorderColor = styleValue(
      widgetValue: thumbBorderColor,
      themeValue: compTheme?.waveThumbBorderColor,
      defaultValue: cs.foreground.withOpacity(0.18),
    );
    final resolvedThumbBorderWidth = styleValue(
      widgetValue: thumbBorderWidth,
      themeValue: compTheme?.waveThumbBorderWidth,
      defaultValue: 2.0,
    );
    final resolvedHitSlop = styleValue(
      widgetValue: hitSlop,
      themeValue: compTheme?.waveHitSlop,
      defaultValue: baseGap,
    );

    final clamped = value.clamp(0.0, 1.0);

    Widget body = SizedBox(
      height: resolvedHeight,
      child: CustomPaint(
        painter: _WaveSliderPainter(
          value: clamped,
          samples: samples,
          padding: resolvedPadding,
          barWidth: resolvedBarWidth,
          barGap: resolvedBarGap,
          minBarHeight: resolvedMinBarHeight,
          maxBarHeight: math.min(
            resolvedMaxBarHeight,
            resolvedHeight - resolvedPadding.vertical,
          ),
          cornerRadius: resolvedCornerRadius,
          activeColor: resolvedActive,
          inactiveColor: resolvedInactive,
          showThumb: resolvedShowThumb,
          thumbRadius: resolvedThumbRadius,
          thumbColor: resolvedThumbColor,
          thumbBorderColor: resolvedThumbBorderColor,
          thumbBorderWidth: resolvedThumbBorderWidth,
        ),
      ),
    );

    if (resolvedEnabled) {
      body = _WaveSliderGestureLayer(
        height: resolvedHeight,
        padding: resolvedPadding,
        hitSlop: resolvedHitSlop,
        onValue: (v) => onChanged(v.clamp(0.0, 1.0)),
        child: body,
      );
    } else {
      body = Opacity(opacity: resolvedDisabledOpacity, child: body);
    }

    return Semantics(
      label: semanticsLabel ?? 'Wave slider',
      value: '${(clamped * 100).round()}%',
      increasedValue: 'Increase',
      decreasedValue: 'Decrease',
      slider: true,
      enabled: resolvedEnabled,
      child: body,
    );
  }
}

class _WaveSliderGestureLayer extends StatelessWidget {
  const _WaveSliderGestureLayer({
    required this.child,
    required this.height,
    required this.padding,
    required this.hitSlop,
    required this.onValue,
  });

  final Widget child;
  final double height;
  final EdgeInsets padding;
  final double hitSlop;
  final ValueChanged<double> onValue;

  double _posToValue(BoxConstraints c, Offset localPos) {
    final left = padding.left;
    final right = c.maxWidth - padding.right;
    final x = localPos.dx.clamp(left, right);
    final w = math.max(1.0, right - left);
    return (x - left) / w;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (d) => onValue(_posToValue(c, d.localPosition)),
          onHorizontalDragStart: (d) =>
              onValue(_posToValue(c, d.localPosition)),
          onHorizontalDragUpdate: (d) =>
              onValue(_posToValue(c, d.localPosition)),
          child: SizedBox(
            height: height + hitSlop * 2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: hitSlop),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _WaveSliderPainter extends CustomPainter {
  _WaveSliderPainter({
    required this.value,
    required this.samples,
    required this.padding,
    required this.barWidth,
    required this.barGap,
    required this.minBarHeight,
    required this.maxBarHeight,
    required this.cornerRadius,
    required this.activeColor,
    required this.inactiveColor,
    required this.showThumb,
    required this.thumbRadius,
    required this.thumbColor,
    required this.thumbBorderColor,
    required this.thumbBorderWidth,
  });

  final double value;
  final List<double> samples;
  final EdgeInsets padding;

  final double barWidth;
  final double barGap;
  final double minBarHeight;
  final double maxBarHeight;
  final double cornerRadius;

  final Color activeColor;
  final Color inactiveColor;

  final bool showThumb;
  final double thumbRadius;
  final Color thumbColor;
  final Color thumbBorderColor;
  final double thumbBorderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paintActive = Paint()..color = activeColor;
    final paintInactive = Paint()..color = inactiveColor;

    final contentLeft = padding.left;
    final contentRight = size.width - padding.right;
    final contentTop = padding.top;
    final contentBottom = size.height - padding.bottom;

    final contentW = math.max(1.0, contentRight - contentLeft);
    final contentH = math.max(1.0, contentBottom - contentTop);

    final step = barWidth + barGap;
    final maxBars = (contentW / step).floor().clamp(1, 10000);
    final amps = _resampleTo(samples, maxBars);

    final centerY = contentTop + contentH / 2;
    final progressX = contentLeft + contentW * value;

    for (int i = 0; i < maxBars; i++) {
      final x = contentLeft + i * step;
      final a = amps[i].clamp(0.0, 1.0);

      final h = lerpDouble(minBarHeight, maxBarHeight, a)!;
      final half = h / 2;

      final rect = Rect.fromLTWH(x, centerY - half, barWidth, h);
      final rrect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(cornerRadius),
      );

      final barMidX = x + barWidth / 2;
      canvas.drawRRect(
        rrect,
        barMidX <= progressX ? paintActive : paintInactive,
      );
    }

    if (showThumb) {
      final thumbCx = progressX.clamp(contentLeft, contentRight);
      final thumbCy = centerY;

      final fill = Paint()..color = thumbColor;
      final stroke = Paint()
        ..color = thumbBorderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = thumbBorderWidth;

      canvas.drawCircle(Offset(thumbCx, thumbCy), thumbRadius, fill);
      canvas.drawCircle(Offset(thumbCx, thumbCy), thumbRadius, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveSliderPainter old) {
    return old.value != value ||
        !listEquals(old.samples, samples) ||
        old.padding != padding ||
        old.barWidth != barWidth ||
        old.barGap != barGap ||
        old.minBarHeight != minBarHeight ||
        old.maxBarHeight != maxBarHeight ||
        old.cornerRadius != cornerRadius ||
        old.activeColor != activeColor ||
        old.inactiveColor != inactiveColor ||
        old.showThumb != showThumb ||
        old.thumbRadius != thumbRadius ||
        old.thumbColor != thumbColor ||
        old.thumbBorderColor != thumbBorderColor ||
        old.thumbBorderWidth != thumbBorderWidth;
  }

  static List<double> _resampleTo(List<double> input, int n) {
    if (n <= 0) return const [];
    if (input.isEmpty) return List<double>.filled(n, 0.2);
    if (input.length == n) return input;

    final out = List<double>.filled(n, 0);
    for (int i = 0; i < n; i++) {
      final t = n == 1 ? 0.0 : i / (n - 1);
      final idx = t * (input.length - 1);
      final i0 = idx.floor().clamp(0, input.length - 1);
      final i1 = (i0 + 1).clamp(0, input.length - 1);
      final f = idx - i0;
      out[i] = input[i0] * (1 - f) + input[i1] * f;
    }
    return out;
  }
}
