import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide SliderTheme, Theme;

import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/utils/style_value.dart';
import '../core/shad_slider_models.dart';
import '../styles/shad_slider_defaults.dart';
import '../themes/slider_theme.dart';

/// A waveform-based slider (no linear track).
///
/// - Renders vertical wave bars as the slider body.
/// - Supports two modes:
///   - normalized mode (`value` in `[0..1]`, default)
///   - domain mode via [WaveSlider.domain] (`value` in `[min..max]`)
/// - All visual parameters resolve through [SliderTheme] when not provided.
class WaveSlider extends StatefulWidget {
  const WaveSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.samples,
    this.min = 0,
    this.max = 1,
    this.valueIsNormalized = true,
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
    this.popoverBuilder,
    this.popoverOffset,
    this.popoverVisibility,
    this.valueFormatter,
    this.semanticsLabel,
  }) : assert(max > min);

  /// Creates a domain-value waveform slider.
  ///
  /// Use this when your app value is not normalized (for example prices such as
  /// `97`, `99`, `120`). Gesture updates and [onChanged] emit values in
  /// `[min, max]`.
  factory WaveSlider.domain({
    Key? key,
    required double value,
    required ValueChanged<double> onChanged,
    required List<double> samples,
    double min = 0,
    double max = 1,
    double? height,
    EdgeInsets? padding,
    double? barWidth,
    double? barGap,
    double? minBarHeight,
    double? maxBarHeight,
    double? cornerRadius,
    Color? activeColor,
    Color? inactiveColor,
    double? disabledOpacity,
    bool? showThumb,
    double? thumbRadius,
    Color? thumbColor,
    Color? thumbBorderColor,
    double? thumbBorderWidth,
    double? hitSlop,
    bool? enabled,
    ShadPopoverBuilder? popoverBuilder,
    Offset? popoverOffset,
    ShadPopoverVisibility? popoverVisibility,
    String Function(double value)? valueFormatter,
    String? semanticsLabel,
  }) {
    return WaveSlider(
      key: key,
      value: value,
      onChanged: onChanged,
      samples: samples,
      min: min,
      max: max,
      valueIsNormalized: false,
      height: height,
      padding: padding,
      barWidth: barWidth,
      barGap: barGap,
      minBarHeight: minBarHeight,
      maxBarHeight: maxBarHeight,
      cornerRadius: cornerRadius,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      disabledOpacity: disabledOpacity,
      showThumb: showThumb,
      thumbRadius: thumbRadius,
      thumbColor: thumbColor,
      thumbBorderColor: thumbBorderColor,
      thumbBorderWidth: thumbBorderWidth,
      hitSlop: hitSlop,
      enabled: enabled,
      popoverBuilder: popoverBuilder,
      popoverOffset: popoverOffset,
      popoverVisibility: popoverVisibility,
      valueFormatter: valueFormatter,
      semanticsLabel: semanticsLabel,
    );
  }

  /// Current value.
  ///
  /// - If [valueIsNormalized] is true: expected in `[0..1]`.
  /// - If [valueIsNormalized] is false: expected in `[min..max]`.
  final double value;

  /// Called when user scrubs via tap/drag.
  ///
  /// The emitted value matches the configured mode:
  /// - normalized mode => emits `[0..1]`
  /// - domain mode => emits `[min..max]`
  final ValueChanged<double> onChanged;

  /// Wave amplitudes in `[0..1]`.
  final List<double> samples;

  /// Lower bound for domain mode.
  final double min;

  /// Upper bound for domain mode.
  final double max;

  /// Whether [value] / [onChanged] use normalized values.
  final bool valueIsNormalized;

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

  /// Optional popover shown above the thumb.
  final ShadPopoverBuilder? popoverBuilder;

  /// Popover anchor offset from thumb center.
  final Offset? popoverOffset;

  /// Controls when popover is visible.
  final ShadPopoverVisibility? popoverVisibility;

  /// Optional value formatter used by default popover and semantics.
  final String Function(double value)? valueFormatter;

  /// Optional semantics label.
  final String? semanticsLabel;

  @override
  State<WaveSlider> createState() => _WaveSliderState();
}

class _WaveSliderState extends State<WaveSlider> {
  bool _dragging = false;

  double _normalize(double v) {
    if (widget.valueIsNormalized) {
      return v.clamp(0.0, 1.0).toDouble();
    }
    final range = widget.max - widget.min;
    if (range == 0) return 0.0;
    return ((v - widget.min) / range).clamp(0.0, 1.0).toDouble();
  }

  double _denormalize(double t) {
    final clamped = t.clamp(0.0, 1.0).toDouble();
    return widget.min + (widget.max - widget.min) * clamped;
  }

  void _emitFromNormalized(double t) {
    final clamped = t.clamp(0.0, 1.0).toDouble();
    widget.onChanged(
      widget.valueIsNormalized ? clamped : _denormalize(clamped),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final compTheme = ComponentTheme.maybeOf<SliderTheme>(context);
    final baseGap = theme.density.baseGap * theme.scaling;

    final resolvedEnabled = styleValue(
      widgetValue: widget.enabled,
      themeValue: compTheme?.waveEnabled,
      defaultValue: true,
    );
    final resolvedHeight = styleValue(
      widgetValue: widget.height,
      themeValue: compTheme?.waveHeight,
      defaultValue: baseGap * 5.5,
    );
    final resolvedPadding = styleValue(
      widgetValue: widget.padding,
      themeValue: compTheme?.wavePadding,
      defaultValue: EdgeInsets.symmetric(horizontal: baseGap),
    );
    final resolvedBarWidth = styleValue(
      widgetValue: widget.barWidth,
      themeValue: compTheme?.waveBarWidth,
      defaultValue: (baseGap * 0.5).clamp(2.0, 6.0).toDouble(),
    );
    final resolvedBarGap = styleValue(
      widgetValue: widget.barGap,
      themeValue: compTheme?.waveBarGap,
      defaultValue: (baseGap * 0.25).clamp(1.0, 4.0).toDouble(),
    );
    final resolvedMinBarHeight = styleValue(
      widgetValue: widget.minBarHeight,
      themeValue: compTheme?.waveMinBarHeight,
      defaultValue: (baseGap * 0.75).clamp(2.0, 12.0).toDouble(),
    );
    final resolvedMaxBarHeight = styleValue(
      widgetValue: widget.maxBarHeight,
      themeValue: compTheme?.waveMaxBarHeight,
      defaultValue: (baseGap * 5.0).clamp(10.0, 80.0).toDouble(),
    );
    final resolvedCornerRadius = styleValue(
      widgetValue: widget.cornerRadius,
      themeValue: compTheme?.waveCornerRadius,
      defaultValue: theme.radiusLg,
    );
    final resolvedActive = styleValue(
      widgetValue: widget.activeColor,
      themeValue: compTheme?.waveActiveColor,
      defaultValue: cs.primary,
    );
    final resolvedInactive = styleValue(
      widgetValue: widget.inactiveColor,
      themeValue: compTheme?.waveInactiveColor,
      defaultValue: cs.muted.withOpacity(0.75),
    );
    final resolvedDisabledOpacity = styleValue(
      widgetValue: widget.disabledOpacity,
      themeValue: compTheme?.waveDisabledOpacity,
      defaultValue: 0.45,
    );
    final resolvedShowThumb = styleValue(
      widgetValue: widget.showThumb,
      themeValue: compTheme?.waveShowThumb,
      defaultValue: true,
    );
    final resolvedThumbRadius = styleValue(
      widgetValue: widget.thumbRadius,
      themeValue: compTheme?.waveThumbRadius,
      defaultValue: (baseGap * 1.25).clamp(6.0, 14.0).toDouble(),
    );
    final resolvedThumbColor = styleValue(
      widgetValue: widget.thumbColor,
      themeValue: compTheme?.waveThumbColor,
      defaultValue: cs.background,
    );
    final resolvedThumbBorderColor = styleValue(
      widgetValue: widget.thumbBorderColor,
      themeValue: compTheme?.waveThumbBorderColor,
      defaultValue: cs.foreground.withOpacity(0.18),
    );
    final resolvedThumbBorderWidth = styleValue(
      widgetValue: widget.thumbBorderWidth,
      themeValue: compTheme?.waveThumbBorderWidth,
      defaultValue: 2.0,
    );
    final resolvedHitSlop = styleValue(
      widgetValue: widget.hitSlop,
      themeValue: compTheme?.waveHitSlop,
      defaultValue: baseGap,
    );
    final resolvedPopoverBuilder = styleValue<ShadPopoverBuilder?>(
      widgetValue: widget.popoverBuilder,
      themeValue: compTheme?.wavePopoverBuilder,
      defaultValue: null,
    );
    final resolvedPopoverOffset = styleValue<Offset>(
      widgetValue: widget.popoverOffset,
      themeValue: compTheme?.wavePopoverOffset,
      defaultValue: const Offset(0, -12),
    );
    final resolvedPopoverVisibility = styleValue<ShadPopoverVisibility>(
      widgetValue: widget.popoverVisibility,
      themeValue: compTheme?.wavePopoverVisibility,
      defaultValue: ShadPopoverVisibility.whileDragging,
    );

    final normalizedValue = _normalize(widget.value);
    final denormalizedValue = _denormalize(normalizedValue);
    final semanticsText =
        widget.valueFormatter?.call(denormalizedValue) ??
        '${(normalizedValue * 100).round()}%';

    final defaultWavePopover = ShadSliderDefaults.valuePopover(
      formatter: widget.valueFormatter,
      shape: compTheme?.popoverShape,
    );
    final effectivePopoverBuilder =
        resolvedPopoverBuilder ?? defaultWavePopover;
    final showPopover =
        resolvedPopoverVisibility != ShadPopoverVisibility.never &&
        (resolvedPopoverVisibility == ShadPopoverVisibility.always ||
            _dragging);

    Widget body = SizedBox(
      height: resolvedHeight,
      child: CustomPaint(
        painter: _WaveSliderPainter(
          value: normalizedValue,
          samples: widget.samples,
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

    if (!resolvedEnabled) {
      body = Opacity(opacity: resolvedDisabledOpacity, child: body);
    }

    return LayoutBuilder(
      builder: (context, c) {
        final left = resolvedPadding.left;
        final right = c.maxWidth - resolvedPadding.right;
        final contentW = math.max(1.0, right - left);
        final thumbX = (left + contentW * normalizedValue).clamp(left, right);
        final contentTop = resolvedPadding.top;
        final contentBottom = resolvedHeight - resolvedPadding.bottom;
        final thumbY = contentTop + (contentBottom - contentTop) / 2;

        Widget interactive = Stack(
          clipBehavior: Clip.none,
          children: [
            body,
            if (showPopover)
              Positioned(
                left: thumbX + resolvedPopoverOffset.dx,
                top:
                    thumbY -
                    (resolvedShowThumb ? resolvedThumbRadius : 0) +
                    resolvedPopoverOffset.dy,
                child: FractionalTranslation(
                  translation: const Offset(-0.5, -1.0),
                  child: IgnorePointer(
                    child: effectivePopoverBuilder(
                      context,
                      ShadPopoverData(
                        value: denormalizedValue,
                        normalizedValue: normalizedValue,
                        isDragging: _dragging,
                        meta: <String, Object?>{
                          'min': widget.min,
                          'max': widget.max,
                          'valueIsNormalized': widget.valueIsNormalized,
                          'samplesCount': widget.samples.length,
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );

        if (resolvedEnabled) {
          interactive = _WaveSliderGestureLayer(
            height: resolvedHeight,
            padding: resolvedPadding,
            hitSlop: resolvedHitSlop,
            onValue: _emitFromNormalized,
            onDragStateChanged: (dragging) {
              if (_dragging != dragging && mounted) {
                setState(() => _dragging = dragging);
              }
            },
            child: interactive,
          );
        }

        return Semantics(
          label: widget.semanticsLabel ?? 'Wave slider',
          value: semanticsText,
          increasedValue: 'Increase',
          decreasedValue: 'Decrease',
          slider: true,
          enabled: resolvedEnabled,
          child: interactive,
        );
      },
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
    required this.onDragStateChanged,
  });

  final Widget child;
  final double height;
  final EdgeInsets padding;
  final double hitSlop;
  final ValueChanged<double> onValue;
  final ValueChanged<bool> onDragStateChanged;

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
          onTapDown: (d) {
            onDragStateChanged(true);
            onValue(_posToValue(c, d.localPosition));
          },
          onTapUp: (_) => onDragStateChanged(false),
          onTapCancel: () => onDragStateChanged(false),
          onHorizontalDragStart: (d) {
            onDragStateChanged(true);
            onValue(_posToValue(c, d.localPosition));
          },
          onHorizontalDragUpdate: (d) =>
              onValue(_posToValue(c, d.localPosition)),
          onHorizontalDragEnd: (_) => onDragStateChanged(false),
          onHorizontalDragCancel: () => onDragStateChanged(false),
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
