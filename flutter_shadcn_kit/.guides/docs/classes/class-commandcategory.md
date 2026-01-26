---
title: "Class: CommandCategory"
description: "Groups command items under an optional heading."
---

```dart
/// Groups command items under an optional heading.
class CommandCategory extends StatelessWidget {
  /// Creates a command category.
  const CommandCategory({super.key, required this.children, this.title});
  /// Items belonging to this category.
  final List<Widget> children;
  /// Optional header.
  final Widget? title;
  Widget build(BuildContext context);
}
```
