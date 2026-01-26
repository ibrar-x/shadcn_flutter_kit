---
title: "Class: AxisAlignmentDirectional"
description: "Directional axis alignment that resolves relative to text direction."
---

```dart
/// Directional axis alignment that resolves relative to text direction.
class AxisAlignmentDirectional extends AxisAlignmentGeometry {
  static const AxisAlignmentDirectional start = AxisAlignmentDirectional(-1.0);
  static const AxisAlignmentDirectional end = AxisAlignmentDirectional(1.0);
  static const AxisAlignmentDirectional center = AxisAlignmentDirectional(0.0);
  final double value;
  const AxisAlignmentDirectional(this.value);
  AxisAlignment resolve(TextDirection textDirection);
}
```
