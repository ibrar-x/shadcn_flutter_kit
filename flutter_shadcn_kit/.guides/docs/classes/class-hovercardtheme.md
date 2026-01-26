---
title: "Class: HoverCardTheme"
description: "Theme configuration for hover card behavior and appearance."
---

```dart
/// Theme configuration for hover card behavior and appearance.
class HoverCardTheme extends ComponentThemeData {
  final Duration? debounce;
  final Duration? wait;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? anchorAlignment;
  final Offset? popoverOffset;
  final HitTestBehavior? behavior;
  const HoverCardTheme({this.debounce, this.wait, this.popoverAlignment, this.anchorAlignment, this.popoverOffset, this.behavior});
  HoverCardTheme copyWith({ValueGetter<Duration?>? debounce, ValueGetter<Duration?>? wait, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? anchorAlignment, ValueGetter<Offset?>? popoverOffset, ValueGetter<HitTestBehavior?>? behavior});
  bool operator ==(Object other);
  int get hashCode;
}
```
