---
title: "Class: RelativeKeyframe"
description: "Animates from the previous keyframe's end to [target]."
---

```dart
/// Animates from the previous keyframe's end to [target].
class RelativeKeyframe<T> implements Keyframe<T> {
  final T target;
  final Duration duration;
  const RelativeKeyframe(this.duration, this.target);
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
