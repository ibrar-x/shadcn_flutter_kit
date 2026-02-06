part of '../../hidden.dart';


class _HiddenLayoutRender extends RenderShiftedBox {
  bool keepCrossAxisSize;
  bool keepMainAxisSize;
  TextDirection textDirection;
  Axis direction;
  bool reverse;
  double progress;

  _HiddenLayoutRender({
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    RenderBox? child,
  }) : super(child);

  @override
  void performLayout() {
    if (child == null) {
      size = constraints.smallest;
      return;
    }

    child!.layout(constraints, parentUsesSize: true);
    final childSize = child!.size;

    var mainAxisSize = direction == Axis.horizontal ? childSize.width : childSize.height;
    var crossAxisSize = direction == Axis.horizontal ? childSize.height : childSize.width;

    final mainAxisProgress = keepMainAxisSize ? 1.0 : progress;
    final crossAxisProgress = keepCrossAxisSize ? 1.0 : progress;

    final constrainedMainAxis = mainAxisSize * mainAxisProgress;
    final constrainedCrossAxis = crossAxisSize * crossAxisProgress;

    final width = direction == Axis.horizontal ? constrainedMainAxis : constrainedCrossAxis;
    final height = direction == Axis.horizontal ? constrainedCrossAxis : constrainedMainAxis;

    size = constraints.constrain(Size(width, height));

    final alignment = direction == Axis.horizontal
        ? (textDirection == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight)
        : Alignment.topCenter;
    final offset = alignment.alongOffset(
      Offset(size.width - childSize.width, size.height - childSize.height),
    );
    final shift =
        reverse ? Offset(-offset.dx, -offset.dy) : Offset(offset.dx, offset.dy);
    (child!.parentData as BoxParentData).offset = shift;
  }
}
