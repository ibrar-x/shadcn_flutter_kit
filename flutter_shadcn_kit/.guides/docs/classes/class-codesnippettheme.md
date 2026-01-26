---
title: "Class: CodeSnippetTheme"
description: "Theme configuration for [CodeSnippet]."
---

```dart
/// Theme configuration for [CodeSnippet].
class CodeSnippetTheme extends ComponentThemeData {
  /// Background color of the code snip container.
  final Color? backgroundColor;
  /// Border color.
  final Color? borderColor;
  /// Border width.
  final double? borderWidth;
  /// Border radius.
  final BorderRadiusGeometry? borderRadius;
  /// Padding inside the container.
  final EdgeInsetsGeometry? padding;
  /// Creates a theme for [CodeSnippet].
  const CodeSnippetTheme({this.backgroundColor, this.borderColor, this.borderWidth, this.borderRadius, this.padding});
  /// Returns a copy with replaced values.
  CodeSnippetTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
