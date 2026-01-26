---
title: "Class: ControlledAnimation"
description: "A controlled animation that wraps an [AnimationController] and provides  smooth transitions between values using curves."
---

```dart
/// A controlled animation that wraps an [AnimationController] and provides
/// smooth transitions between values using curves.
class ControlledAnimation extends Animation<double> {
  ControlledAnimation(this._controller);
  /// Animates from the current value to the specified target value.
  TickerFuture forward(double to, [Curve? curve]);
  set value(double value);
  void addListener(VoidCallback listener);
  void addStatusListener(AnimationStatusListener listener);
  void removeListener(VoidCallback listener);
  void removeStatusListener(AnimationStatusListener listener);
  AnimationStatus get status;
  double get value;
}
```
