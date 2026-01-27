part of '../../resizer.dart';


class _BorrowInfo {
  final double givenSize;
  final int from;

  _BorrowInfo(this.givenSize, this.from);
}

/// Manages the resizing of multiple [ResizableItem]s in a layout.
///
/// This class handles complex resize operations including:
/// - Dragging dividers between items
/// - Expanding and collapsing items
/// - Borrowing and redistributing space between items
/// - Respecting min/max constraints
