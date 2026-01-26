---
title: "Class: MediaQueryVisibility"
description: "A widget that conditionally displays children based on media query constraints."
---

```dart
/// A widget that conditionally displays children based on media query constraints.
class MediaQueryVisibility extends StatelessWidget {
  /// Minimum screen width to show [child].
  final double? minWidth;
  /// Maximum screen width to show [child].
  final double? maxWidth;
  /// Widget to display when width is within range.
  final Widget child;
  /// Widget to display when width is outside range.
  final Widget? alternateChild;
  /// Creates a [MediaQueryVisibility].
  const MediaQueryVisibility({super.key, this.minWidth, this.maxWidth, required this.child, this.alternateChild});
  Widget build(BuildContext context);
}
```
