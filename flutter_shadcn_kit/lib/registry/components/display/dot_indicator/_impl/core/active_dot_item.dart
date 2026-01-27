part of '../../dot_indicator.dart';

/// Active indicator dot.
class ActiveDotItem extends StatelessWidget {
  const ActiveDotItem({
    super.key,
    this.size,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  final double? size;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<DotIndicatorTheme>(context);
    final scaling = theme.scaling;
    final resolvedSize = styleValue(
      widgetValue: size,
      themeValue: compTheme?.size,
      defaultValue: 12 * scaling,
    );
    final resolvedColor = styleValue(
      widgetValue: color,
      themeValue: compTheme?.activeColor,
      defaultValue: theme.colorScheme.primary,
    );
    final resolvedBorderRadius = styleValue(
      widgetValue: borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: theme.radiusMd,
    );
    final resolvedBorderColor = borderColor;
    final resolvedBorderWidth = borderWidth;
    return Container(
      width: resolvedSize,
      height: resolvedSize,
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: BorderRadius.circular(resolvedBorderRadius),
        border: resolvedBorderColor != null && resolvedBorderWidth != null
            ? Border.all(color: resolvedBorderColor, width: resolvedBorderWidth)
            : null,
      ),
    );
  }
}
