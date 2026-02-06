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
