---
title: "Class: LinearProgressIndicator"
description: "Smooth determinate/indeterminate linear progress component with sparks."
---

```dart
/// Smooth determinate/indeterminate linear progress component with sparks.
class LinearProgressIndicator extends StatelessWidget {
  const LinearProgressIndicator({super.key, this.value, this.backgroundColor, this.minHeight, this.color, this.borderRadius, this.showSparks, this.disableAnimation});
  final double? value;
  final Color? backgroundColor;
  final double? minHeight;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final bool? showSparks;
  final bool? disableAnimation;
  Widget build(BuildContext context);
}
```
