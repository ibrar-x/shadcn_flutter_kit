---
title: "Class: ShadcnSkeletonizerConfigLayer"
description: "Applies Skeletonizer configuration using shadcn theming."
---

```dart
/// Applies Skeletonizer configuration using shadcn theming.
class ShadcnSkeletonizerConfigLayer extends StatelessWidget {
  const ShadcnSkeletonizerConfigLayer({super.key, required this.theme, required this.child, this.duration, this.fromColor, this.toColor, this.enableSwitchAnimation});
  final material.ThemeData theme;
  final Widget child;
  final Duration? duration;
  final Color? fromColor;
  final Color? toColor;
  final bool? enableSwitchAnimation;
  Widget build(BuildContext context);
}
```
