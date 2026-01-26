---
title: "Class: AbsoluteKeyframe"
description: "Animates between explicit start and end values."
---

```dart
/// Animates between explicit start and end values.
class AbsoluteKeyframe<T> implements Keyframe<T> {
  final T from;
  final T to;
  final Duration duration;
  const AbsoluteKeyframe(this.duration, this.from, this.to);
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
