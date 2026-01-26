---
title: "Class: MoreDots"
description: "Renders a configurable row or column of dots."
---

```dart
/// Renders a configurable row or column of dots.
class MoreDots extends StatelessWidget {
  final Axis direction;
  final int count;
  final double? size;
  final Color? color;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  const MoreDots({super.key, this.direction = Axis.horizontal, this.count = 3, this.size, this.color, this.spacing = 2, this.padding});
  Widget build(BuildContext context);
}
```
