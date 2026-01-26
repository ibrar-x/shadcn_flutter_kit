---
title: "Class: TableRef"
description: "Reference for TableRef"
---

```dart
class TableRef {
  /// Starting index of the reference.
  final int index;
  /// Number of rows/columns spanned. Defaults to 1.
  final int span;
  /// Creates a [TableRef].
  const TableRef(this.index, [this.span = 1]);
  /// Tests if this reference includes the given index and span.
  bool test(int index, int span);
}
```
