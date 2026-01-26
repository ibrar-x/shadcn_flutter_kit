---
title: "Class: ToastEntry"
description: "Reference for ToastEntry"
---

```dart
class ToastEntry extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration animationDuration;
  final Curve animationCurve;
  final VoidCallback onDismissed;
  const ToastEntry({super.key, required this.child, required this.duration, required this.animationDuration, required this.animationCurve, required this.onDismissed});
  State<ToastEntry> createState();
}
```
