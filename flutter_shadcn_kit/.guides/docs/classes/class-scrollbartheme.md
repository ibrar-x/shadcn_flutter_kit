---
title: "Class: ScrollbarTheme"
description: "Theme configuration for Scrollbar."
---

```dart
/// Theme configuration for Scrollbar.
class ScrollbarTheme extends ComponentThemeData {
  final Color? color;
  final double? thickness;
  final Radius? radius;
  const ScrollbarTheme({this.color, this.thickness, this.radius});
  ScrollbarTheme copyWith({ValueGetter<Color?>? color, ValueGetter<double?>? thickness, ValueGetter<Radius?>? radius});
  bool operator ==(Object other);
  int get hashCode;
}
```
