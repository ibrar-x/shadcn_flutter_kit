part of '../table.dart';

typedef TableSizeSupplier = TableSize Function(int index);

/// Custom render object for laying out table cells with advanced features.
///
/// Provides a sophisticated table layout system with support for:
/// - Flexible and fixed column widths and row heights
/// - Frozen columns and rows (sticky headers/footers)
/// - Viewport-based scrolling and clipping
/// -Span cells (cells that span multiple columns/rows)
/// - Dynamic sizing based on content or constraints
///
/// This render object handles the complex layout calculations needed for
/// tables with variable-sized cells, scrolling, and frozen regions.
///
/// See also:
/// - [TableSize], which defines sizing strategies for columns and rows
/// - [TableLayoutResult], which contains the computed layout dimensions
