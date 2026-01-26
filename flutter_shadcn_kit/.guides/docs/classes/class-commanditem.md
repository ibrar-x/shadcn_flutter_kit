---
title: "Class: CommandItem"
description: "A single selectable command entry."
---

```dart
/// A single selectable command entry.
class CommandItem extends StatefulWidget {
  /// Optional leading widget (icon, etc.).
  final Widget? leading;
  /// Primary title for the command.
  final Widget title;
  /// Optional trailing widget (shortcut, badge).
  final Widget? trailing;
  /// Callback when the item is activated.
  final VoidCallback? onTap;
  /// Creates a command item.
  const CommandItem({super.key, this.leading, required this.title, this.trailing, this.onTap});
  State<CommandItem> createState();
}
```
