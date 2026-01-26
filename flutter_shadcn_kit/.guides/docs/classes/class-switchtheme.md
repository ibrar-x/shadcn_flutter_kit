---
title: "Class: SwitchTheme"
description: "Theme configuration for switch styling."
---

```dart
/// Theme configuration for switch styling.
class SwitchTheme extends ComponentThemeData {
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final double? gap;
  final BorderRadiusGeometry? borderRadius;
  const SwitchTheme({this.activeColor, this.inactiveColor, this.activeThumbColor, this.inactiveThumbColor, this.gap, this.borderRadius});
  SwitchTheme copyWith({ValueGetter<Color?>? activeColor, ValueGetter<Color?>? inactiveColor, ValueGetter<Color?>? activeThumbColor, ValueGetter<Color?>? inactiveThumbColor, ValueGetter<double?>? gap, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
