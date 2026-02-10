part of '../../table.dart';

class _CellResizerState extends State<_CellResizer> {
  Resizer? _resizer;
  bool? _resizeRow;

  void _onDragStartRow(DragStartDetails details) {
    List<ResizableItem> items = [];
    for (int i = 0; i <= widget.maxRow; i++) {
      items.add(
        ResizableItem(
          value: widget.controller.getRowHeight(i),
          min: widget.controller.getRowMinHeight(i) ?? 0,
          max: widget.controller.getRowMaxHeight(i) ?? double.infinity,
        ),
      );
    }
    _resizer = Resizer(items);
    _resizeRow = true;
    widget.onDrag(true, -1, Axis.horizontal);
  }

  void _onDragStartColumn(DragStartDetails details) {
    List<ResizableItem> items = [];
    for (int i = 0; i <= widget.maxColumn; i++) {
      items.add(
        ResizableItem(
          value: widget.controller.getColumnWidth(i),
          min: widget.controller.getColumnMinWidth(i) ?? 0,
          max: widget.controller.getColumnMaxWidth(i) ?? double.infinity,
        ),
      );
    }
    _resizer = Resizer(items);
    _resizeRow = false;
    widget.onDrag(true, -1, Axis.vertical);
  }

  void _onDragUpdate(int start, int end, DragUpdateDetails details) {
    // _resizer!.resize(start, end, _delta!);
    _resizer!.dragDivider(end, details.primaryDelta!);
    for (int i = 0; i < _resizer!.items.length; i++) {
      // widget.controller.resizeRow(i, _resizer!.items[i].newValue);
      if (_resizeRow!) {
        widget.controller.resizeRow(i, _resizer!.items[i].newValue);
      } else {
        widget.controller.resizeColumn(i, _resizer!.items[i].newValue);
      }
    }
  }

  void _onDragEnd(DragEndDetails details) {
    widget.onDrag(false, -1, Axis.horizontal);
    // _delta = null;
    _resizer = null;
    _resizeRow = null;
  }

  void _onDragCancel() {
    if (_resizer == null) {
      return;
    }
    widget.onDrag(false, -1, Axis.horizontal);
    _resizer!.reset();
    for (int i = 0; i <= widget.maxRow; i++) {
      if (_resizeRow == true) {
        widget.controller.resizeRow(i, _resizer!.items[i].value);
      } else {
        widget.controller.resizeColumn(i, _resizer!.items[i].value);
      }
    }
    _resizer = null;
    _resizeRow = null;
  }

  @override
  Widget build(BuildContext context) {
    double thickness = widget.theme?.resizerThickness ?? 4;
    final flattenedData = Data.of<_FlattenedTableCell>(context);
    final row = flattenedData.row;
    final column = flattenedData.column;
    final rowSpan = flattenedData.rowSpan;
    final columnSpan = flattenedData.columnSpan;
    final tableData = Data.of<_ResizableTableData>(context);
    final widthMode = tableData.cellWidthResizeMode;
    final heightMode = tableData.cellHeightResizeMode;
    final theme = Theme.of(context);
    return Stack(
      children: [
        // top
        if (row > 0 && heightMode != TableCellResizeMode.none)
          Positioned(
            top: -thickness / 2,
            left: 0,
            right: 0,
            height: thickness,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeRow,
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) {
                widget.onHover(true, row - 1, Axis.horizontal);
              },
              onExit: (event) {
                widget.onHover(false, row - 1, Axis.horizontal);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: _onDragStartRow,
                onVerticalDragUpdate: (details) {
                  if (heightMode == TableCellResizeMode.reallocate) {
                    _onDragUpdate(row - 1, row, details);
                  } else {
                    widget.controller.resizeRow(
                      row - 1,
                      widget.controller.getRowHeight(row - 1) +
                          details.primaryDelta!,
                    );
                  }
                },
                onVerticalDragEnd: _onDragEnd,
                onVerticalDragCancel: _onDragCancel,
                child: ListenableBuilder(
                  // valueListenable: widget.hoverNotifier,
                  listenable: Listenable.merge([
                    widget.hoverNotifier,
                    widget.dragNotifier,
                  ]),
                  builder: (context, child) {
                    _HoveredLine? hover = widget.hoverNotifier.value;
                    _HoveredLine? drag = widget.dragNotifier.value;
                    if (drag != null) {
                      hover = null;
                    }
                    return Container(
                      color:
                          (hover?.index == row - 1 &&
                                  hover?.direction == Axis.horizontal) ||
                              (drag?.index == row - 1 &&
                                  drag?.direction == Axis.horizontal)
                          ? widget.theme?.resizerColor ??
                                theme.colorScheme.primary
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        // bottom
        if ((row + rowSpan <= tableData.maxRow ||
                heightMode == TableCellResizeMode.expand) &&
            heightMode != TableCellResizeMode.none)
          Positioned(
            bottom: -thickness / 2,
            left: 0,
            right: 0,
            height: thickness,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeRow,
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) {
                widget.onHover(true, row + rowSpan - 1, Axis.horizontal);
              },
              onExit: (event) {
                widget.onHover(false, row + rowSpan - 1, Axis.horizontal);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: _onDragStartRow,
                onVerticalDragUpdate: (details) {
                  if (heightMode == TableCellResizeMode.reallocate) {
                    _onDragUpdate(row + rowSpan - 1, row + rowSpan, details);
                  } else {
                    widget.controller.resizeRow(
                      row + rowSpan - 1,
                      widget.controller.getRowHeight(row + rowSpan - 1) +
                          details.primaryDelta!,
                    );
                  }
                },
                onVerticalDragEnd: _onDragEnd,
                onVerticalDragCancel: _onDragCancel,
                child: ListenableBuilder(
                  listenable: Listenable.merge([
                    widget.hoverNotifier,
                    widget.dragNotifier,
                  ]),
                  builder: (context, child) {
                    _HoveredLine? hover = widget.hoverNotifier.value;
                    _HoveredLine? drag = widget.dragNotifier.value;
                    if (drag != null) {
                      hover = null;
                    }
                    return Container(
                      color:
                          (hover?.index == row + rowSpan - 1 &&
                                  hover?.direction == Axis.horizontal) ||
                              (drag?.index == row + rowSpan - 1 &&
                                  drag?.direction == Axis.horizontal)
                          ? widget.theme?.resizerColor ??
                                theme.colorScheme.primary
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        // left
        if (column > 0 && widthMode != TableCellResizeMode.none)
          Positioned(
            left: -thickness / 2,
            top: 0,
            bottom: 0,
            width: thickness,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) {
                widget.onHover(true, column - 1, Axis.vertical);
              },
              onExit: (event) {
                widget.onHover(false, column - 1, Axis.vertical);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragStart: _onDragStartColumn,
                onHorizontalDragUpdate: (details) {
                  if (widthMode == TableCellResizeMode.reallocate) {
                    _onDragUpdate(column - 1, column, details);
                  } else {
                    widget.controller.resizeColumn(
                      column - 1,
                      widget.controller.getColumnWidth(column - 1) +
                          details.primaryDelta!,
                    );
                  }
                },
                onHorizontalDragEnd: _onDragEnd,
                onHorizontalDragCancel: _onDragCancel,
                child: ListenableBuilder(
                  listenable: Listenable.merge([
                    widget.hoverNotifier,
                    widget.dragNotifier,
                  ]),
                  builder: (context, child) {
                    _HoveredLine? hover = widget.hoverNotifier.value;
                    _HoveredLine? drag = widget.dragNotifier.value;
                    if (drag != null) {
                      hover = null;
                    }
                    return Container(
                      color:
                          (hover?.index == column - 1 &&
                                  hover?.direction == Axis.vertical) ||
                              (drag?.index == column - 1 &&
                                  drag?.direction == Axis.vertical)
                          ? widget.theme?.resizerColor ??
                                theme.colorScheme.primary
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        // right
        if ((column + columnSpan <= tableData.maxColumn ||
                widthMode == TableCellResizeMode.expand) &&
            widthMode != TableCellResizeMode.none)
          Positioned(
            right: -thickness / 2,
            top: 0,
            bottom: 0,
            width: thickness,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) {
                widget.onHover(true, column + columnSpan - 1, Axis.vertical);
              },
              onExit: (event) {
                widget.onHover(false, column + columnSpan - 1, Axis.vertical);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragStart: _onDragStartColumn,
                onHorizontalDragUpdate: (details) {
                  if (widthMode == TableCellResizeMode.reallocate) {
                    _onDragUpdate(
                      column + columnSpan - 1,
                      column + columnSpan,
                      details,
                    );
                  } else {
                    widget.controller.resizeColumn(
                      column + columnSpan - 1,
                      widget.controller.getColumnWidth(
                            column + columnSpan - 1,
                          ) +
                          details.primaryDelta!,
                    );
                  }
                },
                onHorizontalDragEnd: _onDragEnd,
                onHorizontalDragCancel: _onDragCancel,
                child: ListenableBuilder(
                  listenable: Listenable.merge([
                    widget.hoverNotifier,
                    widget.dragNotifier,
                  ]),
                  builder: (context, child) {
                    _HoveredLine? hover = widget.hoverNotifier.value;
                    _HoveredLine? drag = widget.dragNotifier.value;
                    if (drag != null) {
                      hover = null;
                    }
                    return Container(
                      color:
                          (hover?.index == column + columnSpan - 1 &&
                                  hover?.direction == Axis.vertical) ||
                              (drag?.index == column + columnSpan - 1 &&
                                  drag?.direction == Axis.vertical)
                          ? widget.theme?.resizerColor ??
                                theme.colorScheme.primary
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
