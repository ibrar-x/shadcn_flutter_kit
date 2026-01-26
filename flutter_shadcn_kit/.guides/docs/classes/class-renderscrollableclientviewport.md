---
title: "Class: RenderScrollableClientViewport"
description: "Render object for [ScrollableClientViewport]."
---

```dart
/// Render object for [ScrollableClientViewport].
class RenderScrollableClientViewport extends RenderTwoDimensionalViewport {
  /// Whether overscroll effects are enabled.
  final bool overscroll;
  /// Creates a [RenderScrollableClientViewport].
  RenderScrollableClientViewport({required super.horizontalOffset, required super.horizontalAxisDirection, required super.verticalOffset, required super.verticalAxisDirection, required super.delegate, required super.mainAxis, required super.childManager, super.cacheExtent, super.clipBehavior = Clip.hardEdge, required this.overscroll});
  void layoutChildSequence();
}
```
