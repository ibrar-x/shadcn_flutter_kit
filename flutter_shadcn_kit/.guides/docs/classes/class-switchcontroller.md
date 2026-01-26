---
title: "Class: SwitchController"
description: "Controller for managing switch state."
---

```dart
/// Controller for managing switch state.
class SwitchController extends ValueNotifier<bool> with ComponentController<bool> {
  SwitchController([super.value = false]);
  void toggle();
}
```
