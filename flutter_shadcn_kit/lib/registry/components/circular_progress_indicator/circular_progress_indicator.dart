import 'package:flutter/material.dart' as mat;
import 'package:flutter/widgets.dart';

import '../../shared/primitives/animated_value_builder.dart';
import '../../shared/theme/theme.dart';
import '../../shared/utils/color_extensions.dart';
import '../../shared/utils/constants.dart';
import '../../shared/utils/style_value.dart';

part '_impl/circular_progress_indicator_theme.dart';

/// Circular progress indicator with determinate/indeterminate modes and theming.
class CircularProgressIndicator extends StatelessWidget {
  const CircularProgressIndicator({
    super.key,
    this.value,
    this.size,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.duration = kDefaultDuration,
    this.animated = true,
    this.onSurface = false,
  });

  final double? value;
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final double? strokeWidth;
  final Duration duration;
  final bool animated;
  final bool onSurface;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final theme = Theme.of(context);
    final compTheme =
        ComponentTheme.maybeOf<CircularProgressIndicatorTheme>(context);

    final effectiveSize = styleValue(
      widgetValue: size,
      themeValue: compTheme?.size,
      defaultValue: (iconTheme.size ?? 24 * theme.scaling) - 8 * theme.scaling,
    );

    final effectiveColor = styleValue(
      widgetValue: color,
      themeValue: compTheme?.color,
      defaultValue:
          onSurface ? theme.colorScheme.background : theme.colorScheme.primary,
    );

    final effectiveBackgroundColor = styleValue(
      widgetValue: backgroundColor,
      themeValue: compTheme?.backgroundColor,
      defaultValue: effectiveColor.scaleAlpha(0.2),
    );

    final effectiveStrokeWidth = styleValue(
      widgetValue: strokeWidth,
      themeValue: compTheme?.strokeWidth,
      defaultValue: effectiveSize / 12,
    );

    Widget buildIndicator(double? currentValue) {
      final progressIndicator = mat.CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
        color: effectiveColor,
        backgroundColor: effectiveBackgroundColor,
        strokeWidth: effectiveStrokeWidth,
        value: currentValue,
      );

      return RepaintBoundary(
        child: SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: progressIndicator,
        ),
      );
    }

    if (value == null || !animated) {
      return buildIndicator(value);
    }

    return AnimatedValueBuilder(
      value: value!,
      duration: duration,
      builder: (context, value, child) {
        return buildIndicator(value);
      },
    );
  }
}
