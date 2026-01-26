---
title: "Class: AlertTheme"
description: "Theme extensions used by [Alert]."
---

```dart
/// Theme extensions used by [Alert].
class AlertTheme extends ComponentThemeData {
  const AlertTheme({this.padding, this.backgroundColor, this.borderColor});
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  AlertTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? borderColor});
  bool operator ==(Object other);
  int get hashCode;
}
```
