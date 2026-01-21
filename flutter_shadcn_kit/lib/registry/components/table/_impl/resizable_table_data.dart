part of '../table.dart';

class _ResizableTableData {
  final ResizableTableController controller;
  final TableCellResizeMode cellWidthResizeMode;
  final TableCellResizeMode cellHeightResizeMode;
  final int maxColumn;
  final int maxRow;

  const _ResizableTableData({
    required this.controller,
    required this.cellWidthResizeMode,
    required this.cellHeightResizeMode,
    required this.maxColumn,
    required this.maxRow,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ResizableTableData &&
        other.cellWidthResizeMode == cellWidthResizeMode &&
        other.cellHeightResizeMode == cellHeightResizeMode &&
        other.maxColumn == maxColumn &&
        other.maxRow == maxRow;
  }

  @override
  int get hashCode {
    return Object.hash(
        cellWidthResizeMode, maxColumn, maxRow, cellHeightResizeMode);
  }
}

