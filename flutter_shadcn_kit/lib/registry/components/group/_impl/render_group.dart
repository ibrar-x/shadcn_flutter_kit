part of '../group_widget.dart';

/// Render box that lays out its children by absolute offsets.
class RenderGroup extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, GroupParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, GroupParentData> {
  RenderGroup({List<RenderBox>? children}) {
    addAll(children);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! GroupParentData) {
      child.parentData = GroupParentData();
    }
  }

  @override
  void performLayout() {
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as GroupParentData;

      double? top = childParentData.top;
      double? left = childParentData.left;
      double? right = childParentData.right;
      double? bottom = childParentData.bottom;
      double? width = childParentData.width;
      double? height = childParentData.height;

      double offsetX = 0;
      double offsetY = 0;
      double childWidth = 0;
      double childHeight = 0;

      if (top != null && bottom != null) {
        offsetY = top;
        childHeight = constraints.maxHeight - (top + bottom);
      } else {
        if (top != null) {
          offsetY = top;
        } else if (bottom != null) {
          offsetY = constraints.maxHeight - bottom;
        }
        childHeight = height ?? constraints.maxHeight;
      }

      if (left != null && right != null) {
        offsetX = left;
        childWidth = constraints.maxWidth - (left + right);
      } else {
        if (left != null) {
          offsetX = left;
        } else if (right != null) {
          offsetX = constraints.maxWidth - right;
        }
        childWidth = width ?? constraints.maxWidth;
      }

      child.layout(
        BoxConstraints.tightFor(width: childWidth, height: childHeight),
        parentUsesSize: true,
      );

      if (top == null && bottom != null) {
        offsetY -= child.size.height;
      }
      if (left == null && right != null) {
        offsetX -= child.size.width;
      }

      childParentData.offset = Offset(offsetX, offsetY);
      child = childParentData.nextSibling;
    }
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as GroupParentData;
      context.paintChild(child, offset + childParentData.offset);
      child = childParentData.nextSibling;
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    var child = lastChild;
    while (child != null) {
      final childParentData = child.parentData! as GroupParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child!.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
      child = childParentData.previousSibling;
    }
    return false;
  }
}
