---
title: "Class: FrozenTableData"
description: "Reference for FrozenTableData"
---

```dart
class FrozenTableData {
  /// Rows that should be frozen during vertical scrolling.
  final Iterable<TableRef> frozenRows;
  /// Columns that should be frozen during horizontal scrolling.
  final Iterable<TableRef> frozenColumns;
  /// Creates a [FrozenTableData].
  const FrozenTableData({this.frozenRows = const [], this.frozenColumns = const []});
  /// Tests if a row at the given index and span is frozen.
  bool testRow(int index, int span);
  /// Tests if a column at the given index and span is frozen.
  bool testColumn(int index, int span);
}
```
