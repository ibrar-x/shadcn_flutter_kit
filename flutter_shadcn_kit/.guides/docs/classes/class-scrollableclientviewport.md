---
title: "Class: ScrollableClientViewport"
description: "Viewport widget for [ScrollableClient] with two-dimensional scrolling."
---

```dart
/// Viewport widget for [ScrollableClient] with two-dimensional scrolling.
class ScrollableClientViewport extends TwoDimensionalViewport {
  /// Whether overscroll effects are enabled.
  final bool overscroll;
  /// Creates a [ScrollableClientViewport].
  const ScrollableClientViewport({super.key, required super.verticalOffset, required super.verticalAxisDirection, required super.horizontalOffset, required super.horizontalAxisDirection, required super.delegate, required super.mainAxis, super.cacheExtent, super.clipBehavior = Clip.hardEdge, required this.overscroll});
  RenderTwoDimensionalViewport createRenderObject(BuildContext context);
}
```
