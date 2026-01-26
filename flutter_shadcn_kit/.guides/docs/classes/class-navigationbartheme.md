---
title: "Class: NavigationBarTheme"
description: "Theme data for customizing [NavigationBar] widget appearance."
---

```dart
/// Theme data for customizing [NavigationBar] widget appearance.
class NavigationBarTheme extends ComponentThemeData {
  /// Background color of the navigation bar.
  final Color? backgroundColor;
  /// Alignment of navigation items.
  final NavigationBarAlignment? alignment;
  /// Layout direction (horizontal or vertical).
  final Axis? direction;
  /// Spacing between navigation items.
  final double? spacing;
  /// Type of label display (e.g., always show, hide, etc.).
  final NavigationLabelType? labelType;
  /// Position of labels relative to icons.
  final NavigationLabelPosition? labelPosition;
  /// Size variant for labels.
  final NavigationLabelSize? labelSize;
  /// Internal padding of the navigation bar.
  final EdgeInsetsGeometry? padding;
  /// Creates a [NavigationBarTheme].
  const NavigationBarTheme({this.backgroundColor, this.alignment, this.direction, this.spacing, this.labelType, this.labelPosition, this.labelSize, this.padding});
  /// Creates a copy of this theme with the given fields replaced.
  NavigationBarTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<NavigationBarAlignment?>? alignment, ValueGetter<Axis?>? direction, ValueGetter<double?>? spacing, ValueGetter<NavigationLabelType?>? labelType, ValueGetter<NavigationLabelPosition?>? labelPosition, ValueGetter<NavigationLabelSize?>? labelSize, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
