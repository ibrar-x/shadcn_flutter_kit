---
title: "Class: AxisAlignmentGeometry"
description: "Base class for axis alignments that can resolve based on [TextDirection]."
---

```dart
/// Base class for axis alignments that can resolve based on [TextDirection].
abstract class AxisAlignmentGeometry {
  /// Creates an [AxisAlignmentGeometry].
  const AxisAlignmentGeometry();
  /// Resolves this alignment to a concrete [AxisAlignment] for a specific direction.
  AxisAlignment resolve(TextDirection textDirection);
}
```
