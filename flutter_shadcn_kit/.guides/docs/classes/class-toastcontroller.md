---
title: "Class: ToastController"
description: "Controller that displays toast entries using Overlay."
---

```dart
/// Controller that displays toast entries using Overlay.
class ToastController {
  final Duration defaultDuration;
  final Duration animationDuration;
  ToastController({this.defaultDuration = const Duration(seconds: 3), this.animationDuration = const Duration(milliseconds: 250)});
  void show({required BuildContext context, required WidgetBuilder builder, Duration? duration, double? spacing});
}
```
