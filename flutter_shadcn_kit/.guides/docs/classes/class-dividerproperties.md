---
title: "Class: DividerProperties"
description: "Immutable divider properties used for lerping transitions."
---

```dart
/// Immutable divider properties used for lerping transitions.
class DividerProperties {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;
  const DividerProperties({required this.color, required this.thickness, required this.indent, required this.endIndent});
  static DividerProperties lerp(DividerProperties? a, DividerProperties? b, double t);
}
```
