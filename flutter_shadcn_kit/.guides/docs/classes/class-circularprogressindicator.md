---
title: "Class: CircularProgressIndicator"
description: "Circular progress indicator with determinate/indeterminate modes and theming."
---

```dart
/// Circular progress indicator with determinate/indeterminate modes and theming.
class CircularProgressIndicator extends StatelessWidget {
  const CircularProgressIndicator({super.key, this.value, this.size, this.color, this.backgroundColor, this.strokeWidth, this.duration = kDefaultDuration, this.animated = true, this.onSurface = false});
  final double? value;
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final double? strokeWidth;
  final Duration duration;
  final bool animated;
  final bool onSurface;
  Widget build(BuildContext context);
}
```
