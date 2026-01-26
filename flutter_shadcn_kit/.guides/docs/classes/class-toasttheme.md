---
title: "Class: ToastTheme"
description: "Theme data for toast notifications."
---

```dart
/// Theme data for toast notifications.
class ToastTheme extends ComponentThemeData {
  final EdgeInsetsGeometry? padding;
  final double? margin;
  final Duration? duration;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  const ToastTheme({this.padding, this.margin, this.duration, this.animationDuration, this.animationCurve, this.width, this.borderRadius, this.backgroundColor});
  ToastTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? margin, ValueGetter<Duration?>? duration, ValueGetter<Duration?>? animationDuration, ValueGetter<Curve?>? animationCurve, ValueGetter<double?>? width, ValueGetter<double?>? borderRadius, ValueGetter<Color?>? backgroundColor});
}
```
