part of '../../dot_indicator.dart';

/// Inactive dot with optional border.
class InactiveDotItem extends StatelessWidget {
  const InactiveDotItem({
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
    final resolvedColor = color ?? compTheme?.inactiveColor;
    final resolvedBorderRadius = styleValue(
      widgetValue: borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: theme.radiusMd,
    );
    final resolvedBorderColor =
        borderColor ??
        compTheme?.inactiveBorderColor ??
        theme.colorScheme.secondary;
    final resolvedBorderWidth =
        borderWidth ?? compTheme?.inactiveBorderWidth ?? (2 * scaling);
    return Container(
      width: resolvedSize,
      height: resolvedSize,
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: BorderRadius.circular(resolvedBorderRadius),
        border: Border.all(
          color: resolvedBorderColor,
          width: resolvedBorderWidth,
        ),
      ),
    );
  }
}
