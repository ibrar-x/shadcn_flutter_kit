---
title: "Class: ConstrainedTableSize"
description: "Reference for ConstrainedTableSize"
---

```dart
class ConstrainedTableSize {
  /// Minimum allowed size. Defaults to negative infinity (no minimum).
  final double min;
  /// Maximum allowed size. Defaults to positive infinity (no maximum).
  final double max;
  /// Creates a [ConstrainedTableSize] with optional min and max values.
  const ConstrainedTableSize({this.min = double.negativeInfinity, this.max = double.infinity});
}
```
