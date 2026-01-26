---
title: "Class: Keyframe"
description: "Defines a segment in a timeline animation."
---

```dart
/// Defines a segment in a timeline animation.
abstract class Keyframe<T> {
  Duration get duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
