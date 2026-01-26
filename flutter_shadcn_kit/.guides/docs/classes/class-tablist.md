---
title: "Class: TabList"
description: "A horizontal tab list widget for selecting between multiple tab content areas."
---

```dart
/// A horizontal tab list widget for selecting between multiple tab content areas.
///
/// TabList provides a classic tab interface with a horizontal row of tab buttons
/// and an active tab indicator. It handles tab selection state and provides visual
/// feedback for the currently active tab through styling and an indicator line.
///
/// The widget automatically manages the appearance of tab buttons, applying
/// appropriate styling for active and inactive states. The active tab is
/// highlighted with foreground styling and the indicator line at the bottom.
///
/// Features:
/// - Horizontal row of selectable tab buttons
/// - Visual active tab indicator with customizable styling
/// - Automatic tab button state management (active/inactive)
/// - Theme-aware styling with customizable colors and dimensions
/// - Integration with TabContainer for coordinated tab management
///
/// The TabList works as part of a complete tab system, typically used with
/// corresponding content areas that show/hide based on the selected tab.
///
/// Example:
/// ```dart
/// TabList(
///   index: currentTabIndex,
///   onChanged: (index) => setState(() => currentTabIndex = index),
///   children: [
///     TabChild(child: Text('Tab 1')),
///     TabChild(child: Text('Tab 2')),
///     TabChild(child: Text('Tab 3')),
///   ],
/// )
/// ```
class TabList extends StatelessWidget {
  /// List of tab child widgets to display in the tab list.
  final List<TabChild> children;
  /// Index of the currently active/selected tab.
  final int index;
  /// Callback invoked when a tab is selected.
  final ValueChanged<int>? onChanged;
  /// Creates a [TabList] with horizontal tab selection.
  const TabList({super.key, required this.children, required this.index, required this.onChanged});
  Widget build(BuildContext context);
}
```
