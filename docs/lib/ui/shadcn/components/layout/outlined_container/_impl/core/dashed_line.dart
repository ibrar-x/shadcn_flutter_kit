part of '../../outlined_container.dart';

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
