---
title: "Class: HiddenTheme"
description: "Theme data for [Hidden]."
---

```dart
/// Theme data for [Hidden].
class HiddenTheme extends ComponentThemeData {
  final Axis? direction;
  final Duration? duration;
  final Curve? curve;
  final bool? reverse;
  final bool? keepCrossAxisSize;
  final bool? keepMainAxisSize;
  const HiddenTheme({this.direction, this.duration, this.curve, this.reverse, this.keepCrossAxisSize, this.keepMainAxisSize});
  HiddenTheme copyWith({ValueGetter<Axis?>? direction, ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<bool?>? reverse, ValueGetter<bool?>? keepCrossAxisSize, ValueGetter<bool?>? keepMainAxisSize});
  bool operator ==(Object other);
  int get hashCode;
}
```
