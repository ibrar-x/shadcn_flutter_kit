---
title: "Class: TableRow"
description: "Reference for TableRow"
---

```dart
class TableRow {
  /// The cells contained in this row.
  final List<TableCell> cells;
  /// Theme applied to all cells in this row.
  final TableCellTheme? cellTheme;
  /// Whether this row is selected.
  final bool selected;
  /// Creates a [TableRow].
  const TableRow({required this.cells, this.cellTheme, this.selected = false});
  /// Builds the default theme for cells in this row.
  ///
  /// Creates a [TableCellTheme] with default styling when no explicit [cellTheme]
  /// is provided. The default theme includes:
  /// - Border with bottom line using theme border color
  /// - Background color that changes to muted on hover
  /// - Text style that becomes muted when disabled
  ///
  /// The theme uses [WidgetStateProperty] to adapt styling based on cell state
  /// (hovered, selected, disabled).
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context for accessing theme data
  ///
  /// Returns [TableCellTheme] with default or custom cell styling.
  TableCellTheme buildDefaultTheme(BuildContext context);
  bool operator ==(Object other);
  int get hashCode;
}
```
