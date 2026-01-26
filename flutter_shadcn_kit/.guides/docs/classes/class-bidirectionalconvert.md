---
title: "Class: BiDirectionalConvert"
description: "Converts between two value types using the provided converters."
---

```dart
/// Converts between two value types using the provided converters.
class BiDirectionalConvert<A, B> {
  /// Converts from A to B.
  final B Function(A) aToB;
  /// Converts from B to A.
  final A Function(B) bToA;
  /// Creates a [BiDirectionalConvert].
  BiDirectionalConvert(this.aToB, this.bToA);
  /// Converts A to B.
  B convertA(A value);
  /// Converts B to A.
  A convertB(B value);
  bool operator ==(Object other);
  int get hashCode;
}
```
