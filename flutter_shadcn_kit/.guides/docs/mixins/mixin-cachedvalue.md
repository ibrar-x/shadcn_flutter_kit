---
title: "Mixin: CachedValue"
description: "Mixin for values that need custom rebuild logic."
---

```dart
/// Mixin for values that need custom rebuild logic.
mixin CachedValue {
  /// Determines if the widget should rebuild when value changes.
  bool shouldRebuild(covariant CachedValue oldValue);
}
```
