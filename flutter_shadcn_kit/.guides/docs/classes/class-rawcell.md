---
title: "Class: RawCell"
description: "Reference for RawCell"
---

```dart
class RawCell extends ParentDataWidget<TableParentData> {
  /// Column index for this cell.
  final int column;
  /// Row index for this cell.
  final int row;
  /// Number of columns spanned. Defaults to 1.
  final int? columnSpan;
  /// Number of rows spanned. Defaults to 1.
  final int? rowSpan;
  /// Whether to compute size for this cell.
  final bool computeSize;
  /// Creates a [RawCell].
  const RawCell({super.key, required this.column, required this.row, this.columnSpan, this.rowSpan, this.computeSize = true, required super.child});
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
