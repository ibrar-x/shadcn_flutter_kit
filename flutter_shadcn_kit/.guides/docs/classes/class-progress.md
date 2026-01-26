---
title: "Class: Progress"
description: "Normalized progress indicator that respects theme defaults."
---

```dart
/// Normalized progress indicator that respects theme defaults.
class Progress extends StatelessWidget {
  const Progress({super.key, this.progress, this.min = 0.0, this.max = 1.0, this.color, this.backgroundColor});
  final double? progress;
  final double min;
  final double max;
  final Color? color;
  final Color? backgroundColor;
  double? get normalizedValue;
  Widget build(BuildContext context);
}
```
