---
title: "Class: FocusOutline"
description: "Draws a subtle outline around a focused widget."
---

```dart
/// Draws a subtle outline around a focused widget.
class FocusOutline extends StatelessWidget {
  /// Creates a focus outline.
  const FocusOutline({super.key, required this.child, required this.focused, this.borderRadius, this.align, this.border, this.shape});
  /// The wrapped child.
  final Widget child;
  /// Whether the focus outline is visible.
  final bool focused;
  /// Custom border radius.
  final BorderRadiusGeometry? borderRadius;
  /// Custom alignment offset.
  final double? align;
  /// Custom border style.
  final Border? border;
  /// Custom shape (rectangle or circle).
  final BoxShape? shape;
  Widget build(BuildContext context);
}
```
