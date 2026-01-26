part of '../table.dart';

typedef CellPredicate = bool Function(int index, int span);

/// Low-level table layout widget.
///
/// Provides raw table layout functionality with support for frozen rows/columns
/// and scrolling. Used internally by higher-level table widgets.
///
/// Example:
/// ```dart
/// RawTableLayout(
///   width: (index) => FlexTableSize(),
///   height: (index) => FixedTableSize(50),
///   clipBehavior: Clip.hardEdge,
///   children: [...],
/// )
/// ```
