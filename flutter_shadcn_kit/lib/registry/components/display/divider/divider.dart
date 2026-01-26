import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../../shared/primitives/animated_value_builder.dart';
import '../../../shared/primitives/text.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/constants.dart';
import '../../../shared/utils/style_value.dart';
import '../../../shared/utils/util.dart';

part '_impl/divider_theme.dart';
part '_impl/divider_painters.dart';

/// Horizontal line separating content with optional label.
class Divider extends StatelessWidget implements PreferredSizeWidget {
  const Divider({
    super.key,
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding,
  });

  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  @override
  Size get preferredSize => Size(0, height ?? 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final componentTheme = ComponentTheme.maybeOf<DividerTheme>(context);
    final resolvedColor = styleValue(
      widgetValue: color,
      themeValue: componentTheme?.color,
      defaultValue: theme.colorScheme.border,
    );
    final resolvedThickness = styleValue(
      widgetValue: thickness,
      themeValue: componentTheme?.thickness,
      defaultValue: 1.0,
    );
    final resolvedHeight = styleValue(
      widgetValue: height,
      themeValue: componentTheme?.height,
      defaultValue: resolvedThickness,
    );
    final resolvedIndent = styleValue(
      widgetValue: indent,
      themeValue: componentTheme?.indent,
      defaultValue: 0.0,
    );
    final resolvedEndIndent = styleValue(
      widgetValue: endIndent,
      themeValue: componentTheme?.endIndent,
      defaultValue: 0.0,
    );
    final resolvedPadding = styleValue(
      widgetValue: padding,
      themeValue: componentTheme?.padding,
      defaultValue: EdgeInsets.symmetric(horizontal: theme.scaling * 8),
    );

    if (child != null) {
      final labeledChild =
          child!.muted().small().withPadding(padding: resolvedPadding);
      return SizedBox(
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  height: resolvedHeight,
                  child: AnimatedValueBuilder(
                    value: DividerProperties(
                      color: resolvedColor,
                      thickness: resolvedThickness,
                      indent: resolvedIndent,
                      endIndent: 0,
                    ),
                    duration: kDefaultDuration,
                    lerp: DividerProperties.lerp,
                    builder: (context, value, child) {
                      return CustomPaint(
                        painter: DividerPainter(
                          color: value.color,
                          thickness: value.thickness,
                          indent: value.indent,
                          endIndent: value.endIndent,
                        ),
                      );
                    },
                  ),
                ),
              ),
              labeledChild,
              Expanded(
                child: SizedBox(
                  height: resolvedHeight,
                  child: AnimatedValueBuilder(
                    value: DividerProperties(
                      color: resolvedColor,
                      thickness: resolvedThickness,
                      indent: 0,
                      endIndent: resolvedEndIndent,
                    ),
                    duration: kDefaultDuration,
                    lerp: DividerProperties.lerp,
                    builder: (context, value, child) {
                      return CustomPaint(
                        painter: DividerPainter(
                          color: value.color,
                          thickness: value.thickness,
                          indent: value.indent,
                          endIndent: value.endIndent,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: resolvedHeight,
      width: double.infinity,
      child: AnimatedValueBuilder(
        value: DividerProperties(
          color: resolvedColor,
          thickness: resolvedThickness,
          indent: resolvedIndent,
          endIndent: resolvedEndIndent,
        ),
        lerp: DividerProperties.lerp,
        duration: kDefaultDuration,
        builder: (context, value, child) {
          return CustomPaint(
            painter: DividerPainter(
              color: value.color,
              thickness: value.thickness,
              indent: value.indent,
              endIndent: value.endIndent,
            ),
          );
        },
      ),
    );
  }
}

/// Vertical line that divides horizontal layouts.
class VerticalDivider extends StatelessWidget implements PreferredSizeWidget {
  const VerticalDivider({
    super.key,
    this.color,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  final Color? color;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  @override
  Size get preferredSize => Size(width ?? 1, 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainAxisIndent = indent ?? 0;
    final mainAxisEndIndent = endIndent ?? 0;
    if (child != null) {
      final labeledChild = child!.muted().small().withPadding(padding: padding);
      return SizedBox(
        height: double.infinity,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  width: width ?? 1,
                  child: AnimatedValueBuilder(
                    value: DividerProperties(
                      color: color ?? theme.colorScheme.border,
                      thickness: thickness ?? 1,
                      indent: mainAxisIndent,
                      endIndent: 0,
                    ),
                    duration: kDefaultDuration,
                    lerp: DividerProperties.lerp,
                    builder: (context, value, child) {
                      return CustomPaint(
                        painter: VerticalDividerPainter(
                          color: value.color,
                          thickness: value.thickness,
                          indent: value.indent,
                          endIndent: value.endIndent,
                        ),
                      );
                    },
                  ),
                ),
              ),
              labeledChild,
              Expanded(
                child: SizedBox(
                  width: width ?? 1,
                  child: AnimatedValueBuilder(
                    value: DividerProperties(
                      color: color ?? theme.colorScheme.border,
                      thickness: thickness ?? 1,
                      indent: 0,
                      endIndent: mainAxisEndIndent,
                    ),
                    duration: kDefaultDuration,
                    lerp: DividerProperties.lerp,
                    builder: (context, value, child) {
                      return CustomPaint(
                        painter: VerticalDividerPainter(
                          color: value.color,
                          thickness: value.thickness,
                          indent: value.indent,
                          endIndent: value.endIndent,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: width ?? 1,
      height: double.infinity,
      child: AnimatedValueBuilder(
        value: DividerProperties(
          color: color ?? theme.colorScheme.border,
          thickness: thickness ?? 1,
          indent: mainAxisIndent,
          endIndent: mainAxisEndIndent,
        ),
        lerp: DividerProperties.lerp,
        duration: kDefaultDuration,
        builder: (context, value, child) {
          return CustomPaint(
            painter: VerticalDividerPainter(
              color: value.color,
              thickness: value.thickness,
              indent: value.indent,
              endIndent: value.endIndent,
            ),
          );
        },
      ),
    );
  }
}
