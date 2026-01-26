---
title: "Class: ShadcnUI"
description: "A widget that applies shadcn text + icon styles to descendants."
---

```dart
/// A widget that applies shadcn text + icon styles to descendants.
class ShadcnUI extends StatelessWidget {
  const ShadcnUI({super.key, this.textStyle, required this.child});
  final TextStyle? textStyle;
  final Widget child;
  Widget build(BuildContext context);
}
```
