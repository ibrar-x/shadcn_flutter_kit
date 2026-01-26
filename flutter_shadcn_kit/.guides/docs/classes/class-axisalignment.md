---
title: "Class: AxisAlignment"
description: "Alignment along a single axis, compatible with [AxisAlignmentGeometry]."
---

```dart
/// Alignment along a single axis, compatible with [AxisAlignmentGeometry].
class AxisAlignment extends AxisAlignmentGeometry {
  static const AxisAlignment left = AxisAlignment(-1.0);
  static const AxisAlignment right = AxisAlignment(1.0);
  static const AxisAlignment center = AxisAlignment(0.0);
  final TextDirection? direction;
  final double value;
  const AxisAlignment(this.value);
  /// Returns the resolved alignment value for the provided [axis].
  double resolveValue(Axis axis);
  /// Positions a child within a span of [size] using this alignment.
  double alongValue(Axis axis, double size);
  /// Converts this axis alignment to an [Alignment] using the provided horizontal value.
  Alignment asHorizontalAlignment(AxisAlignment crossAxisAlignment);
  /// Converts this axis alignment to an [Alignment] using the provided vertical value.
  Alignment asVerticalAlignment(AxisAlignment crossAxisAlignment);
  AxisAlignment resolve(TextDirection textDirection);
}
```
