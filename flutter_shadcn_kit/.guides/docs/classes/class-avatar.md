---
title: "Class: Avatar"
description: "Reference for Avatar"
---

```dart
class Avatar extends StatefulWidget implements AvatarWidget {
  const Avatar({super.key, required this.initials, this.backgroundColor, this.size, this.borderRadius, this.badge, this.badgeAlignment, this.badgeGap, this.provider});
  Avatar.network({super.key, required this.initials, this.backgroundColor, this.size, this.borderRadius, this.badge, this.badgeAlignment, this.badgeGap, int? cacheWidth, int? cacheHeight, required String photoUrl});
  static String getInitials(String name);
  final String initials;
  final Color? backgroundColor;
  final double? size;
  final double? borderRadius;
  final AvatarBadge? badge;
  final AlignmentGeometry? badgeAlignment;
  final double? badgeGap;
  final ImageProvider? provider;
  State<Avatar> createState();
}
```
