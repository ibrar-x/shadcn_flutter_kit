---
title: "Class: NumberTickerTheme"
description: "Theme data for [NumberTicker]."
---

```dart
/// Theme data for [NumberTicker].
class NumberTickerTheme extends ComponentThemeData {
  final Duration? duration;
  final Curve? curve;
  final TextStyle? style;
  const NumberTickerTheme({this.duration, this.curve, this.style});
  NumberTickerTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<TextStyle?>? style});
  bool operator ==(Object other);
  int get hashCode;
}
```
