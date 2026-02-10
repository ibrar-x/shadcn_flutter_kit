part of '../../group_widget.dart';

class GroupPositioned extends ParentDataWidget<GroupParentData> {
  /// Creates a [GroupPositioned].
  const GroupPositioned({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required super.child,
  });

  /// Creates a positioned child that fills the group bounds.
  const GroupPositioned.fill({
    super.key,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
    this.width,
    this.height,
    required super.child,
  });

  /// Creates a positioned child from the provided [rect].
  GroupPositioned.fromRect({
    super.key,
    required Rect rect,
    required super.child,
  }) : left = rect.left,
       top = rect.top,
       width = rect.width,
       height = rect.height,
       right = null,
       bottom = null;

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as GroupParentData;
    bool needsLayout = false;

    if (parentData.top != top) {
      parentData.top = top;
      needsLayout = true;
    }
    if (parentData.left != left) {
      parentData.left = left;
      needsLayout = true;
    }
    if (parentData.right != right) {
      parentData.right = right;
      needsLayout = true;
    }
    if (parentData.bottom != bottom) {
      parentData.bottom = bottom;
      needsLayout = true;
    }
    if (parentData.width != width) {
      parentData.width = width;
      needsLayout = true;
    }
    if (parentData.height != height) {
      parentData.height = height;
      needsLayout = true;
    }

    if (needsLayout) {
      final targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => GroupWidget;
}
