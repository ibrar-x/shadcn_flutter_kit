---
title: "Class: KeyboardDisplay"
description: "A widget that displays keyboard shortcuts in a visually appealing format."
---

```dart
/// A widget that displays keyboard shortcuts in a visually appealing format.
///
/// Renders keyboard key combinations as styled keyboard key representations,
/// typically used in tooltips, help text, or UI elements that need to
/// communicate keyboard shortcuts to users.
class KeyboardDisplay extends StatelessWidget {
  /// Spacing between individual keyboard key displays.
  ///
  /// Controls the horizontal gap between adjacent key representations.
  /// When null, uses theme-appropriate default spacing.
  final double? spacing;
  /// Creates a [KeyboardDisplay] from a list of keyboard keys.
  const KeyboardDisplay({super.key, required List<LogicalKeyboardKey> keys, this.spacing});
  /// Creates a [KeyboardDisplay] from a shortcut activator.
  const KeyboardDisplay.fromActivator({super.key, required ShortcutActivator activator, this.spacing});
  Widget build(BuildContext context);
}
```
