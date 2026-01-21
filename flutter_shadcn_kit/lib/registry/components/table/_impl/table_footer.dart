part of '../table.dart';

class TableFooter extends TableRow {
  /// Creates a [TableFooter].
  const TableFooter({required super.cells, super.cellTheme});

  @override
  TableCellTheme buildDefaultTheme(BuildContext context) {
    if (cellTheme != null) {
      return cellTheme!;
    }
    final theme = Theme.of(context);
    return TableCellTheme(
      border: const WidgetStatePropertyAll(null),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.hovered)
              ? theme.colorScheme.muted
              : theme.colorScheme.muted.withValues(alpha: 0.5);
        },
      ),
      textStyle: WidgetStateProperty.resolveWith(
        (states) {
          return TextStyle(
            color: states.contains(WidgetState.disabled)
                ? theme.colorScheme.muted
                : null,
          );
        },
      ),
    );
  }
}

/// Specialized row for table headers.
///
/// Extends [TableRow] with default styling appropriate for header rows,
/// including bold text, muted background, and bottom border styling.
///
/// Example:
/// ```dart
/// TableHeader(
///   cells: [
///     TableCell(child: Text('Name')),
///     TableCell(child: Text('Age')),
///     TableCell(child: Text('City')),
///   ],
/// )
/// ```
