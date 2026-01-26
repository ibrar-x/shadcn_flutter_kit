import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import '../utils/border_utils.dart';
import '../utils/color_extensions.dart';
import '../utils/style_value.dart';

/// A widget that applies a blur effect to its background.
class SurfaceBlur extends StatefulWidget {
  /// The child widget to display with blurred background.
  final Widget child;

  /// The amount of blur to apply (sigma value for blur filter).
  final double? surfaceBlur;

  /// Border radius for clipping the blur effect.
  final BorderRadiusGeometry? borderRadius;

  const SurfaceBlur({
    super.key,
    required this.child,
    this.surfaceBlur,
    this.borderRadius,
  });

  @override
  State<SurfaceBlur> createState() => _SurfaceBlurState();
}

class _SurfaceBlurState extends State<SurfaceBlur> {
  final GlobalKey _mainContainerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (widget.surfaceBlur == null || widget.surfaceBlur! <= 0) {
      return KeyedSubtree(key: _mainContainerKey, child: widget.child);
    }
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.surfaceBlur!,
                sigmaY: widget.surfaceBlur!,
              ),
              child: const SizedBox(),
            ),
          ),
        ),
        KeyedSubtree(key: _mainContainerKey, child: widget.child),
      ],
    );
  }
}

/// Theme configuration for [OutlinedContainer] appearance.
class OutlinedContainerTheme extends ComponentThemeData {
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final BorderStyle? borderStyle;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const OutlinedContainerTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderStyle,
    this.borderWidth,
    this.boxShadow,
    this.padding,
    this.surfaceOpacity,
    this.surfaceBlur,
  });
}

/// A container widget with customizable border and surface effects.
class OutlinedContainer extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final BorderStyle? borderStyle;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final double? width;
  final double? height;
  final Duration? duration;

  const OutlinedContainer({
    super.key,
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.clipBehavior = Clip.antiAlias,
    this.borderRadius,
    this.borderStyle,
    this.borderWidth,
    this.boxShadow,
    this.padding,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.width,
    this.height,
    this.duration,
  });

  @override
  State<OutlinedContainer> createState() => _OutlinedContainerState();
}

class _OutlinedContainerState extends State<OutlinedContainer> {
  final GlobalKey _mainContainerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<OutlinedContainerTheme>(context);
    final borderRadius = styleValue(
      defaultValue: theme.borderRadiusXl,
      themeValue: compTheme?.borderRadius,
      widgetValue: widget.borderRadius,
    ).resolve(Directionality.of(context));
    var backgroundColor = styleValue(
      defaultValue: theme.colorScheme.background,
      themeValue: compTheme?.backgroundColor,
      widgetValue: widget.backgroundColor,
    );
    final double? surfaceOpacity = styleValue(
      themeValue: compTheme?.surfaceOpacity,
      widgetValue: widget.surfaceOpacity,
      defaultValue: null,
    );
    if (surfaceOpacity != null) {
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    final borderColor = styleValue(
      defaultValue: theme.colorScheme.muted,
      themeValue: compTheme?.borderColor,
      widgetValue: widget.borderColor,
    );
    final borderWidth = styleValue(
      defaultValue: 1 * scaling,
      themeValue: compTheme?.borderWidth,
      widgetValue: widget.borderWidth,
    );
    final borderStyle = styleValue<BorderStyle>(
      defaultValue: BorderStyle.solid,
      themeValue: compTheme?.borderStyle,
      widgetValue: widget.borderStyle,
    );
    final boxShadow = styleValue<List<BoxShadow>>(
      themeValue: compTheme?.boxShadow,
      widgetValue: widget.boxShadow,
      defaultValue: [],
    );
    final padding = styleValue<EdgeInsetsGeometry>(
      themeValue: compTheme?.padding,
      widgetValue: widget.padding,
      defaultValue: EdgeInsets.zero,
    );
    final surfaceBlur = styleValue<double?>(
      themeValue: compTheme?.surfaceBlur,
      widgetValue: widget.surfaceBlur,
      defaultValue: null,
    );
    Widget childWidget = AnimatedContainer(
      duration: widget.duration ?? Duration.zero,
      key: _mainContainerKey,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
          style: borderStyle,
        ),
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: AnimatedContainer(
        duration: widget.duration ?? Duration.zero,
        padding: padding,
        clipBehavior: widget.clipBehavior,
        decoration: BoxDecoration(
          borderRadius: subtractByBorder(borderRadius, borderWidth),
        ),
        child: widget.child,
      ),
    );
    if (surfaceBlur != null && surfaceBlur > 0) {
      childWidget = SurfaceBlur(
        surfaceBlur: surfaceBlur,
        borderRadius: subtractByBorder(borderRadius, borderWidth),
        child: childWidget,
      );
    }
    return childWidget;
  }
}
