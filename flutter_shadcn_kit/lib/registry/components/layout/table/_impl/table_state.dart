part of '../table.dart';

class _TableState extends State<Table> {
  late List<_FlattenedTableCell> _cells;
  final ValueNotifier<_HoveredCell?> _hoveredCellNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _initCells();
  }

  @override
  void didUpdateWidget(covariant Table oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.rows, oldWidget.rows)) {
      _initCells();
    }
  }

  void _initCells() {
    _cells = [];
    for (int r = 0; r < widget.rows.length; r++) {
      final row = widget.rows[r];
      for (int c = 0; c < row.cells.length; c++) {
        final cell = row.cells[c];
        _cells.add(_FlattenedTableCell(
          column: c,
          row: r,
          columnSpan: cell.columnSpan,
          rowSpan: cell.rowSpan,
          builder: cell.build,
          enabled: cell.enabled,
          hoveredCellNotifier: _hoveredCellNotifier,
          dragNotifier: null,
          tableCellThemeBuilder: row.buildDefaultTheme,
          selected: row.selected,
        ));
      }
    }
    _cells = _reorganizeCells(_cells);
  }

  @override
  Widget build(BuildContext context) {
    TableTheme? tableTheme =
        widget.theme ?? ComponentTheme.maybeOf<TableTheme>(context);
    return Container(
      clipBehavior: widget.clipBehavior,
      decoration: BoxDecoration(
        border: tableTheme?.border,
        color: tableTheme?.backgroundColor,
        borderRadius: tableTheme?.borderRadius,
      ),
      child: RawTableLayout(
        clipBehavior: widget.clipBehavior,
        frozenColumn: widget.frozenCells?.testColumn,
        frozenRow: widget.frozenCells?.testRow,
        horizontalOffset: widget.horizontalOffset,
        verticalOffset: widget.verticalOffset,
        viewportSize: widget.viewportSize,
        width: (index) {
          if (widget.columnWidths != null) {
            return widget.columnWidths![index] ?? widget.defaultColumnWidth;
          }
          return widget.defaultColumnWidth;
        },
        height: (index) {
          if (widget.rowHeights != null) {
            return widget.rowHeights![index] ?? widget.defaultRowHeight;
          }
          return widget.defaultRowHeight;
        },
        children: _cells.map((cell) {
          return Data.inherit(
            data: cell,
            child: RawCell(
              column: cell.column,
              row: cell.row,
              columnSpan: cell.columnSpan,
              rowSpan: cell.rowSpan,
              child: Builder(builder: (context) {
                return cell.builder(context);
              }),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Reference to a table row or column by index and span.
///
/// Used to identify specific rows or columns in table layouts,
/// particularly for frozen/pinned row and column functionality.
///
/// Example:
/// ```dart
/// TableRef(0, 2) // References rows/columns 0 and 1
/// TableRef(5)    // References row/column 5 with span of 1
/// ```
