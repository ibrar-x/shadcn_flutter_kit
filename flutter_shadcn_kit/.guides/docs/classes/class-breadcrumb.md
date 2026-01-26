---
title: "Class: Breadcrumb"
description: "Navigation breadcrumb trail showing hierarchical path with customizable separators."
---

```dart
/// Navigation breadcrumb trail showing hierarchical path with customizable separators.
class Breadcrumb extends StatelessWidget {
  /// Arrow separator (>).
  static const Widget arrowSeparator = _ArrowSeparator();
  /// Slash separator (/).
  static const Widget slashSeparator = _SlashSeparator();
  /// The breadcrumb items rendered from root to current location.
  final List<Widget> children;
  /// Separator inserted between items.
  final Widget? separator;
  /// Padding around the breadcrumb strip.
  final EdgeInsetsGeometry? padding;
  /// Creates a breadcrumb navigation row.
  const Breadcrumb({super.key, required this.children, this.separator, this.padding});
  Widget build(BuildContext context);
}
```
