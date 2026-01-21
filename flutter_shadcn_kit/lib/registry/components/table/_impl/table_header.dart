part of '../table.dart';

class TableHeader extends TableRow {
  /// Creates a [TableHeader].
  const TableHeader({required super.cells, super.cellTheme});

  @override
  TableCellTheme buildDefaultTheme(BuildContext context) {
    if (cellTheme != null) {
      return cellTheme!;
    }
    final theme = Theme.of(context);
    return TableCellTheme(
      border: WidgetStateProperty.resolveWith(
        (states) {
          return Border(
            bottom: BorderSide(
              color: theme.colorScheme.border,
              width: 1,
            ),
          );
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.hovered)
              ? theme.colorScheme.muted
              : theme.colorScheme.muted.withValues(alpha: 0.5);
        },
      ),
      textStyle: WidgetStateProperty.resolveWith(
        (states) {
          return theme.typography.semiBold.merge(TextStyle(
            color: states.contains(WidgetState.disabled)
                ? theme.colorScheme.muted
                : null,
          ));
        },
      ),
    );
  }
}

