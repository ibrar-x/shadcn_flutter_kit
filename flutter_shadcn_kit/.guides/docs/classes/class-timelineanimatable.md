---
title: "Class: TimelineAnimatable"
description: "Binds a timeline to an explicit duration."
---

```dart
/// Binds a timeline to an explicit duration.
class TimelineAnimatable<T> extends Animatable<T> {
  final Duration duration;
  final TimelineAnimation<T> animation;
  TimelineAnimatable(this.duration, this.animation);
  T transform(double t);
}
```
