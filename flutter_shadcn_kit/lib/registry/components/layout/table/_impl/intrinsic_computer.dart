part of '../table.dart';

typedef IntrinsicComputer = double Function(RenderBox child, double extent);

/// Result of table layout calculations.
///
/// Contains computed column widths, row heights, and remaining space
/// information after layout. Used internally by the table rendering system.
