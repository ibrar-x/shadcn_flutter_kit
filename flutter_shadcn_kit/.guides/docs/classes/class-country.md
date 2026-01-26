---
title: "Class: Country"
description: "Simplified country metadata for phone numbers."
---

```dart
/// Simplified country metadata for phone numbers.
class Country {
  /// The international dial code (e.g. "+1").
  final String dialCode;
  /// The ISO 2-letter country code.
  final String code;
  /// Creates a [Country] descriptor.
  const Country({required this.dialCode, required this.code});
}
```
