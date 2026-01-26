---
title: "Class: TabPaneTheme"
description: "Theme configuration for [TabPane] appearance and layout."
---

```dart
/// Theme configuration for [TabPane] appearance and layout.
///
/// TabPaneTheme defines the visual styling for tab pane components including
/// borders, background colors, dimensions, and corner rounding. All properties
/// are optional and fall back to theme defaults when not specified.
///
/// Example:
/// ```dart
/// ComponentTheme<TabPaneTheme>(
///   data: TabPaneTheme(
///     borderRadius: BorderRadius.circular(12),
///     backgroundColor: Colors.white,
///     border: BorderSide(color: Colors.grey),
///     barHeight: 40.0,
///   ),
///   child: TabPane(...),
/// )
/// ```
class TabPaneTheme extends ComponentThemeData {
  /// Border radius for the tab pane container and individual tabs.
  final BorderRadiusGeometry? borderRadius;
  /// Background color for the tab pane content area and active tabs.
  final Color? backgroundColor;
  /// Border styling for the tab pane container.
  final BorderSide? border;
  /// Height of the tab bar area in logical pixels.
  final double? barHeight;
  /// Creates a [TabPaneTheme].
  const TabPaneTheme({this.borderRadius, this.backgroundColor, this.border, this.barHeight});
  /// Creates a copy with specified fields replaced.
  TabPaneTheme copyWith({ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderSide?>? border, ValueGetter<double?>? barHeight});
  bool operator ==(Object other);
  int get hashCode;
}
```
