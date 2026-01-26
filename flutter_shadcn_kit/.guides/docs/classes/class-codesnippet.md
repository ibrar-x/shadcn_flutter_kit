---
title: "Class: CodeSnippet"
description: "Syntax highlighted code display with optional actions."
---

```dart
/// Syntax highlighted code display with optional actions.
class CodeSnippet extends StatefulWidget {
  /// Constraints applied to the snippet area.
  final BoxConstraints? constraints;
  /// Additional action buttons rendered in the top-right corner.
  final List<Widget> actions;
  /// The widget that renders the code content (typically [Text]).
  final Widget code;
  /// Creates a code snippet display.
  const CodeSnippet({super.key, this.constraints, this.actions = const [], required this.code});
  State<CodeSnippet> createState();
}
```
