---
title: "Class: DividerTheme"
description: "Theme data for divider widgets."
---

```dart
/// Theme data for divider widgets.
class DividerTheme extends ComponentThemeData {
  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? padding;
  const DividerTheme({this.color, this.height, this.thickness, this.indent, this.endIndent, this.padding});
  DividerTheme copyWith({ValueGetter<Color?>? color, ValueGetter<double?>? height, ValueGetter<double?>? thickness, ValueGetter<double?>? indent, ValueGetter<double?>? endIndent, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
