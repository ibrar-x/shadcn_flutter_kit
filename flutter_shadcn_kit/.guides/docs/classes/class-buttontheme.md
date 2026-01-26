---
title: "Class: ButtonTheme"
description: "Reference for ButtonTheme"
---

```dart
abstract class ButtonTheme extends ComponentThemeData {
  /// Optional decoration override (background, border, shadows).
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  /// Optional mouse cursor override.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  /// Optional padding override.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  /// Optional text style override.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  /// Optional icon theme override.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  /// Optional margin override.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;
  /// Creates a [ButtonTheme] with optional style property delegates.
  ///
  /// All parameters are optional, allowing selective override of specific
  /// style properties while leaving others to use default values.
  const ButtonTheme({this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.margin});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
