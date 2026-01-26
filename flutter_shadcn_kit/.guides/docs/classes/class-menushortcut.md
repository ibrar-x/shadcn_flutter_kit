---
title: "Class: MenuShortcut"
description: "Reference for MenuShortcut"
---

```dart
class MenuShortcut extends StatelessWidget {
  /// The keyboard shortcut to display.
  final ShortcutActivator activator;
  /// Widget to display between multiple keys.
  final Widget? combiner;
  /// Creates a [MenuShortcut].
  ///
  /// Parameters:
  /// - [activator] (`ShortcutActivator`, required): The shortcut to display.
  /// - [combiner] (`Widget?`, optional): Separator between keys (default: " + ").
  const MenuShortcut({super.key, required this.activator, this.combiner});
  Widget build(BuildContext context);
}
```
