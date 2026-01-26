---
title: "Class: AvatarGroup"
description: "Reference for AvatarGroup"
---

```dart
class AvatarGroup extends StatelessWidget {
  const AvatarGroup({super.key, required this.alignment, required this.children, this.gap, this.clipBehavior});
  final List<AvatarWidget> children;
  final AlignmentGeometry alignment;
  final double? gap;
  final Clip? clipBehavior;
  factory AvatarGroup.toLeft({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  factory AvatarGroup.toRight({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  factory AvatarGroup.toStart({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  factory AvatarGroup.toEnd({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  factory AvatarGroup.toTop({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  factory AvatarGroup.toBottom({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  Widget build(BuildContext context);
}
```
