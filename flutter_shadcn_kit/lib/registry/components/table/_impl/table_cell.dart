part of '../table.dart';

class TableCell {
  /// Number of columns this cell spans. Defaults to 1.
  final int columnSpan;

  /// Number of rows this cell spans. Defaults to 1.
  final int rowSpan;

  /// The widget displayed in this cell.
  final Widget child;

  /// Whether to highlight this cell when hovering over its column.
  final bool columnHover;

  /// Whether to highlight this cell when hovering over its row.
  final bool rowHover;

  /// Background color for this cell. Overrides theme color.
  final Color? backgroundColor;

  /// Custom theme for this cell. Overrides table-level theme.
  final TableCellTheme? theme;

  /// Whether this cell responds to user interactions.
  final bool enabled;

  /// Creates a [TableCell].
  const TableCell({
    this.columnSpan = 1,
    this.rowSpan = 1,
    required this.child,
    this.backgroundColor,
    this.columnHover = false,
    this.rowHover = true,
    this.theme,
    this.enabled = true,
  });

  /// Builds the widget tree for this table cell.
  ///
  /// This method renders the cell with appropriate styling including:
  /// - Background color based on theme and state
  /// - Border styling with state resolution
  /// - Hover effects for column and row highlighting
  /// - Selection state visualization
  /// - Resize handles if the table is resizable
  ///
  /// The build process integrates with the table's hover system to provide
  /// visual feedback when the mouse hovers over cells in the same row or column.
  ///
  /// Returns a [Widget] representing the fully styled table cell.
  Widget build(BuildContext context) {
    final flattenedData = Data.of<_FlattenedTableCell>(context);
    final resizedData = Data.maybeOf<_ResizableTableData>(context);
    final resizedState = Data.maybeOf<_ResizableTableState>(context);
    final currentCell = _HoveredCell(
      flattenedData.column,
      flattenedData.row,
      flattenedData.columnSpan,
      flattenedData.rowSpan,
    );
    var theme = this.theme;
    var defaultTheme = flattenedData.tableCellThemeBuilder(context);
    final appTheme = Theme.of(context);
    return Stack(
      fit: StackFit.passthrough,
      children: [
        ColoredBox(
          color: backgroundColor ?? appTheme.colorScheme.background,
          child: MouseRegion(
            onEnter: (event) {
              if (flattenedData.enabled) {
                flattenedData.hoveredCellNotifier.value = currentCell;
              }
            },
            onExit: (event) {
              if (flattenedData.enabled) {
                if (flattenedData.hoveredCellNotifier.value == currentCell) {
                  flattenedData.hoveredCellNotifier.value = null;
                }
              }
            },
            child: ListenableBuilder(
              // valueListenable: flattenedData.hoveredCellNotifier,
              listenable: Listenable.merge([
                flattenedData.hoveredCellNotifier,
                flattenedData.dragNotifier,
              ]),
              builder: (context, child) {
                var hoveredCell = flattenedData.hoveredCellNotifier.value;
                var drag = flattenedData.dragNotifier?.value;
                if (drag != null) {
                  hoveredCell = null;
                }
                var resolvedStates = {
                  if (hoveredCell != null &&
                      ((columnHover &&
                              hoveredCell.intersects(
                                  currentCell, Axis.vertical)) ||
                          (rowHover &&
                              hoveredCell.intersects(
                                  currentCell, Axis.horizontal))))
                    WidgetState.hovered,
                  if (flattenedData.selected) WidgetState.selected,
                  if (!flattenedData.enabled) WidgetState.disabled,
                };
                return Container(
                  decoration: BoxDecoration(
                    border: theme?.border?.resolve(resolvedStates) ??
                        defaultTheme.border?.resolve(resolvedStates),
                    color: theme?.backgroundColor?.resolve(resolvedStates) ??
                        defaultTheme.backgroundColor?.resolve(resolvedStates),
                  ),
                  child: DefaultTextStyle.merge(
                    style: theme?.textStyle?.resolve(resolvedStates) ??
                        defaultTheme.textStyle?.resolve(resolvedStates),
                    child: child!,
                  ),
                );
              },
              child: child,
            ),
          ),
        ),
        if (resizedData != null && resizedState != null)
          Positioned.fill(
            child: _CellResizer(
                controller: resizedData.controller,
                onHover: resizedState._onHover,
                onDrag: resizedState._onDrag,
                hoverNotifier: resizedState._hoverNotifier,
                dragNotifier: resizedState._dragNotifier,
                maxRow: resizedState._maxRow,
                theme: resizedState.widget.theme,
                maxColumn: resizedState._maxColumn),
          )
      ],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TableCell &&
        other.columnSpan == columnSpan &&
        other.rowSpan == rowSpan &&
        other.child == child &&
        other.theme == theme &&
        other.enabled == enabled &&
        other.columnHover == columnHover &&
        other.rowHover == rowHover &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return Object.hash(columnSpan, rowSpan, child, theme, enabled, columnHover,
        rowHover, backgroundColor);
  }
}

/// Function that builds a [TableCellTheme] based on context.
///
/// Used to provide dynamic theming for table cells based on
/// current build context and theme data.
