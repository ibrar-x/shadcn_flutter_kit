---
title: "Class: Hidden"
description: "Shows or hides a single child with optional animation along an axis."
---

```dart
/// Shows or hides a single child with optional animation along an axis.
class Hidden extends StatelessWidget {
  /// Creates a [Hidden] widget.
  const Hidden({super.key, required this.hidden, required this.child, this.direction, this.duration, this.curve, this.reverse, this.keepCrossAxisSize, this.keepMainAxisSize});
  /// Whether the child should be hidden.
  final bool hidden;
  /// The child that's shown or hidden.
  final Widget child;
  /// Axis used for slide animations.
  final Axis? direction;
  /// Duration of the animation.
  final Duration? duration;
  /// Curve applied to the animation.
  final Curve? curve;
  /// Reverse the animation direction.
  final bool? reverse;
  /// Preserve cross-axis size when hidden.
  final bool? keepCrossAxisSize;
  /// Preserve main-axis size when hidden.
  final bool? keepMainAxisSize;
  Widget build(BuildContext context);
}
```
