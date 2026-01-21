part of '../table.dart';

class _HoveredCell {
  final int column;
  final int row;
  final int columnSpan;
  final int rowSpan;

  _HoveredCell(this.column, this.row, this.columnSpan, this.rowSpan);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _HoveredCell &&
        other.column == column &&
        other.row == row &&
        other.columnSpan == columnSpan &&
        other.rowSpan == rowSpan;
  }

  @override
  int get hashCode {
    return Object.hash(column, row, columnSpan, rowSpan);
  }

  bool intersects(_HoveredCell other, Axis expected) {
    if (other == this) {
      return true;
    }
    if (expected == Axis.vertical) {
      return column < other.column + other.columnSpan &&
          column + columnSpan > other.column;
    } else {
      return row < other.row + other.rowSpan && row + rowSpan > other.row;
    }
  }
}

/// Represents a single cell in a table.
///
/// Defines cell content, spanning behavior, and styling. Cells can span
/// multiple columns or rows, respond to hover interactions, and have
/// custom themes and background colors.
///
/// Example:
/// ```dart
/// TableCell(
///   columnSpan: 2,
///   rowSpan: 1,
///   child: Text('Spanning cell'),
///   rowHover: true,
///   backgroundColor: Colors.blue.shade50,
/// )
/// ```
