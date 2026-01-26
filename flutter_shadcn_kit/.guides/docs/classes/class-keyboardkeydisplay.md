---
title: "Class: KeyboardKeyDisplay"
description: "A widget that displays a single keyboard key in a styled format."
---

```dart
/// A widget that displays a single keyboard key in a styled format.
class KeyboardKeyDisplay extends StatelessWidget {
  /// The keyboard key to display.
  final LogicalKeyboardKey keyboardKey;
  /// Internal padding applied within the key display.
  final EdgeInsetsGeometry? padding;
  /// Box shadows applied to the key display for depth effect.
  final List<BoxShadow>? boxShadow;
  /// Creates a [KeyboardKeyDisplay] for the specified keyboard key.
  const KeyboardKeyDisplay({super.key, required this.keyboardKey, this.padding, this.boxShadow});
  Widget build(BuildContext context);
}
```
