part of '../../stage_container.dart';

class StageContainer extends StatelessWidget {
  /// The breakpoint strategy for determining container width.
  ///
  /// Defaults to [StageBreakpoint.defaultBreakpoints].
  final StageBreakpoint breakpoint;

  /// Builder function that receives context and calculated padding.
  ///
  /// The padding parameter accounts for responsive adjustments.
  final Widget Function(BuildContext context, EdgeInsets padding) builder;

  /// Base padding for the container.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 72)`.
  final EdgeInsets padding;

  /// Creates a [StageContainer].
  const StageContainer({
    super.key,
    this.breakpoint = StageBreakpoint.defaultBreakpoints,
    required this.builder,
    this.padding = const EdgeInsets.symmetric(horizontal: 72),
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<StageContainerTheme>(context);
    final StageBreakpoint breakpoint = compTheme?.breakpoint ?? this.breakpoint;
    final EdgeInsets padding = styleValue(
      defaultValue: this.padding,
      themeValue: compTheme?.padding,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        var size = constraints.maxWidth;
        double topPadding = padding.top;
        double bottomPadding = padding.bottom;
        double leftPadding = padding.left;
        double rightPadding = padding.right;
        if (size < breakpoint.minSize) {
          return builder(context, padding.copyWith(left: 0, right: 0));
        } else if (size > breakpoint.maxSize) {
          double remainingWidth = (size - breakpoint.maxSize) / 2;
          leftPadding += remainingWidth;
          rightPadding += remainingWidth;
          leftPadding = max(0, leftPadding);
          rightPadding = max(0, rightPadding);
          return builder(
            context,
            EdgeInsets.only(
              top: topPadding,
              bottom: bottomPadding,
              left: leftPadding,
              right: rightPadding,
            ),
          );
        }
        double minWidth = breakpoint.getMinWidth(size);
        double maxWidth = breakpoint.getMaxWidth(size);
        assert(
          minWidth <= maxWidth,
          'minWidth must be less than or equal to maxWidth ($minWidth > $maxWidth)',
        );
        double remainingWidth = (size - minWidth) / 2;
        leftPadding += remainingWidth;
        rightPadding += remainingWidth;
        leftPadding = max(0, leftPadding);
        rightPadding = max(0, rightPadding);
        return builder(
          context,
          EdgeInsets.only(
            top: topPadding,
            bottom: bottomPadding,
            left: leftPadding,
            right: rightPadding,
          ),
        );
      },
    );
  }
}
