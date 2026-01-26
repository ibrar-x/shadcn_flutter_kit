---
title: "Class: TabListTheme"
description: "Theme configuration for [TabList] appearance and behavior."
---

```dart
/// Theme configuration for [TabList] appearance and behavior.
///
/// TabListTheme defines the visual styling for tab list components including
/// border colors, indicator styling, and dimensional properties. All properties
/// are optional and fall back to theme defaults when not specified.
///
/// Example:
/// ```dart
/// ComponentTheme<TabListTheme>(
///   data: TabListTheme(
///     borderColor: Colors.grey,
///     borderWidth: 2.0,
///     indicatorColor: Colors.blue,
///     indicatorHeight: 3.0,
///   ),
///   child: TabList(...),
/// )
/// ```
class TabListTheme extends ComponentThemeData {
  /// Color of the bottom border line separating tabs from content.
  final Color? borderColor;
  /// Width of the bottom border line in logical pixels.
  final double? borderWidth;
  /// Color of the active tab indicator line.
  final Color? indicatorColor;
  /// Height of the active tab indicator line in logical pixels.
  final double? indicatorHeight;
  /// Creates a [TabListTheme].
  const TabListTheme({this.borderColor, this.borderWidth, this.indicatorColor, this.indicatorHeight});
  /// Creates a copy with specified fields replaced.
  TabListTheme copyWith({ValueGetter<Color?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<Color?>? indicatorColor, ValueGetter<double?>? indicatorHeight});
  bool operator ==(Object other);
  int get hashCode;
}
```
