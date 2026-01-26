part of '../hidden.dart';

class _HiddenLayout extends SingleChildRenderObjectWidget {
  const _HiddenLayout({
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
    super.child,
  });

  final TextDirection textDirection;
  final Axis direction;
  final bool reverse;
  final double progress;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderHiddenLayout(
      textDirection: textDirection,
      direction: direction,
      reverse: reverse,
      progress: progress,
      keepCrossAxisSize: keepCrossAxisSize,
      keepMainAxisSize: keepMainAxisSize,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderHiddenLayout renderObject,
  ) {
    bool needsLayout = false;
    if (renderObject.textDirection != textDirection) {
      renderObject.textDirection = textDirection;
      needsLayout = true;
    }
    if (renderObject.direction != direction) {
      renderObject.direction = direction;
      needsLayout = true;
    }
    if (renderObject.reverse != reverse) {
      renderObject.reverse = reverse;
      needsLayout = true;
    }
    if (renderObject.progress != progress) {
      renderObject.progress = progress;
      needsLayout = true;
    }
    if (renderObject.keepCrossAxisSize != keepCrossAxisSize) {
      renderObject.keepCrossAxisSize = keepCrossAxisSize;
      needsLayout = true;
    }
    if (renderObject.keepMainAxisSize != keepMainAxisSize) {
      renderObject.keepMainAxisSize = keepMainAxisSize;
      needsLayout = true;
    }
    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }
}

class _RenderHiddenLayout extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  TextDirection textDirection;
  Axis direction;
  bool reverse;
  double progress;
  bool keepCrossAxisSize;
  bool keepMainAxisSize;

  _RenderHiddenLayout({
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
  });

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsicHeight(
      (RenderBox child, double width) => child.getMaxIntrinsicHeight(width),
      width,
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicWidth(
      (RenderBox child, double height) => child.getMaxIntrinsicWidth(height),
      height,
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsicHeight(
      (RenderBox child, double width) => child.getMinIntrinsicHeight(width),
      width,
    );
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicWidth(
      (RenderBox child, double height) => child.getMinIntrinsicWidth(height),
      height,
    );
  }

  double _computeIntrinsicWidth(
    double Function(RenderBox child, double height) childWidth,
    double height,
  ) {
    final child = this.child;
    if (child == null) {
      return 0;
    }
    final width = childWidth(child, height);
    if ((keepMainAxisSize && direction != Axis.vertical) ||
        (keepCrossAxisSize && direction != Axis.horizontal)) {
      return width;
    }
    return width * progress;
  }

  double _computeIntrinsicHeight(
    double Function(RenderBox child, double width) childHeight,
    double width,
  ) {
    final child = this.child;
    if (child == null) {
      return 0;
    }
    final height = childHeight(child, width);
    if ((keepMainAxisSize && direction != Axis.horizontal) ||
        (keepCrossAxisSize && direction != Axis.vertical)) {
      return height;
    }
    return height * progress;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) {
      final parentData = child.parentData as BoxParentData;
      context.paintChild(child, offset + parentData.offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final child = this.child;
    if (child == null) return false;
    final parentData = child.parentData as BoxParentData;
    return result.addWithPaintOffset(
      offset: parentData.offset,
      position: position,
      hitTest: (result, transformed) {
        return child.hitTest(result, position: transformed);
      },
    );
  }

  @override
  void performLayout() {
    final child = this.child;
    if (child == null) {
      size = constraints.biggest;
      return;
    }
    child.layout(constraints, parentUsesSize: true);
    final childSize = constraints.constrain(child.size);
    double width = childSize.width;
    double height = childSize.height;

    if (!keepMainAxisSize) {
      if (direction == Axis.horizontal) {
        width = width * progress;
      } else {
        height = height * progress;
      }
    }
    if (!keepCrossAxisSize) {
      if (direction == Axis.horizontal) {
        height = height * progress;
      } else {
        width = width * progress;
      }
    }

    child.parentData = (child.parentData as BoxParentData)
      ..offset = Offset(
        reverse ? constraints.maxWidth - width : 0,
        reverse ? constraints.maxHeight - height : 0,
      );

    size = constraints.constrain(Size(width, height));
  }
}
