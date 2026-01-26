---
title: "Class: AnimationQueueController"
description: "Queue-based animation controller used by carousel transitions."
---

```dart
/// Queue-based animation controller used by carousel transitions.
class AnimationQueueController extends ChangeNotifier {
  /// Creates an animation queue controller with an optional initial value.
  AnimationQueueController([this._value = 0.0]);
  /// Adds an animation request to the queue or replaces the current queue.
  void push(AnimationRequest request, [bool queue = true]);
  /// Sets the current value immediately and clears queued animations.
  set value(double value);
  /// Returns the current value.
  double get value;
  /// Whether there are pending animations to tick.
  bool get shouldTick;
  /// Advances the animation by the given delta.
  void tick(Duration delta);
}
```
