---
title: "Class: ChipButton"
description: "Specialized button for inside chips."
---

```dart
/// Specialized button for inside chips.
class ChipButton extends StatelessWidget {
  const ChipButton({super.key, required this.child, this.onPressed});
  final Widget child;
  final VoidCallback? onPressed;
  Widget build(BuildContext context);
}
```
