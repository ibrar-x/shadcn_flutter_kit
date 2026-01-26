---
title: "Class: GroupWidget"
description: "A manual layout surface for positioning children with explicit offsets."
---

```dart
/// A manual layout surface for positioning children with explicit offsets.
class GroupWidget extends MultiChildRenderObjectWidget {
  /// Creates a [GroupWidget].
  const GroupWidget({super.key, super.children});
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderGroup renderObject);
}
```
