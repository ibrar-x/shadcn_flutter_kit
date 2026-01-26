---
title: "Class: FocusOutlineTheme"
description: "Theme configuration for focus outlines."
---

```dart
/// Theme configuration for focus outlines.
class FocusOutlineTheme extends ComponentThemeData {
  /// Offset applied when drawing the outline.
  final double? align;
  /// Border radius for rounded outlines.
  final BorderRadiusGeometry? borderRadius;
  /// Border style used by the outline.
  final Border? border;
  /// Creates a theme for [FocusOutline].
  const FocusOutlineTheme({this.align, this.borderRadius, this.border});
  /// Copies this theme with selected overrides.
  FocusOutlineTheme copyWith({ValueGetter<double?>? align, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<Border?>? border});
  bool operator ==(Object other);
  int get hashCode;
}
```
