---
title: "Class: Spinner"
description: "Shared spinner base class with color and size resolution helpers."
---

```dart
/// Shared spinner base class with color and size resolution helpers.
abstract class Spinner extends StatelessWidget {
  /// Optional color override.
  final Color? color;
  /// Optional size override.
  final double? size;
  const Spinner({super.key, this.color, this.size});
  Color? resolveColor(BuildContext context);
  double resolveSize(BuildContext context, double defaultValue);
}
```
