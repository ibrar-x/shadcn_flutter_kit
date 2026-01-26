---
title: "Class: CollapsibleTheme"
description: "Theme data for collapsible widgets and triggers."
---

```dart
/// Theme data for collapsible widgets and triggers.
class CollapsibleTheme extends ComponentThemeData {
  /// Creates a theme for collapsible sections.
  const CollapsibleTheme({this.padding, this.iconExpanded, this.iconCollapsed, this.crossAxisAlignment, this.mainAxisAlignment, this.iconGap});
  /// Horizontal padding around the trigger row.
  final double? padding;
  /// Icon shown when expanded.
  final IconData? iconExpanded;
  /// Icon shown when collapsed.
  final IconData? iconCollapsed;
  /// Cross-axis alignment for the column of children.
  final CrossAxisAlignment? crossAxisAlignment;
  /// Main-axis alignment for the column of children.
  final MainAxisAlignment? mainAxisAlignment;
  /// Spacing between trigger children and the icon.
  final double? iconGap;
  /// Copies the theme with selected overrides.
  CollapsibleTheme copyWith({ValueGetter<double?>? padding, ValueGetter<IconData?>? iconExpanded, ValueGetter<IconData?>? iconCollapsed, ValueGetter<CrossAxisAlignment?>? crossAxisAlignment, ValueGetter<MainAxisAlignment?>? mainAxisAlignment, ValueGetter<double?>? iconGap});
  bool operator ==(Object other);
  int get hashCode;
}
```
