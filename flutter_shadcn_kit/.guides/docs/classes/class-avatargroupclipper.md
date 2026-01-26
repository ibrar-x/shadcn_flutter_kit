---
title: "Class: AvatarGroupClipper"
description: "Reference for AvatarGroupClipper"
---

```dart
class AvatarGroupClipper extends CustomClipper<Path> {
  const AvatarGroupClipper({required this.borderRadius, required this.alignment, required this.previousAvatarSize, required this.gap});
  final double borderRadius;
  final Alignment alignment;
  final double previousAvatarSize;
  final double gap;
  Path getClip(Size size);
  bool shouldReclip(covariant AvatarGroupClipper oldClipper);
}
```
