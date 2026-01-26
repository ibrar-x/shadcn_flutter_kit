---
title: "Class: PaginationTheme"
description: "Theme data for customizing [Pagination] appearance."
---

```dart
/// Theme data for customizing [Pagination] appearance.
class PaginationTheme extends ComponentThemeData {
  final double? gap;
  final bool? showLabel;
  const PaginationTheme({this.gap, this.showLabel});
  PaginationTheme copyWith({ValueGetter<double?>? gap, ValueGetter<bool?>? showLabel});
  bool operator ==(Object other);
  int get hashCode;
}
```
