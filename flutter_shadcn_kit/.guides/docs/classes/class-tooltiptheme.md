---
title: "Class: TooltipTheme"
description: "Theme data for customizing tooltip container appearance."
---

```dart
/// Theme data for customizing tooltip container appearance.
class TooltipTheme extends ComponentThemeData {
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  const TooltipTheme({this.surfaceOpacity, this.surfaceBlur, this.padding, this.backgroundColor, this.borderRadius});
  TooltipTheme copyWith({ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
