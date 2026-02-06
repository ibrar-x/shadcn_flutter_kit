part of '../../tooltip.dart';

/// Styled container widget for tooltip content.
class TooltipContainer extends StatelessWidget {
  final Widget child;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  const TooltipContainer({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    required this.child,
  });

  Widget call(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TooltipTheme>(context);
    Color resolvedColor = styleValue(
        widgetValue: backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: theme.colorScheme.primary);
    var resolvedOpacity = surfaceOpacity ?? compTheme?.surfaceOpacity;
    var resolvedBlur = surfaceBlur ?? compTheme?.surfaceBlur;
    if (resolvedOpacity != null) {
      resolvedColor = resolvedColor.scaleAlpha(resolvedOpacity);
    }
    final resolvedPadding = styleValue(
                widgetValue: padding,
                themeValue: compTheme?.padding,
                defaultValue:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6))
            .resolve(Directionality.of(context)) *
        scaling;
    final resolvedRadius = styleValue(
        widgetValue: borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.circular(theme.radiusSm));

    Widget container = Container(
      padding: resolvedPadding,
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: resolvedRadius,
      ),
      child: child.xSmall().primaryForeground(),
    );

    if (resolvedBlur != null && resolvedBlur > 0) {
      container = SurfaceBlur(
        surfaceBlur: resolvedBlur,
        borderRadius: resolvedRadius,
        child: container,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(6) * scaling,
      child: container,
    );
  }
}
