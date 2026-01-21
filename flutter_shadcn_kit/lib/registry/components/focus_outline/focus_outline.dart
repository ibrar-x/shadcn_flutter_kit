import 'package:flutter/material.dart' hide Theme;

import '../../shared/primitives/animated_value_builder.dart';
import '../../shared/theme/theme.dart';
import '../../shared/utils/constants.dart';
import '../../shared/utils/style_value.dart';

/// Theme configuration for focus outlines.
class FocusOutlineTheme extends ComponentThemeData {
  /// Offset applied when drawing the outline.
  final double? align;

  /// Border radius for rounded outlines.
  final BorderRadiusGeometry? borderRadius;

  /// Border style used by the outline.
  final Border? border;

  /// Creates a theme for [FocusOutline].
  const FocusOutlineTheme({
    this.align,
    this.borderRadius,
    this.border,
  });

  /// Copies this theme with selected overrides.
  FocusOutlineTheme copyWith({
    ValueGetter<double?>? align,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<Border?>? border,
  }) {
    return FocusOutlineTheme(
      align: align == null ? this.align : align(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      border: border == null ? this.border : border(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FocusOutlineTheme &&
        other.align == align &&
        other.borderRadius == borderRadius &&
        other.border == border;
  }

  @override
  int get hashCode => Object.hash(align, borderRadius, border);
}

/// Draws a subtle outline around a focused widget.
class FocusOutline extends StatelessWidget {
  /// Creates a focus outline.
  const FocusOutline({
    super.key,
    required this.child,
    required this.focused,
    this.borderRadius,
    this.align,
    this.border,
    this.shape,
  });

  /// The wrapped child.
  final Widget child;

  /// Whether the focus outline is visible.
  final bool focused;

  /// Custom border radius.
  final BorderRadiusGeometry? borderRadius;

  /// Custom alignment offset.
  final double? align;

  /// Custom border style.
  final Border? border;

  /// Custom shape (rectangle or circle).
  final BoxShape? shape;

  BorderRadius _getAdjustedBorderRadius(
    TextDirection textDirection,
    double align,
    BorderRadiusGeometry? borderRadius,
  ) {
    final rawRadius = borderRadius;
    if (rawRadius == null) return BorderRadius.zero;
    final resolved = rawRadius.resolve(textDirection);
    final offset = Radius.circular(align);
    return BorderRadius.only(
      topLeft: resolved.topLeft + offset,
      topRight: resolved.topRight + offset,
      bottomLeft: resolved.bottomLeft + offset,
      bottomRight: resolved.bottomRight + offset,
    );
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<FocusOutlineTheme>(context);
    final theme = Theme.of(context);
    final effectiveAlign = styleValue(
      defaultValue: 3.0,
      themeValue: compTheme?.align,
      widgetValue: align,
    );
    final effectiveRadius = styleValue(
      themeValue: compTheme?.borderRadius,
      widgetValue: borderRadius,
      defaultValue: null,
    );
    final ringColor = theme.colorScheme.ring;
    final halfAlpha = ((ringColor.a * 255 * 0.5).round()).clamp(0, 255);
    final visibleRingColor = ringColor.withAlpha(halfAlpha);
    final effectiveBorder = styleValue(
      defaultValue: Border.all(
        color: visibleRingColor,
        width: 3.0,
      ),
      themeValue: compTheme?.border,
      widgetValue: border,
    );

    final offset = -effectiveAlign;
    final textDirection = Directionality.of(context);

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        child,
        AnimatedValueBuilder(
          value: focused ? 1.0 : 0.0,
          duration: kDefaultDuration,
          builder: (context, value, child) {
            return Positioned(
              top: offset * value,
              right: offset * value,
              bottom: offset * value,
              left: offset * value,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    border: effectiveBorder.scale(value),
                    shape: shape ?? BoxShape.rectangle,
                    borderRadius: shape != BoxShape.circle
                        ? _getAdjustedBorderRadius(
                            textDirection,
                            effectiveAlign,
                            effectiveRadius,
                          )
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
