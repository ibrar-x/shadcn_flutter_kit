---
title: "Extension: ColorExtension"
description: "Extension adding color manipulation utilities to [Color]."
---

```dart
/// Extension adding color manipulation utilities to [Color].
extension ColorExtension on Color {
  /// Scales the alpha channel by a factor.
  ///
  /// Parameters:
  /// - [factor] (`double`, required): Multiplier for alpha (0.0 to 1.0+).
  ///
  /// Returns: `Color` — color with scaled alpha.
  Color scaleAlpha(double factor);
}
```
