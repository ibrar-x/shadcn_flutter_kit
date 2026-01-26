---
title: "Class: TrackerTheme"
description: "Theme for tracker appearance."
---

```dart
/// Theme for tracker appearance.
class TrackerTheme extends ComponentThemeData {
  final double? radius;
  final double? gap;
  final double? itemHeight;
  const TrackerTheme({this.radius, this.gap, this.itemHeight});
  TrackerTheme copyWith({ValueGetter<double?>? radius, ValueGetter<double?>? gap, ValueGetter<double?>? itemHeight});
  bool operator ==(Object other);
  int get hashCode;
}
```
