part of '../sortable.dart';

enum _SortableDropLocation {
  top,
  left,
  right,
  bottom,
}

_SortableDropLocation? _getPosition(Offset position, Size size,
    {bool acceptTop = false,
    bool acceptLeft = false,
    bool acceptRight = false,
    bool acceptBottom = false}) {
  double dx = position.dx;
  double dy = position.dy;
  double width = size.width;
  double height = size.height;
  if (acceptTop && !acceptBottom) {
    return _SortableDropLocation.top;
  } else if (acceptBottom && !acceptTop) {
    return _SortableDropLocation.bottom;
  } else if (acceptLeft && !acceptRight) {
    return _SortableDropLocation.left;
  } else if (acceptRight && !acceptLeft) {
    return _SortableDropLocation.right;
  }
  if (acceptTop && dy <= height / 2) {
    return _SortableDropLocation.top;
  }
  if (acceptLeft && dx <= width / 2) {
    return _SortableDropLocation.left;
  }
  if (acceptRight && dx >= width / 2) {
    return _SortableDropLocation.right;
  }
  if (acceptBottom && dy >= height / 2) {
    return _SortableDropLocation.bottom;
  }
  return null;
}

/// A fallback drop zone for sortable items when dropped outside specific sortable widgets.
///
/// SortableDropFallback provides a catch-all drop zone that can accept sortable
/// items when they're dropped outside of any specific sortable widget drop zones.
/// This is useful for implementing deletion zones, creation areas, or general
/// drop handling areas.
///
/// The widget wraps its child with an invisible hit test layer that can detect
/// and accept dropped sortable items based on configurable acceptance criteria.
///
/// Example:
/// ```dart
/// SortableDropFallback<String>(
///   canAccept: (data) => data.data.startsWith('temp_'),
///   onAccept: (data) => deleteItem(data.data),
///   child: Container(
///     height: 100,
///     child: Center(child: Text('Drop here to delete')),
///   ),
/// )
/// ```
