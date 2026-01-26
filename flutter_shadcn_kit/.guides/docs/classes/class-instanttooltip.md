---
title: "Class: InstantTooltip"
description: "Tooltip that shows immediately on hover."
---

```dart
/// Tooltip that shows immediately on hover.
class InstantTooltip extends StatefulWidget {
  final Widget child;
  final HitTestBehavior behavior;
  final WidgetBuilder tooltipBuilder;
  final AlignmentGeometry tooltipAlignment;
  final AlignmentGeometry? tooltipAnchorAlignment;
  const InstantTooltip({super.key, required this.child, required this.tooltipBuilder, this.behavior = HitTestBehavior.translucent, this.tooltipAlignment = Alignment.bottomCenter, this.tooltipAnchorAlignment});
  State<InstantTooltip> createState();
}
```
