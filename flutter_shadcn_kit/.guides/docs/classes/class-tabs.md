---
title: "Class: Tabs"
description: "Reference for Tabs"
---

```dart
class Tabs extends StatelessWidget {
  /// The index of the currently selected tab (0-indexed).
  ///
  /// Must be between 0 and `children.length - 1` inclusive.
  final int index;
  /// Used to expand children horizontally
  final bool expand;
  /// Callback invoked when the user selects a different tab.
  ///
  /// Called with the new tab index when the user taps a tab header.
  final ValueChanged<int> onChanged;
  /// List of tab children defining tab headers and content.
  ///
  /// Each [TabChild] contains a tab header widget and the associated
  /// content panel widget. The list must not be empty.
  final List<TabChild> children;
  /// Optional padding around individual tabs.
  ///
  /// Overrides the theme's tab padding if provided. If `null`,
  /// uses the padding from [TabsTheme].
  final EdgeInsetsGeometry? padding;
  /// Creates a tabs widget.
  ///
  /// Parameters:
  /// - [index]: Currently selected tab index (required)
  /// - [onChanged]: Tab selection callback (required)
  /// - [children]: List of tab children (required, non-empty)
  /// - [padding]: Custom tab padding (optional)
  const Tabs({super.key, required this.index, required this.onChanged, required this.children, this.padding, this.expand = false});
  Widget build(BuildContext context);
}
```
