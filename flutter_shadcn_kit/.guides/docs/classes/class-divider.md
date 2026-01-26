---
title: "Class: Divider"
description: "Horizontal line separating content with optional label."
---

```dart
/// Horizontal line separating content with optional label.
class Divider extends StatelessWidget implements PreferredSizeWidget {
  const Divider({super.key, this.color, this.height, this.thickness, this.indent, this.endIndent, this.child, this.padding});
  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  Size get preferredSize;
  Widget build(BuildContext context);
}
```
