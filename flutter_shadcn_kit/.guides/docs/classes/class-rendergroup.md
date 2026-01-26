---
title: "Class: RenderGroup"
description: "Render box that lays out its children by absolute offsets."
---

```dart
/// Render box that lays out its children by absolute offsets.
class RenderGroup extends RenderBox with ContainerRenderObjectMixin<RenderBox, GroupParentData>, RenderBoxContainerDefaultsMixin<RenderBox, GroupParentData> {
  RenderGroup({List<RenderBox>? children});
  void setupParentData(RenderBox child);
  void performLayout();
  void paint(PaintingContext context, Offset offset);
  bool hitTest(BoxHitTestResult result, {required Offset position});
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
}
```
