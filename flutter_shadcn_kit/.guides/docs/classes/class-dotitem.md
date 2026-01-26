---
title: "Class: DotItem"
description: "Common base for dots."
---

```dart
/// Common base for dots.
class DotItem extends StatelessWidget {
  const DotItem({super.key, this.size, this.color, this.borderRadius, this.borderColor, this.borderWidth});
  final double? size;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  Widget build(BuildContext context);
}
```
