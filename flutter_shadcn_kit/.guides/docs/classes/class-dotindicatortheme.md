---
title: "Class: DotIndicatorTheme"
description: "Theme data for [DotIndicator] and children."
---

```dart
/// Theme data for [DotIndicator] and children.
class DotIndicatorTheme extends ComponentThemeData {
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final DotBuilder? dotBuilder;
  final double? size;
  final double? borderRadius;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? inactiveBorderColor;
  final double? inactiveBorderWidth;
  const DotIndicatorTheme({this.spacing, this.padding, this.dotBuilder, this.size, this.borderRadius, this.activeColor, this.inactiveColor, this.inactiveBorderColor, this.inactiveBorderWidth});
  DotIndicatorTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<DotBuilder?>? dotBuilder, ValueGetter<double?>? size, ValueGetter<double?>? borderRadius, ValueGetter<Color?>? activeColor, ValueGetter<Color?>? inactiveColor, ValueGetter<Color?>? inactiveBorderColor, ValueGetter<double?>? inactiveBorderWidth});
  bool operator ==(Object other);
  int get hashCode;
}
```
