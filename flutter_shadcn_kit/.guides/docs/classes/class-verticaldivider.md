---
title: "Class: VerticalDivider"
description: "Vertical line that divides horizontal layouts."
---

```dart
/// Vertical line that divides horizontal layouts.
class VerticalDivider extends StatelessWidget implements PreferredSizeWidget {
  const VerticalDivider({super.key, this.color, this.width, this.thickness, this.indent, this.endIndent, this.child, this.padding = const EdgeInsets.symmetric(vertical: 8)});
  final Color? color;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  Size get preferredSize;
  Widget build(BuildContext context);
}
```
