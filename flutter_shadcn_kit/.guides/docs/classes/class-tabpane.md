---
title: "Class: TabPane"
description: "A comprehensive tab pane widget with sortable tabs and integrated content display."
---

```dart
/// A comprehensive tab pane widget with sortable tabs and integrated content display.
///
/// TabPane provides a complete tab interface that combines a sortable tab bar with
/// a content display area. It supports drag-and-drop reordering of tabs, scrollable
/// tab overflow, and customizable leading/trailing elements in the tab bar.
///
/// The widget manages both the tab selection state and the tab ordering, providing
/// callbacks for both focus changes and sort operations. The tab bar is horizontally
/// scrollable when tabs exceed the available width, with fade effects at the edges.
///
/// Features:
/// - Drag-and-drop sortable tabs with visual feedback
/// - Horizontal scrolling with edge fade effects for tab overflow
/// - Integrated content area with customizable styling
/// - Leading and trailing widget support in the tab bar
/// - Custom tab rendering through builder patterns
/// - Comprehensive theming and styling options
/// - Automatic focus management during sorting operations
///
/// The content area is styled as a card-like container that appears above the
/// tab bar, creating a cohesive tabbed interface suitable for complex applications.
///
/// Example:
/// ```dart
/// TabPane<String>(
///   items: [
///     TabPaneData('tab1'),
///     TabPaneData('tab2'),
///     TabPaneData('tab3'),
///   ],
///   focused: currentTab,
///   onFocused: (index) => setState(() => currentTab = index),
///   onSort: (newOrder) => setState(() => tabOrder = newOrder),
///   itemBuilder: (context, item, index) => TabChild(
///     child: Text(item.data),
///   ),
///   child: IndexedStack(
///     index: currentTab,
///     children: tabContent,
///   ),
/// )
/// ```
class TabPane<T> extends StatefulWidget {
  /// List of tab data items to display in the tab pane.
  final List<TabPaneData<T>> items;
  /// Builder function to create tab child widgets from data items.
  final TabPaneItemBuilder<T> itemBuilder;
  /// Callback invoked when tabs are reordered through drag-and-drop.
  final ValueChanged<List<TabPaneData<T>>>? onSort;
  /// Index of the currently focused/selected tab.
  final int focused;
  /// Callback invoked when the focused tab changes.
  final ValueChanged<int> onFocused;
  /// Widgets displayed at the leading edge of the tab bar.
  final List<Widget> leading;
  /// Widgets displayed at the trailing edge of the tab bar.
  final List<Widget> trailing;
  /// Border radius for the tab pane container.
  final BorderRadiusGeometry? borderRadius;
  /// Background color for the content area and active tabs.
  final Color? backgroundColor;
  /// Border styling for the tab pane container.
  final BorderSide? border;
  /// The main content widget displayed in the content area.
  final Widget child;
  /// Height of the tab bar area in logical pixels.
  final double? barHeight;
  /// Creates a [TabPane] with sortable tabs and integrated content display.
  const TabPane({super.key, required this.items, required this.itemBuilder, this.focused = 0, required this.onFocused, this.leading = const [], this.trailing = const [], this.borderRadius, this.backgroundColor, this.border, this.onSort, required this.child, this.barHeight});
  State<TabPane<T>> createState();
}
```
