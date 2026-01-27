part of '../../table.dart';

class RenderTableLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, TableParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TableParentData> {
  TableSizeSupplier _width;
  TableSizeSupplier _height;
  Clip _clipBehavior;
  CellPredicate? _frozenColumn;
  CellPredicate? _frozenRow;
  double? _verticalOffset;
  double? _horizontalOffset;
  Size? _viewportSize;

  TableLayoutResult? _layoutResult;

  /// Creates a render object for table layout.
  ///
  /// Initializes the table layout system with sizing functions and optional
  /// frozen cell configurations. This render object handles the complex
  /// layout calculations for tables with variable cell sizes.
  ///
  /// Parameters:
  /// - [children] (`List<RenderBox>?`): Optional initial child render boxes
  /// - [width] (TableSizeSupplier, required): Function providing width for each column
  /// - [height] (TableSizeSupplier, required): Function providing height for each row
  /// - [clipBehavior] (Clip, required): How to clip children outside table bounds
  /// - [frozenCell] (CellPredicate?): Predicate identifying frozen columns
  /// - [frozenRow] (CellPredicate?): Predicate identifying frozen rows
  /// - [verticalOffset] (double?): Vertical scroll offset for viewport
  /// - [horizontalOffset] (double?): Horizontal scroll offset for viewport
  /// - [viewportSize] (Size?): Size of the visible viewport area
  ///
  /// Frozen cells remain visible during scrolling, useful for sticky headers.
  RenderTableLayout(
      {List<RenderBox>? children,
      required TableSizeSupplier width,
      required TableSizeSupplier height,
      required Clip clipBehavior,
      CellPredicate? frozenCell,
      CellPredicate? frozenRow,
      double? verticalOffset,
      double? horizontalOffset,
      Size? viewportSize})
      : _clipBehavior = clipBehavior,
        _width = width,
        _height = height,
        _frozenColumn = frozenCell,
        _frozenRow = frozenRow,
        _verticalOffset = verticalOffset,
        _horizontalOffset = horizontalOffset,
        _viewportSize = viewportSize {
    addAll(children);
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! TableParentData) {
      child.parentData = TableParentData();
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // reverse hit test traversal so that the first child is hit tested last
    // important for column and row spans
    RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      final hit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          return child!.hitTest(result, position: transformed);
        },
      );
      if (hit) {
        return true;
      }
      child = childAfter(child);
    }
    return false;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return computeTableSize(BoxConstraints.loose(Size(double.infinity, height)),
        (child, extent) {
      return child.getMinIntrinsicWidth(extent);
    }).width;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return computeTableSize(constraints).size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // reverse paint traversal so that the first child is painted last
    // important for column and row spans
    // (ASSUMPTION: children are already sorted in the correct order)
    if (_clipBehavior != Clip.none) {
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        (context, offset) {
          RenderBox? child = lastChild;
          while (child != null) {
            final parentData = child.parentData as TableParentData;
            if (parentData.computeSize &&
                !parentData.frozenRow &&
                !parentData.frozenColumn) {
              context.paintChild(child, offset + parentData.offset);
            }
            child = childBefore(child);
          }
        },
        clipBehavior: _clipBehavior,
      );
      RenderBox? child = lastChild;
      while (child != null) {
        final parentData = child.parentData as TableParentData;
        if (!parentData.computeSize &&
            !parentData.frozenRow &&
            !parentData.frozenColumn) {
          context.paintChild(child, offset + parentData.offset);
        }
        child = childBefore(child);
      }
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        (context, offset) {
          RenderBox? child = lastChild;
          while (child != null) {
            final parentData = child.parentData as TableParentData;
            if (parentData.frozenColumn) {
              context.paintChild(child, offset + parentData.offset);
            }
            child = childBefore(child);
          }
        },
        clipBehavior: _clipBehavior,
      );
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        (context, offset) {
          RenderBox? child = lastChild;
          while (child != null) {
            final parentData = child.parentData as TableParentData;
            if (parentData.frozenRow) {
              context.paintChild(child, offset + parentData.offset);
            }
            child = childBefore(child);
          }
        },
        clipBehavior: _clipBehavior,
      );
      child = lastChild;
      while (child != null) {
        final parentData = child.parentData as TableParentData;
        if (!parentData.computeSize && (parentData.frozenColumn)) {
          context.paintChild(child, offset + parentData.offset);
        }
        child = childBefore(child);
      }
      child = lastChild;
      while (child != null) {
        final parentData = child.parentData as TableParentData;
        if (!parentData.computeSize && (parentData.frozenRow)) {
          context.paintChild(child, offset + parentData.offset);
        }
        child = childBefore(child);
      }
      return;
    }
    RenderBox? child = lastChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (!parentData.frozenRow && !parentData.frozenColumn) {
        context.paintChild(child, offset + parentData.offset);
      }
      child = childBefore(child);
    }
    child = lastChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (parentData.frozenColumn) {
        context.paintChild(child, offset + parentData.offset);
      }
      child = childBefore(child);
    }
    child = lastChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (parentData.frozenRow) {
        context.paintChild(child, offset + parentData.offset);
      }
      child = childBefore(child);
    }
  }

  @override
  void performLayout() {

    final result = computeTableSize(constraints);
    size = constraints.constrain(result.size);

    Map<int, double> frozenRows = {};
    Map<int, double> frozenColumns = {};

    double effectiveHorizontalOffset = _horizontalOffset ?? 0;
    double effectiveVerticalOffset = _verticalOffset ?? 0;

    if (_viewportSize != null) {
      double maxHorizontalScroll = max(0, size.width - _viewportSize!.width);
      double maxVerticalScroll = max(0, size.height - _viewportSize!.height);
      effectiveHorizontalOffset =
          effectiveHorizontalOffset.clamp(0, maxHorizontalScroll);
      effectiveVerticalOffset =
          effectiveVerticalOffset.clamp(0, maxVerticalScroll);
    } else {
      effectiveHorizontalOffset = max(0, effectiveHorizontalOffset);
      effectiveVerticalOffset = max(0, effectiveVerticalOffset);
    }

    RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      final column = parentData.column;
      final row = parentData.row;
      if (column != null && row != null) {
        double width = 0;
        double height = 0;
        int columnSpan = parentData.columnSpan ?? 1;
        int rowSpan = parentData.rowSpan ?? 1;
        bool frozenRow = _frozenRow?.call(row, rowSpan) ?? false;
        bool frozenColumn = _frozenColumn?.call(column, columnSpan) ?? false;
        for (int i = 0;
            i < columnSpan && column + i < result.columnWidths.length;
            i++) {
          width += result.columnWidths[column + i];
        }
        for (int i = 0;
            i < rowSpan && row + i < result.rowHeights.length;
            i++) {
          height += result.rowHeights[row + i];
        }
        child.layout(BoxConstraints.tightFor(width: width, height: height));
        final offset = result.getOffset(column, row);
        double offsetX = offset.dx;
        double offsetY = offset.dy;

        if (frozenRow) {
          double verticalOffset = effectiveVerticalOffset;
          double offsetInViewport =
              offsetY - (_viewportSize != null ? verticalOffset : 0);

          // make sure its visible on the viewport
          double minViewport = 0;
          double maxViewport = _viewportSize?.height ?? constraints.maxHeight;
          if (maxViewport == double.infinity) {
            maxViewport = size.height;
          }
          for (int i = 0; i < row; i++) {
            var rowHeight = frozenRows[i] ?? 0;
            minViewport += rowHeight;
          }
          double verticalAdjustment = 0;
          if (_viewportSize != null && verticalOffset < 0) {
            verticalAdjustment = verticalOffset;
          } else if (offsetInViewport < minViewport) {
            verticalAdjustment = -offsetInViewport + minViewport;
          } else if (offsetInViewport + height > maxViewport) {
            // Sticky bottom logic if needed, but for now just top sticking
            // verticalAdjustment = maxViewport - offsetInViewport - height;
          }
          frozenRows[row] = max(frozenRows[row] ?? 0, height);
          offsetY += verticalAdjustment;
        }
        if (frozenColumn) {
          double horizontalOffset = effectiveHorizontalOffset;
          double offsetInViewport =
              offsetX - (_viewportSize != null ? horizontalOffset : 0);

          // make sure its visible on the viewport
          double minViewport = 0;
          double maxViewport = _viewportSize?.width ?? constraints.maxWidth;
          if (maxViewport == double.infinity) {
            maxViewport = size.width;
          }
          for (int i = 0; i < column; i++) {
            var columnWidth = frozenColumns[i] ?? 0;
            minViewport += columnWidth;
          }
          double horizontalAdjustment = 0;
          if (_viewportSize != null && horizontalOffset < 0) {
            horizontalAdjustment = horizontalOffset;
          } else if (offsetInViewport < minViewport) {
            horizontalAdjustment = -offsetInViewport + minViewport;
          } else if (offsetInViewport + width > maxViewport) {
            // Sticky right logic if needed
            // horizontalAdjustment = maxViewport - offsetInViewport - width;
          }
          frozenColumns[column] = max(frozenColumns[column] ?? 0, width);
          offsetX += horizontalAdjustment;
        }
        parentData.frozenRow = frozenRow;
        parentData.frozenColumn = frozenColumn;
        parentData.offset = Offset(offsetX, offsetY);
      }
      child = childAfter(child);
    }

    _layoutResult = result;
  }

  /// Computes the table layout with specified constraints.
  ///
  /// Performs the complex table layout algorithm that:
  /// 1. Determines maximum row and column counts from child cells
  /// 2. Calculates fixed and flexible sizing for all columns and rows
  /// 3. Distributes available space among flex items
  /// 4. Handles both tight and loose flex constraints
  /// 5. Computes final dimensions for each column and row
  ///
  /// The layout algorithm respects size constraints from [TableSize] objects
  /// and ensures cells spanning multiple columns/rows are properly handled.
  ///
  /// Parameters:
  /// - [constraints] (BoxConstraints, required): Layout constraints for the table
  /// - [intrinsicComputer] (IntrinsicComputer?): Optional function to compute intrinsic sizes
  ///
  /// Returns [TableLayoutResult] containing computed dimensions and layout metadata.
  TableLayoutResult computeTableSize(BoxConstraints constraints,
      [IntrinsicComputer? intrinsicComputer]) {
    double flexWidth = 0;
    double flexHeight = 0;
    double fixedWidth = 0;
    double fixedHeight = 0;

    Map<int, double> columnWidths = {};
    Map<int, double> rowHeights = {};

    int maxRow = 0;
    int maxColumn = 0;

    bool hasTightFlexWidth = false;
    bool hasTightFlexHeight = false;

    // find the maximum row and column
    RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (parentData.computeSize) {
        int? column = parentData.column;
        int? row = parentData.row;
        if (column != null && row != null) {
          int columnSpan = parentData.columnSpan ?? 1;
          int rowSpan = parentData.rowSpan ?? 1;
          maxColumn = max(maxColumn, column + columnSpan - 1);
          maxRow = max(maxRow, row + rowSpan - 1);
        }
      }
      child = childAfter(child);
    }

    // micro-optimization: avoid calculating flexes if there are no flexes
    bool hasFlexWidth = false;
    bool hasFlexHeight = false;

    // row
    for (int r = 0; r <= maxRow; r++) {
      final heightConstraint = _height(r);
      if (heightConstraint is FlexTableSize &&
          constraints.hasBoundedHeight &&
          intrinsicComputer == null) {
        flexHeight += heightConstraint.flex;
        hasFlexHeight = true;
        if (heightConstraint.fit == FlexFit.tight) {
          hasTightFlexHeight = true;
        }
      } else if (heightConstraint is FixedTableSize) {
        fixedHeight += heightConstraint.value;
        rowHeights[r] = max(rowHeights[r] ?? 0, heightConstraint.value);
      }
    }
    // column
    for (int c = 0; c <= maxColumn; c++) {
      final widthConstraint = _width(c);
      if (widthConstraint is FlexTableSize && constraints.hasBoundedWidth) {
        flexWidth += widthConstraint.flex;
        hasFlexWidth = true;
        if (widthConstraint.fit == FlexFit.tight) {
          hasTightFlexWidth = true;
        }
      } else if (widthConstraint is FixedTableSize) {
        fixedWidth += widthConstraint.value;
        columnWidths[c] = max(columnWidths[c] ?? 0, widthConstraint.value);
      } else if (widthConstraint is FractionalTableSize &&
          constraints.hasBoundedWidth) {
        double value = widthConstraint.fraction * constraints.maxWidth;
        fixedWidth += value;
        columnWidths[c] = max(columnWidths[c] ?? 0, value);
      }

    }

    double spacePerFlexWidth = 0;
    double spacePerFlexHeight = 0;
    double remainingWidth;
    double remainingHeight;
    if (constraints.hasBoundedWidth) {
      remainingWidth = constraints.maxWidth - fixedWidth;
    } else {
      remainingWidth = double.infinity;
    }
    if (constraints.hasBoundedHeight) {
      remainingHeight = constraints.maxHeight - fixedHeight;
    } else {
      remainingHeight = double.infinity;
    }

    // find the proper intrinsic sizes (if any)
    child = lastChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (parentData.computeSize) {
        int? column = parentData.column;
        int? row = parentData.row;
        if (column != null && row != null) {
          final widthConstraint = _width(column);
          final heightConstraint = _height(row);
          if (widthConstraint is IntrinsicTableSize ||
              (widthConstraint is FlexTableSize && intrinsicComputer != null)) {
            var extent = rowHeights[row] ?? remainingHeight;
            double maxIntrinsicWidth = intrinsicComputer != null
                ? intrinsicComputer(child, extent)
                : child.getMaxIntrinsicWidth(extent);
            maxIntrinsicWidth = min(maxIntrinsicWidth, remainingWidth);
            int columnSpan = parentData.columnSpan ?? 1;
            // distribute the intrinsic width to all columns
            maxIntrinsicWidth = maxIntrinsicWidth / columnSpan;
            for (int i = 0; i < columnSpan; i++) {
              columnWidths[column + i] =
                  max(columnWidths[column + i] ?? 0, maxIntrinsicWidth);
            }
          }
          if (heightConstraint is IntrinsicTableSize ||
              (heightConstraint is FlexTableSize &&
                  intrinsicComputer != null)) {
            var extent = columnWidths[column] ?? remainingWidth;
            double maxIntrinsicHeight = intrinsicComputer != null
                ? intrinsicComputer(child, extent)
                : child.getMaxIntrinsicHeight(extent);
            maxIntrinsicHeight = min(maxIntrinsicHeight, remainingHeight);
            int rowSpan = parentData.rowSpan ?? 1;
            // distribute the intrinsic height to all rows

            maxIntrinsicHeight = maxIntrinsicHeight / rowSpan;
            for (int i = 0; i < rowSpan; i++) {
              rowHeights[row + i] =
                  max(rowHeights[row + i] ?? 0, maxIntrinsicHeight);
            }
          }
        }
      }
      child = childBefore(child);
    }

    double usedColumnWidth = columnWidths.values.fold(0, (a, b) => a + b);
    double usedRowHeight = rowHeights.values.fold(0, (a, b) => a + b);
    double looseRemainingWidth = remainingWidth;
    double looseRemainingHeight = remainingHeight;
    double looseSpacePerFlexWidth = 0;
    double looseSpacePerFlexHeight = 0;

    if (intrinsicComputer == null) {
      // recalculate remaining space for flexes
      if (constraints.hasBoundedWidth) {
        remainingWidth = constraints.maxWidth - usedColumnWidth;
      } else {
        remainingWidth = double.infinity;
      }
      if (constraints.hasInfiniteWidth) {
        looseRemainingWidth = double.infinity;
      } else {
        looseRemainingWidth = max(0, constraints.minWidth - usedColumnWidth);
      }
      if (constraints.hasBoundedHeight) {
        remainingHeight = constraints.maxHeight - usedRowHeight;
      } else {
        remainingHeight = double.infinity;
      }
      if (constraints.hasInfiniteHeight) {
        looseRemainingHeight = double.infinity;
      } else {
        looseRemainingHeight = max(0, constraints.minHeight - usedRowHeight);
      }
      if (flexWidth > 0 && remainingWidth > 0) {
        spacePerFlexWidth = remainingWidth / flexWidth;
      } else {
        spacePerFlexWidth = 0;
      }
      if (flexWidth > 0 && looseRemainingWidth > 0) {
        looseSpacePerFlexWidth = looseRemainingWidth / flexWidth;
      }
      if (flexHeight > 0 && remainingHeight > 0) {
        spacePerFlexHeight = remainingHeight / flexHeight;
      } else {
        spacePerFlexHeight = 0;
      }
      if (flexHeight > 0 && looseRemainingHeight > 0) {
        spacePerFlexHeight = looseRemainingHeight / flexHeight;
      }

      // calculate space used for flexes
      if (hasFlexWidth) {
        for (int c = 0; c <= maxColumn; c++) {
          final widthConstraint = _width(c);
          if (widthConstraint is FlexTableSize) {
            // columnWidths[c] = widthConstraint.flex * spacePerFlexWidth;
            if (widthConstraint.fit == FlexFit.tight || hasTightFlexWidth) {
              columnWidths[c] = widthConstraint.flex * spacePerFlexWidth;
            } else {
              columnWidths[c] = widthConstraint.flex * looseSpacePerFlexWidth;
            }
          }
        }
      }
      if (hasFlexHeight) {
        for (int r = 0; r <= maxRow; r++) {
          final heightConstraint = _height(r);
          if (heightConstraint is FlexTableSize) {
            // rowHeights[r] = heightConstraint.flex * spacePerFlexHeight;
            if (heightConstraint.fit == FlexFit.tight || hasTightFlexHeight) {
              rowHeights[r] = heightConstraint.flex * spacePerFlexHeight;
            } else {
              rowHeights[r] = heightConstraint.flex * looseSpacePerFlexHeight;
            }
          }
        }
      }
    }

    // Second pass: recalculate intrinsic sizes if they depend on flex sizes
    if (intrinsicComputer == null) {
      child = lastChild;
      while (child != null) {
        final parentData = child.parentData as TableParentData;
        if (parentData.computeSize) {
          int? column = parentData.column;
          int? row = parentData.row;
          if (column != null && row != null) {
            final heightConstraint = _height(row);
            // Check if we need to recalculate height (Intrinsic row with Flex/Fixed column)
            if (heightConstraint is IntrinsicTableSize) {
              // If column was Flex, it now has a calculated width in columnWidths
              // If column was Fixed, it's also in columnWidths
              // We can use the actual column width now
              int columnSpan = parentData.columnSpan ?? 1;
              double availableWidth = 0;
              for (int i = 0; i < columnSpan; i++) {
                availableWidth += columnWidths[column + i] ?? 0;
              }

              if (availableWidth > 0) {
                double maxIntrinsicHeight =
                    child.getMaxIntrinsicHeight(availableWidth);
                maxIntrinsicHeight = min(maxIntrinsicHeight, remainingHeight);

                int rowSpan = parentData.rowSpan ?? 1;

                maxIntrinsicHeight = maxIntrinsicHeight / rowSpan;
                for (int i = 0; i < rowSpan; i++) {
                  rowHeights[row + i] =
                      max(rowHeights[row + i] ?? 0, maxIntrinsicHeight);
                }
              }
            }
          }
        }
        child = childBefore(child);
      }
    }

    // convert the column widths and row heights to a list, where missing values are 0
    List<double> columnWidthsList = List.generate(maxColumn + 1, (index) {
      return columnWidths[index] ?? 0;
    });
    columnWidths.forEach((key, value) {
      columnWidthsList[key] = value;
    });
    List<double> rowHeightsList =
        // List.filled(rowHeights.keys.reduce(max) + 1, 0);
        List.generate(maxRow + 1, (index) {
      return rowHeights[index] ?? 0;
    });
    rowHeights.forEach((key, value) {
      rowHeightsList[key] = value;
    });
    return TableLayoutResult(
      columnWidths: columnWidthsList,
      rowHeights: rowHeightsList,
      remainingWidth: remainingWidth,
      remainingHeight: remainingHeight,
      remainingLooseWidth: looseRemainingWidth,
      remainingLooseHeight: looseRemainingHeight,
      hasTightFlexWidth: hasTightFlexWidth,
      hasTightFlexHeight: hasTightFlexHeight,
    );
  }

  @override

  double computeMaxIntrinsicWidth(double height) {
    return computeTableSize(BoxConstraints.loose(Size(double.infinity, height)),
        (child, extent) {
      return child.getMaxIntrinsicWidth(extent);
    }).width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return computeTableSize(BoxConstraints.loose(Size(width, double.infinity)),
        (child, extent) {
      return child.getMinIntrinsicHeight(extent);
    }).height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeTableSize(BoxConstraints.loose(Size(width, double.infinity)),
        (child, extent) {
      return child.getMaxIntrinsicHeight(extent);
    }).height;
  }

  // delegate from TableLayoutResult, with read-only view
  /// Gets an unmodifiable list of computed column widths.
  ///
  /// Returns the width of each column after layout calculation. The list
  /// index corresponds to the column index, and the value is the width in
  /// logical pixels.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns an unmodifiable `List<double>` of column widths.
  List<double> get columnWidths {
    assert(_layoutResult != null, 'Layout result is not available');
    return List.unmodifiable(_layoutResult!.columnWidths);
  }

  /// Gets an unmodifiable list of computed row heights.
  ///
  /// Returns the height of each row after layout calculation. The list
  /// index corresponds to the row index, and the value is the height in
  /// logical pixels.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns an unmodifiable `List<double>` of row heights.
  List<double> get rowHeights {
    assert(_layoutResult != null, 'Layout result is not available');
    return List.unmodifiable(_layoutResult!.rowHeights);
  }

  /// Gets the top-left offset of a cell at the specified position.
  ///
  /// Calculates the cumulative offset by summing the widths of all columns
  /// before the specified column and heights of all rows before the specified row.
  ///
  /// Parameters:
  /// - [column] (int, required): Zero-based column index
  /// - [row] (int, required): Zero-based row index
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns [Offset] representing the cell's top-left corner position.
  Offset getOffset(int column, int row) {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.getOffset(column, row);
  }

  /// Gets the remaining unclaimed width in the table layout.
  ///
  /// This represents horizontal space not allocated to any column after
  /// fixed and flex sizing calculations. Useful for understanding how much
  /// space is available for expansion or debugging layout issues.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining width in logical pixels as a double.
  double get remainingWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingWidth;
  }

  /// Gets the remaining unclaimed height in the table layout.
  ///
  /// This represents vertical space not allocated to any row after
  /// fixed and flex sizing calculations. Useful for understanding how much
  /// space is available for expansion or debugging layout issues.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining height in logical pixels as a double.
  double get remainingHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingHeight;
  }

  /// Gets the remaining loose (flexible) width available for loose flex items.
  ///
  /// Loose flex items can shrink below their flex allocation. This getter
  /// returns the remaining width available specifically for items with
  /// loose flex constraints (FlexFit.loose).
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining loose width in logical pixels as a double.
  double get remainingLooseWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingLooseWidth;
  }

  /// Gets the remaining loose (flexible) height available for loose flex items.
  ///
  /// Loose flex items can shrink below their flex allocation. This getter
  /// returns the remaining height available specifically for items with
  /// loose flex constraints (FlexFit.loose).
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining loose height in logical pixels as a double.
  double get remainingLooseHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingLooseHeight;
  }

  /// Indicates whether any column uses tight flex sizing.
  ///
  /// Tight flex items must occupy their full flex allocation. This getter
  /// returns true if at least one column has a tight flex constraint
  /// (FlexFit.tight), which affects how remaining space is distributed.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns true if table has tight flex width columns, false otherwise.
  bool get hasTightFlexWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.hasTightFlexWidth;
  }

  /// Indicates whether any row uses tight flex sizing.
  ///
  /// Tight flex items must occupy their full flex allocation. This getter
  /// returns true if at least one row has a tight flex constraint
  /// (FlexFit.tight), which affects how remaining space is distributed.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns true if table has tight flex height rows, false otherwise.
  bool get hasTightFlexHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.hasTightFlexHeight;
  }
}

/// Function that computes intrinsic dimensions for a render box.
///
/// Used internally during table layout to calculate natural sizes
/// of cells when using intrinsic sizing modes.
