part of '../../outlined_container.dart';

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
