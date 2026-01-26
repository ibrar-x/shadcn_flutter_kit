part of '../table.dart';

enum TableCellResizeMode {
  /// The cell size will expand when resized
  expand,

  /// The cell size will expand when resized, but the other cells will shrink
  reallocate,

  /// Disables resizing
  none,
}

/// A table widget with resizable columns and rows.
///
/// Displays tabular data with interactive row and column resizing capabilities.
/// Supports frozen rows/columns, custom resize modes, and scrolling viewports.
///
/// Example:
/// ```dart
/// ResizableTable(
///   controller: ResizableTableController(),
///   rows: [
///     TableRow(children: [Text('Cell 1'), Text('Cell 2')]),
///     TableRow(children: [Text('Cell 3'), Text('Cell 4')]),
///   ],
/// )
/// ```
