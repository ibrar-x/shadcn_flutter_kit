---
title: "Class: SkeletonTheme"
description: "Theme configuration for skeleton loading effects."
---

```dart
/// Theme configuration for skeleton loading effects.
class SkeletonTheme extends ComponentThemeData {
  final Duration? duration;
  final Color? fromColor;
  final Color? toColor;
  final bool? enableSwitchAnimation;
  const SkeletonTheme({this.duration, this.fromColor, this.toColor, this.enableSwitchAnimation});
  SkeletonTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Color?>? fromColor, ValueGetter<Color?>? toColor, ValueGetter<bool?>? enableSwitchAnimation});
  bool operator ==(Object other);
  int get hashCode;
}
```
