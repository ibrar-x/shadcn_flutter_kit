---
title: "Class: AvatarBadge"
description: "Reference for AvatarBadge"
---

```dart
class AvatarBadge extends StatelessWidget implements AvatarWidget {
  const AvatarBadge({super.key, this.child, this.size, this.borderRadius, this.color});
  final Widget? child;
  final double? size;
  final double? borderRadius;
  final Color? color;
  Widget build(BuildContext context);
}
```
