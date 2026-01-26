---
title: "Class: ConvertedController"
description: "A controller that converts between types [F] and [T]."
---

```dart
/// A controller that converts between types [F] and [T].
class ConvertedController<F, T> extends ChangeNotifier implements ComponentController<T> {
  /// Creates a [ConvertedController].
  ConvertedController(ValueNotifier<F> other, BiDirectionalConvert<F, T> convert);
  T get value;
  set value(T newValue);
  void dispose();
}
```
