---
title: "Class: Collapsible"
description: "Expandable layout that keeps its own open/close state by default."
---

```dart
/// Expandable layout that keeps its own open/close state by default.
class Collapsible extends StatefulWidget {
  /// Creates a widget that expands/collapses a set of children.
  const Collapsible({super.key, required this.children, this.isExpanded, this.onExpansionChanged});
  /// Children are usually a trigger followed by one or more content widgets.
  final List<Widget> children;
  /// Controls the initial expansion for uncontrolled mode.
  final bool? isExpanded;
  /// Called when the user toggles the collapse state.
  final ValueChanged<bool>? onExpansionChanged;
  State<Collapsible> createState();
}
```
