---
title: "Class: DotIndicator"
description: "Navigation indicator with a row/column of animated dots."
---

```dart
/// Navigation indicator with a row/column of animated dots.
class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, required this.index, required this.length, this.onChanged, this.spacing, this.direction = Axis.horizontal, this.padding, this.dotBuilder});
  final int index;
  final int length;
  final ValueChanged<int>? onChanged;
  final double? spacing;
  final Axis direction;
  final EdgeInsetsGeometry? padding;
  final DotBuilder? dotBuilder;
  Widget build(BuildContext context);
}
```
