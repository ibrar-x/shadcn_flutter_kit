part of '../table.dart';

typedef TableCellThemeBuilder = TableCellTheme Function(BuildContext context);

/// Represents a row in a table.
///
/// Contains a list of cells and optional styling for all cells in the row.
/// Can be marked as selected to highlight the entire row.
///
/// Example:
/// ```dart
/// TableRow(
///   cells: [
///     TableCell(child: Text('Cell 1')),
///     TableCell(child: Text('Cell 2')),
///   ],
///   selected: true,
///   cellTheme: TableCellTheme(...),
/// )
/// ```
