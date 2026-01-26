---
title: "Class: RepeatedAnimationBuilder"
description: "Reference for RepeatedAnimationBuilder"
---

```dart
class RepeatedAnimationBuilder extends StatefulWidget {
  final double start;
  final double end;
  final Duration duration;
  final Curve curve;
  final RepeatedAnimationWidgetBuilder builder;
  final Widget? child;
  const RepeatedAnimationBuilder({super.key, required this.start, required this.end, required this.duration, this.curve = Curves.linear, required this.builder, this.child});
  State<RepeatedAnimationBuilder> createState();
}
```
