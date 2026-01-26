---
title: "Class: SliderValue"
description: "Represents a single-thumb or range slider value."
---

```dart
/// Represents a single-thumb or range slider value.
class SliderValue {
  const SliderValue.single(double value);
  const SliderValue.ranged(double start, double end);
  bool get isRanged;
  double get start;
  double get end;
  double get value;
  static SliderValue? lerp(SliderValue? a, SliderValue? b, double t);
  SliderValue roundToDivisions(int divisions);
  bool operator ==(Object other);
  int get hashCode;
}
```
