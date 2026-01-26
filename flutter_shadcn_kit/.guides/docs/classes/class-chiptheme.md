---
title: "Class: ChipTheme"
description: "Theme config for chips that share padding/style defaults."
---

```dart
/// Theme config for chips that share padding/style defaults.
class ChipTheme extends ComponentThemeData {
  final EdgeInsetsGeometry? padding;
  final AbstractButtonStyle? style;
  const ChipTheme({this.padding, this.style});
  ChipTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<AbstractButtonStyle?>? style});
  bool operator ==(Object other);
  int get hashCode;
}
```
