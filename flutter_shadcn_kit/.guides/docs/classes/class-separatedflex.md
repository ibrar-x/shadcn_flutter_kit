---
title: "Class: SeparatedFlex"
description: "Reference for SeparatedFlex"
---

```dart
class SeparatedFlex extends StatefulWidget {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Clip clipBehavior;
  final Widget separator;
  final List<Widget> children;
  const SeparatedFlex({super.key, required this.direction, required this.mainAxisAlignment, required this.mainAxisSize, required this.crossAxisAlignment, this.textDirection, this.verticalDirection = VerticalDirection.down, this.textBaseline, this.clipBehavior = Clip.none, required this.separator, required this.children});
  State<SeparatedFlex> createState();
}
```
