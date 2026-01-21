import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../shared/primitives/animated_value_builder.dart';
import '../../shared/theme/theme.dart';
import '../../shared/utils/border_utils.dart';
import '../../shared/utils/constants.dart';
import '../../shared/utils/geometry_extensions.dart';
import '../../shared/utils/style_value.dart';

part '_impl/outlined_container_theme.dart';
part '_impl/dashed_painters.dart';

class SurfaceBlur extends StatelessWidget {
  const SurfaceBlur({
    super.key,
    required this.child,
    required this.surfaceBlur,
    this.borderRadius,
  });

  final Widget child;
  final double surfaceBlur;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (surfaceBlur <= 0) {
      return child;
    }
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: surfaceBlur,
                sigmaY: surfaceBlur,
              ),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class OutlinedContainer extends StatefulWidget {
  const OutlinedContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.borderStyle,
    this.boxShadow,
    this.padding,
    this.clipBehavior = Clip.antiAlias,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.width,
    this.height,
    this.duration,
  });

  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final double? borderWidth;
  final BorderStyle? borderStyle;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final double? width;
  final double? height;
  final Duration? duration;

  @override
  State<OutlinedContainer> createState() => _OutlinedContainerState();
}

class _OutlinedContainerState extends State<OutlinedContainer> {
  final GlobalKey _mainKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<OutlinedContainerTheme>(context);
    final borderRadius = styleValue<BorderRadiusGeometry>(
      widgetValue: widget.borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: theme.borderRadiusXl,
    );
    final backgroundColor = styleValue<Color>(
      widgetValue: widget.backgroundColor,
      themeValue: compTheme?.backgroundColor,
      defaultValue: theme.colorScheme.background,
    );
    final resolvedBorderRadius = borderRadius.resolve(Directionality.of(context));
    final surfaceOpacity = styleValue<double?>(
      widgetValue: widget.surfaceOpacity,
      themeValue: compTheme?.surfaceOpacity,
      defaultValue: null,
    );
    final baseBackgroundColor = surfaceOpacity != null
        ? backgroundColor.withValues(
            alpha: ((backgroundColor.a / 255.0) * surfaceOpacity).clamp(0.0, 1.0),
          )
        : backgroundColor;
    final borderColor = styleValue<Color>(
      widgetValue: widget.borderColor,
      themeValue: compTheme?.borderColor,
      defaultValue: theme.colorScheme.muted,
    );
    final borderWidth = styleValue<double>(
      widgetValue: widget.borderWidth,
      themeValue: compTheme?.borderWidth,
      defaultValue: 1.0 * theme.scaling,
    );
    final borderStyle = styleValue<BorderStyle>(
      widgetValue: widget.borderStyle,
      themeValue: compTheme?.borderStyle,
      defaultValue: BorderStyle.solid,
    );
    final boxShadow = styleValue<List<BoxShadow>>(
      widgetValue: widget.boxShadow,
      themeValue: compTheme?.boxShadow,
      defaultValue: [],
    );
    final padding = styleValue<EdgeInsetsGeometry>(
      widgetValue: widget.padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.zero,
    );
    final surfaceBlur = styleValue<double?>(
      widgetValue: widget.surfaceBlur,
      themeValue: compTheme?.surfaceBlur,
      defaultValue: null,
    );

    Widget current = AnimatedContainer(
      duration: widget.duration ?? Duration.zero,
      key: _mainKey,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: baseBackgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
          style: borderStyle,
        ),
        borderRadius: resolvedBorderRadius,
        boxShadow: boxShadow,
      ),
      child: AnimatedContainer(
        duration: widget.duration ?? Duration.zero,
        decoration: widget.clipBehavior == Clip.none ? null : const BoxDecoration(),
        clipBehavior: widget.clipBehavior,
        padding: padding,
        child: widget.child,
      ),
    );

    if (surfaceBlur != null && surfaceBlur > 0) {
      current = SurfaceBlur(
        surfaceBlur: surfaceBlur,
        borderRadius: subtractByBorder(resolvedBorderRadius, borderWidth),
        child: current,
      );
    }

    return current;
  }
}

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    this.width,
    this.gap,
    this.thickness,
    this.color,
  });

  final double? width;
  final double? gap;
  final double? thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedValueBuilder<DashedLineProperties>(
      value: DashedLineProperties(
        width: width ?? 8 * theme.scaling,
        gap: gap ?? 5 * theme.scaling,
        thickness: thickness ?? 1 * theme.scaling,
        color: color ?? theme.colorScheme.border,
      ),
      duration: kDefaultDuration,
      lerp: (a, b, t) {
        final start = a ?? b;
        final end = b ?? a ?? start;
        if (start == null || end == null) {
          return a ?? b;
        }
        return DashedLineProperties.lerp(start, end, t);
      },
      builder: (context, value, child) {
        return CustomPaint(
          painter: DashedLinePainter(
            width: value.width,
            gap: value.gap,
            thickness: value.thickness,
            color: value.color,
          ),
        );
      },
    );
  }
}

class DashedContainer extends StatelessWidget {
  const DashedContainer({
    super.key,
    this.strokeWidth,
    this.gap,
    this.thickness,
    this.color,
    this.borderRadius,
    required this.child,
  });

  final double? strokeWidth;
  final double? gap;
  final double? thickness;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedValueBuilder<DashedContainerProperties>(
      value: DashedContainerProperties(
        width: strokeWidth ?? 8 * theme.scaling,
        gap: gap ?? 5 * theme.scaling,
        thickness: thickness ?? 1 * theme.scaling,
        color: color ?? theme.colorScheme.border,
        borderRadius: borderRadius ?? theme.borderRadiusLg,
      ),
      duration: kDefaultDuration,
      lerp: (a, b, t) {
        final start = a ?? b;
        final end = b ?? a ?? start;
        if (start == null || end == null) {
          return a ?? b;
        }
        return DashedContainerProperties.lerp(context, start, end, t);
      },
      builder: (context, value, child) {
        return CustomPaint(
          painter: DashedPainter(
            width: value.width,
            gap: value.gap,
            thickness: value.thickness,
            color: value.color,
            borderRadius: value.borderRadius.optionallyResolve(context),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}

class DashedLineProperties {
  final double width;
  final double gap;
  final double thickness;
  final Color color;

  const DashedLineProperties({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
  });

  static DashedLineProperties lerp(
    DashedLineProperties a,
    DashedLineProperties b,
    double t,
  ) {
    return DashedLineProperties(
      width: lerpDouble(a.width, b.width, t)!,
      gap: lerpDouble(a.gap, b.gap, t)!,
      thickness: lerpDouble(a.thickness, b.thickness, t)!,
      color: Color.lerp(a.color, b.color, t)!,
    );
  }
}

class DashedContainerProperties {
  final double width;
  final double gap;
  final double thickness;
  final Color color;
  final BorderRadiusGeometry borderRadius;

  const DashedContainerProperties({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
    required this.borderRadius,
  });

  static DashedContainerProperties lerp(
    BuildContext context,
    DashedContainerProperties a,
    DashedContainerProperties b,
    double t,
  ) {
    return DashedContainerProperties(
      width: lerpDouble(a.width, b.width, t)!,
      gap: lerpDouble(a.gap, b.gap, t)!,
      thickness: lerpDouble(a.thickness, b.thickness, t)!,
      color: Color.lerp(a.color, b.color, t)!,
      borderRadius: BorderRadius.lerp(
        a.borderRadius.optionallyResolve(context),
        b.borderRadius.optionallyResolve(context),
        t,
      )!,
    );
  }
}
