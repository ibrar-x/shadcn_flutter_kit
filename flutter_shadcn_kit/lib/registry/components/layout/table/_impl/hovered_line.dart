part of '../table.dart';

class _HoveredLine {
  final int index;
  final Axis direction;

  _HoveredLine(this.index, this.direction);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _HoveredLine &&
        other.index == index &&
        other.direction == direction;
  }

  @override
  int get hashCode {
    return Object.hash(index, direction);
  }
}

/// Controller for managing resizable table column and row dimensions.
///
/// Provides programmatic control over table column widths and row heights
/// with support for constraints, default sizes, and interactive resizing.
/// Extends [ChangeNotifier] to notify listeners when dimensions change.
///
/// Example:
/// ```dart
/// final controller = ResizableTableController(
///   defaultColumnWidth: 100.0,
///   defaultRowHeight: 40.0,
///   columnWidths: {0: 150.0, 2: 200.0},
///   widthConstraints: {1: ConstrainedTableSize(min: 50, max: 300)},
/// );
/// ```
