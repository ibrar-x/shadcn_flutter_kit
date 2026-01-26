---
title: "Class: ProgressTheme"
description: "Theme data for [Progress]."
---

```dart
/// Theme data for [Progress].
class ProgressTheme extends ComponentThemeData {
  final Color? color;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final double? minHeight;
  const ProgressTheme({this.color, this.backgroundColor, this.borderRadius, this.minHeight});
  ProgressTheme copyWith({ValueGetter<Color?>? color, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<double?>? minHeight});
  bool operator ==(Object other);
  int get hashCode;
}
```
