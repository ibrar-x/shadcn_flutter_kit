---
title: "Class: CollapsibleContent"
description: "Holder for the collapsible child content."
---

```dart
/// Holder for the collapsible child content.
class CollapsibleContent extends StatelessWidget {
  /// Creates a content pane for [Collapsible].
  const CollapsibleContent({super.key, this.collapsible = true, required this.child});
  /// Whether this pane should respect the expansion state.
  final bool collapsible;
  /// Inner widget that is shown or hidden.
  final Widget child;
  Widget build(BuildContext context);
}
```
