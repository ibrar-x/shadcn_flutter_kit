---
title: "Class: Chip"
description: "Compact interactive chip with optional leading/trailing widgets."
---

```dart
/// Compact interactive chip with optional leading/trailing widgets.
class Chip extends StatelessWidget {
  const Chip({super.key, required this.child, this.leading, this.trailing, this.onPressed, this.style});
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final AbstractButtonStyle? style;
  Widget build(BuildContext context);
}
```
