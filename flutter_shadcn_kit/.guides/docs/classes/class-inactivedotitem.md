---
title: "Class: InactiveDotItem"
description: "Inactive dot with optional border."
---

```dart
/// Inactive dot with optional border.
class InactiveDotItem extends StatelessWidget {
  const InactiveDotItem({super.key, this.size, this.color, this.borderRadius, this.borderColor, this.borderWidth});
  final double? size;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  Widget build(BuildContext context);
}
```
