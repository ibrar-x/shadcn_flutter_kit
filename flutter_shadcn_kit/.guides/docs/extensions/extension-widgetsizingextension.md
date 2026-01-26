---
title: "Extension: WidgetSizingExtension"
description: "Extension providing sizing helpers for widgets."
---

```dart
/// Extension providing sizing helpers for widgets.
extension WidgetSizingExtension on Widget {
  /// Wraps this widget in a [SizedBox] with the requested dimensions.
  Widget sized({double? width, double? height});
  /// Wraps this widget in a [ConstrainedBox] with the requested constraints.
  Widget constrained({double? minWidth, double? maxWidth, double? minHeight, double? maxHeight, double? width, double? height});
}
```
