part of '../../navigation_bar.dart';

class _NavigationLabeled extends StatelessWidget {
  final Widget child;
  final Widget label;
  final NavigationLabelPosition position;
  final double spacing;
  final bool showLabel;
  final NavigationLabelType labelType;
  final Axis direction;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;

  const _NavigationLabeled({
    required this.child,
    required this.label,
    required this.spacing,
    required this.position,
    required this.showLabel,
    required this.labelType,
    required this.direction,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
  });

  @override
  Widget build(BuildContext context) {
    var direction =
        position == NavigationLabelPosition.top ||
            position == NavigationLabelPosition.bottom
        ? Axis.vertical
        : Axis.horizontal;
    var animatedSize = Hidden(
      hidden: !showLabel,
      direction: direction,
      reverse:
          position == NavigationLabelPosition.start ||
          position == NavigationLabelPosition.top,
      keepCrossAxisSize: (this.direction != direction
          ? keepCrossAxisSize
          : keepMainAxisSize),
      keepMainAxisSize: (this.direction != direction
          ? keepMainAxisSize
          : keepCrossAxisSize),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: position == NavigationLabelPosition.bottom ? spacing : 0,
          bottom: position == NavigationLabelPosition.top ? spacing : 0,
          start: position == NavigationLabelPosition.end ? spacing : 0,
          end: position == NavigationLabelPosition.start ? spacing : 0,
        ),
        child: label,
      ),
    );
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Flex(
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (position == NavigationLabelPosition.start ||
                position == NavigationLabelPosition.top)
              Flexible(child: animatedSize),
            child,
            if (position == NavigationLabelPosition.end ||
                position == NavigationLabelPosition.bottom)
              Flexible(child: animatedSize),
          ],
        ),
      ),
    );
  }
}
