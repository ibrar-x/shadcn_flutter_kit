---
title: "Class: GroupPositioned"
description: "Places a child inside a [GroupWidget] at precise coordinates."
---

```dart
/// Places a child inside a [GroupWidget] at precise coordinates.
class GroupPositioned extends ParentDataWidget<GroupParentData> {
  /// Creates a [GroupPositioned].
  const GroupPositioned({super.key, this.top, this.left, this.right, this.bottom, this.width, this.height, required super.child});
  /// Creates a positioned child that fills the group bounds.
  const GroupPositioned.fill({super.key, this.top = 0, this.left = 0, this.right = 0, this.bottom = 0, this.width, this.height, required super.child});
  /// Creates a positioned child from the provided [rect].
  GroupPositioned.fromRect({super.key, required Rect rect, required super.child});
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
