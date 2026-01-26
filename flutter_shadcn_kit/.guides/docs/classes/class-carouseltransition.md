---
title: "Class: CarouselTransition"
description: "A carousel layout."
---

```dart
/// A carousel layout.
abstract class CarouselTransition {
  /// Creates a carousel layout.
  const CarouselTransition();
  /// Creates a sliding carousel layout.
  factory CarouselTransition.sliding({double gap});
  /// Creates a fading carousel layout.
  factory CarouselTransition.fading();
  /// Layouts the carousel items.
  List<Widget> layout(BuildContext context, {required double progress, required BoxConstraints constraints, required CarouselAlignment alignment, required Axis direction, required CarouselSizeConstraint sizeConstraint, required double progressedIndex, required int? itemCount, required CarouselItemBuilder itemBuilder, required bool wrap, required bool reverse});
}
```
