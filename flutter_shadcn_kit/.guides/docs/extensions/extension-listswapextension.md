---
title: "Extension: ListSwapExtension"
description: "Reference for extension"
---

```dart
extension ListSwapExtension<T> on List<T> {
  bool swapItem(T element, int targetIndex);
  bool swapItemWhere(Predicate<T> test, int targetIndex);
  T? optGet(int index);
}
```
