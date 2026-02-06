# Clickable

Low-level gesture surface that provides state-aware styling, focus handling,
hover detection, and built-in controller hooks.

Use `Clickable` when you need fine-grained control over interactive
states (pressed, hovered, focused, selected) and want to centralize
mouse/keyboard semantics, focus outlines, and animated transitions.

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/clickable/clickable.dart';

Clickable(
  onPressed: () {},
  decoration: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return BoxDecoration(color: Colors.blue.shade700);
    }
    return BoxDecoration(color: Colors.blue);
  }),
  child: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Clickable'),
  ),
);
```
