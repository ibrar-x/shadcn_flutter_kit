---
title: "Class: StillKeyframe"
description: "Holds a value without animating."
---

```dart
/// Holds a value without animating.
class StillKeyframe<T> implements Keyframe<T> {
  final T? value;
  final Duration duration;
  const StillKeyframe(this.duration, [this.value]);
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
