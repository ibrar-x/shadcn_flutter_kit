---
title: "Class: Tooltip"
description: "Tooltip that appears after a hover delay."
---

```dart
/// Tooltip that appears after a hover delay.
class Tooltip extends StatefulWidget {
  final Widget child;
  final WidgetBuilder tooltip;
  final AlignmentGeometry alignment;
  final AlignmentGeometry anchorAlignment;
  final Duration waitDuration;
  final Duration showDuration;
  final Duration minDuration;
  const Tooltip({super.key, required this.child, required this.tooltip, this.alignment = Alignment.topCenter, this.anchorAlignment = Alignment.bottomCenter, this.waitDuration = const Duration(milliseconds: 500), this.showDuration = const Duration(milliseconds: 200), this.minDuration = const Duration(milliseconds: 0)});
  State<Tooltip> createState();
}
```
