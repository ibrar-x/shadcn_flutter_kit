part of '../../divider.dart';

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
    this.childAlignment,
  });

  final Color? color;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final AxisAlignmentGeometry? childAlignment;

  @override
  Size get preferredSize => Size(width ?? 1, 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final resolvedChildAlignment =
        (childAlignment ?? AxisAlignment.center).resolve(textDirection);
    if (child != null) {
      final clampedAlignmentValue =
          resolvedChildAlignment.value.clamp(-1.0, 1.0);
      final topRatio = (clampedAlignmentValue + 1) / 2;
      final bottomRatio = 1 - topRatio;
      final topFlex = (topRatio * 1000).round();
      final bottomFlex = (bottomRatio * 1000).round();
      return SizedBox(
        height: double.infinity,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (topFlex > 0)
                Expanded(
                  flex: topFlex,
                  child: SizedBox(
                    width: width ?? 1,
                    child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: indent ?? 0,
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
                )
              else
                const SizedBox.shrink(),
              child!.muted().small().withPadding(padding: padding),
              if (bottomFlex > 0)
                Expanded(
                  flex: bottomFlex,
                  child: SizedBox(
                    width: width ?? 1,
                    child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: 0,
                        endIndent: endIndent ?? 0,
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
                )
              else
                const SizedBox.shrink(),
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
          indent: indent ?? 0,
          endIndent: endIndent ?? 0,
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
