import 'resizable_item.dart';

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
class Resizer {
  /// The list of resizable items being managed.
  final List<ResizableItem> items;

  /// Ratio threshold for collapsing an item (0.0 to 1.0).
  /// When an item gets smaller than `min + (collapsedSize - min) * collapseRatio`,
  /// it will collapse.
  final double collapseRatio;

  /// Ratio threshold for expanding a collapsed item (0.0 to 1.0).
  /// When dragging past `(min - collapsedSize) * expandRatio`,
  /// a collapsed item will expand.
  final double expandRatio;

  /// Creates a resizer for the given [items].
  ///
  /// [collapseRatio] controls when items collapse (defaults to 0.5).
  /// [expandRatio] controls when collapsed items expand (defaults to 0.5).
  Resizer(
    this.items, {
    this.collapseRatio = 0.5, // half of min size
    this.expandRatio = 0.5, // half of max size
  });

  double _couldNotBorrow = 0;

  double _payOffLoanSize(int index, double delta, int direction) {
    if (direction < 0) {
      for (int i = 0; i < index; i++) {
        double borrowedSize = items[i].newValue - items[i].value;
        if (borrowedSize < 0 && delta > 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (newBorrowedSize > 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          items[i].setNewValue(items[i].value + newBorrowedSize);
          return delta;
        } else if (borrowedSize > 0 && delta < 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (newBorrowedSize < 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          items[i].setNewValue(items[i].value + newBorrowedSize);
          return delta;
        }
      }
    } else if (direction > 0) {
      for (int i = items.length - 1; i > index; i--) {
        double borrowedSize = items[i].newValue - items[i].value;
        if (borrowedSize < 0 && delta > 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (newBorrowedSize > 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          items[i].setNewValue(items[i].value + newBorrowedSize);
          return delta;
        } else if (borrowedSize > 0 && delta < 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (newBorrowedSize < 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          items[i].setNewValue(items[i].value + newBorrowedSize);
          return delta;
        }
      }
    }
    return 0;
  }

  ResizableItem? _getItem(int index) {
    if (index < 0 || index >= items.length) {
      return null;
    }
    return items[index];
  }

  _BorrowInfo _borrowSize(int index, double delta, int until, int direction) {
    assert(direction == -1 || direction == 1, 'Direction must be -1 or 1');
    final item = _getItem(index);
    if (item == null) {
      return _BorrowInfo(0, index - direction);
    }
    if (index == until + direction) {
      return _BorrowInfo(0, index);
    }
    if (!item.resizable) {
      return _BorrowInfo(0, index - direction);
    }

    double minSize = item.min;
    double maxSize = item.max;

    if (item.newCollapsed) {
      if ((direction < 0 && delta < 0) || (direction > 0 && delta > 0)) {
        return _borrowSize(index + direction, delta, until, direction);
      }
      return _BorrowInfo(0, index);
    }

    double newSize = item.newValue + delta;

    if (newSize < minSize) {
      double overflow = newSize - minSize;
      double given = delta - overflow;
      var borrowSize =
          _borrowSize(index + direction, overflow, until, direction);
      item.setNewValue(minSize);
      return _BorrowInfo(borrowSize.givenSize + given, borrowSize.from);
    }

    if (newSize > maxSize) {
      double maxOverflow = newSize - maxSize;
      double given = delta - maxOverflow;

      var borrowSize =
          _borrowSize(index + direction, maxOverflow, until, direction);
      item.setNewValue(maxSize);
      return _BorrowInfo(borrowSize.givenSize + given, borrowSize.from);
    }

    item.setNewValue(newSize);
    return _BorrowInfo(delta, index);
  }

  /// Attempts to expand an item at [index] by [delta] in the given [direction].
  ///
  /// [direction] can be -1 (borrow from left), 0 (borrow from both sides),
  /// or 1 (borrow from right).
  /// Returns true if the expansion was successful.
  bool attemptExpand(int index, int direction, double delta) {
    final item = items[index];
    double currentSize = item.newValue; // check
    double minSize = item.min;
    double maxSize = item.max;
    double newSize = currentSize + delta;
    double minOverflow = newSize - minSize;
    double maxOverflow = newSize - maxSize;

    if (minOverflow < 0 && delta < 0) {
      delta = delta - minOverflow;
    }

    if (maxOverflow > 0 && delta > 0) {
      delta = delta - maxOverflow;
    }

    if (delta == 0) {
      return false;
    }

    if (index == 0) {
      direction = 1;
    } else if (index == items.length - 1) {
      direction = -1;
    }
    if (direction < 0) {
      var borrowed = _borrowSize(index - 1, -delta, 0, -1);
      if (borrowed.givenSize != -delta) {
        reset();
        return false;
      }
      item.setNewValue((item.newValue + delta).clamp(minSize, maxSize));
      // check
      return true;
    } else if (direction > 0) {
      var borrowed = _borrowSize(index + 1, -delta, items.length - 1, 1);
      if (borrowed.givenSize != -delta) {
        reset();
        return false;
      }
      item.setNewValue((item.newValue + delta).clamp(minSize, maxSize));
      // check
      return true;
    } else if (direction == 0) {
      double halfDelta = delta / 2;
      var borrowedLeft = _borrowSize(index - 1, -halfDelta, 0, -1);
      var borrowedRight =
          _borrowSize(index + 1, -halfDelta, items.length - 1, 1);
      if (borrowedLeft.givenSize != -halfDelta ||
          borrowedRight.givenSize != -halfDelta) {
        reset();
        return false;
      }
      item.setNewValue((item.newValue + delta).clamp(minSize, maxSize));
      // check
      return true;
    }
    return false;
  }

  /// Attempts to collapse an item at [index] in the given [direction].
  ///
  /// [direction] can be -1 (give space to left), 0 (give to both sides),
  /// or 1 (give space to right).
  /// Returns true if the collapse was successful.
  bool attemptCollapse(int index, int direction) {
    if (index == 0) {
      direction = 1;
    } else if (index == items.length - 1) {
      direction = -1;
    }
    if (direction < 0) {
      final item = items[index];
      final collapsedSize = item.collapsedSize ?? 0;
      final currentSize = item.newValue;
      final delta = currentSize - collapsedSize;
      var borrowed = _borrowSize(index - 1, delta, 0, -1);
      if (borrowed.givenSize != delta) {
        reset();
        return false;
      }
      item.setNewCollapsed(true);
      return true;
    } else if (direction > 0) {
      final item = items[index];
      final collapsedSize = item.collapsedSize ?? 0;
      final delta = item.newValue - collapsedSize;
      var borrowed = _borrowSize(index + 1, delta, items.length - 1, 1);
      if (borrowed.givenSize != delta) {
        reset();
        return false;
      }
      item.setNewCollapsed(true);
      return true;
    } else if (direction == 0) {
      final item = items[index];
      final collapsedSize = item.collapsedSize ?? 0;
      final delta = item.newValue - collapsedSize;
      final halfDelta = delta / 2;
      var borrowedLeft = _borrowSize(index - 1, halfDelta, 0, -1);
      var borrowedRight =
          _borrowSize(index + 1, halfDelta, items.length - 1, 1);
      if (borrowedLeft.givenSize != halfDelta ||
          borrowedRight.givenSize != halfDelta) {
        reset();
        return false;
      }
      item.setNewCollapsed(true);
      return true;
    }
    return false;
  }

  /// Attempts to expand a collapsed item at [index] in the given [direction].
  ///
  /// [direction] can be -1 (borrow from left), 0 (borrow from both sides),
  /// or 1 (borrow from right).
  /// Returns true if the expansion was successful.
  bool attemptExpandCollapsed(int index, int direction) {
    if (index == 0) {
      direction = 1;
    } else if (index == items.length - 1) {
      direction = -1;
    }
    final item = items[index];
    final collapsedSize = item.collapsedSize ?? 0;
    final currentSize = item.newValue;
    final delta = collapsedSize - currentSize;
    if (direction < 0) {
      var borrowed = _borrowSize(index - 1, delta, 0, -1);
      if (borrowed.givenSize != delta) {
        reset();
        return false;
      }
      item.setNewCollapsed(false);
      return true;
    } else if (direction > 0) {
      var borrowed = _borrowSize(index + 1, delta, items.length - 1, 1);
      if (borrowed.givenSize != delta) {
        reset();
        return false;
      }
      item.setNewCollapsed(false);
      return true;
    } else if (direction == 0) {
      final halfDelta = delta / 2;
      var borrowedLeft = _borrowSize(index - 1, halfDelta, 0, -1);
      var borrowedRight =
          _borrowSize(index + 1, halfDelta, items.length - 1, 1);
      if (borrowedLeft.givenSize != halfDelta ||
          borrowedRight.givenSize != halfDelta) {
        reset();
        return false;
      }
      item.setNewCollapsed(false);
      return true;
    }
    return false;
  }

  /// Handles dragging a divider at [index] by [delta] pixels.
  ///
  /// This is the main method for interactive resizing. It redistributes space
  /// between items, handles collapsing/expanding, and respects constraints.
  /// The divider at [index] is between item [index-1] and item [index].
  void dragDivider(int index, double delta) {
    if (delta == 0) {
      return;
    }

    var borrowedLeft = _borrowSize(index - 1, delta, 0, -1);
    var borrowedRight = _borrowSize(index, -delta, items.length - 1, 1);

    double borrowedRightSize = borrowedRight.givenSize;
    double borrowedLeftSize = borrowedLeft.givenSize;

    double couldNotBorrowRight = borrowedRightSize + delta;
    double couldNotBorrowLeft = borrowedLeftSize - delta;

    if (couldNotBorrowLeft != 0 || couldNotBorrowRight != 0) {
      _couldNotBorrow += delta;
    } else {
      _couldNotBorrow = 0;
    }

    double givenBackLeft = 0;
    double givenBackRight = 0;

    if (couldNotBorrowLeft != -couldNotBorrowRight) {
      givenBackLeft =
          _borrowSize(borrowedRight.from, -couldNotBorrowLeft, index, -1)
              .givenSize;
      givenBackRight =
          _borrowSize(borrowedLeft.from, -couldNotBorrowRight, index - 1, 1)
              .givenSize;
    }

    if (givenBackLeft != -couldNotBorrowLeft ||
        givenBackRight != -couldNotBorrowRight) {
      reset();
      return;
    }

    double payOffLeft = _payOffLoanSize(index - 1, delta, -1);
    double payOffRight = _payOffLoanSize(index, -delta, 1);

    double payingBackLeft =
        _borrowSize(index - 1, -payOffLeft, 0, -1).givenSize;
    double payingBackRight =
        _borrowSize(index, -payOffRight, items.length - 1, 1).givenSize;

    if (payingBackLeft != -payOffLeft || payingBackRight != -payOffRight) {
      reset();
      return;
    }

    if (_couldNotBorrow > 0) {
      int start = borrowedRight.from;
      int endNotCollapsed = items.length - 1;
      for (int i = endNotCollapsed; i > start; i--) {
        if (items[i].newCollapsed) {
          endNotCollapsed = i - 1;
        } else {
          break;
        }
      }
      if (start == endNotCollapsed) {
        _checkCollapseUntil(index);
      }
      _checkExpanding(index);
    } else if (_couldNotBorrow < 0) {
      int start = borrowedLeft.from;
      int endNotCollapsed = 0;
      for (int i = endNotCollapsed; i < start; i++) {
        if (items[i].newCollapsed) {
          endNotCollapsed = i + 1;
        } else {
          break;
        }
      }
      if (start == endNotCollapsed) {
        _checkCollapseUntil(index);
      }
      _checkExpanding(index);
    }
  }

  void _checkCollapseUntil(int index) {
    if (_couldNotBorrow < 0) {
      for (int i = index - 1; i >= 0; i--) {
        final previousItem = _getItem(i);
        double? collapsibleSize = previousItem?.collapsedSize;
        if (previousItem != null &&
            collapsibleSize != null &&
            !previousItem.newCollapsed) {
          var minSize = previousItem.min;
          var threshold = (collapsibleSize - minSize) * collapseRatio;
          if (_couldNotBorrow < threshold) {
            var toBorrow = minSize - collapsibleSize;
            var borrowed = _borrowSize(index, toBorrow, items.length - 1, 1);
            double borrowedSize = borrowed.givenSize;
            if (borrowedSize < toBorrow) {
              reset();
              return;
            }
            previousItem.setNewCollapsed(true);
            previousItem.setNewValue(previousItem.collapsedSize ?? 0);
            previousItem.setValue(previousItem.newValue);
            _couldNotBorrow = 0;
          }
        }
      }
    } else {
      for (int i = index; i < items.length; i++) {
        final nextItem = _getItem(i);
        double? collapsibleSize = nextItem?.collapsedSize;
        if (nextItem != null &&
            collapsibleSize != null &&
            !nextItem.newCollapsed) {
          var minSize = nextItem.min;
          var threshold = (collapsibleSize - minSize) * collapseRatio;
          if (_couldNotBorrow > threshold) {
            var toBorrow = minSize - collapsibleSize;
            var borrowed = _borrowSize(index - 1, toBorrow, 0, -1);
            double borrowedSize = borrowed.givenSize;
            if (borrowedSize < toBorrow) {
              reset();
              return;
            }
            nextItem.setNewCollapsed(true);
            nextItem.setNewValue(nextItem.collapsedSize ?? 0);
            nextItem.setValue(nextItem.newValue);
            _couldNotBorrow = 0;
          }
        }
      }
    }
  }

  void _checkExpanding(int index) {
    if (_couldNotBorrow > 0) {
      int toCheck = index - 1;
      for (; toCheck >= 0; toCheck--) {
        final item = _getItem(toCheck);
        double? collapsibleSize = item?.collapsedSize;
        if (item != null && item.newCollapsed && collapsibleSize != null) {
          double minSize = item.min;
          double threshold = (minSize - collapsibleSize) * expandRatio;
          if (_couldNotBorrow >= threshold) {
            double toBorrow = collapsibleSize - minSize;
            var borrowed = _borrowSize(toCheck + 1, toBorrow, items.length, 1);
            double borrowedSize = borrowed.givenSize;
            if (borrowedSize > toBorrow) {
              reset();
              continue;
            }
            item.setNewCollapsed(false);
            item.setNewValue(minSize);
            item.setValue(minSize);
            _couldNotBorrow = 0;
          }
          break;
        }
      }
    } else if (_couldNotBorrow < 0) {
      int toCheck = index;
      for (; toCheck < items.length; toCheck++) {
        final item = _getItem(toCheck);
        double? collapsibleSize = item?.collapsedSize;
        if (item != null && collapsibleSize != null && item.newCollapsed) {
          double minSize = item.min;
          double threshold = (collapsibleSize - minSize) * expandRatio;
          if (_couldNotBorrow <= threshold) {
            double toBorrow = collapsibleSize - minSize;
            var borrowed = _borrowSize(toCheck - 1, toBorrow, -1, -1);
            double borrowedSize = borrowed.givenSize;
            if (borrowedSize > toBorrow) {
              reset();
              continue;
            }
            item.setNewCollapsed(false);
            item.setNewValue(minSize);
            item.setValue(minSize);
            _couldNotBorrow = 0;
          }
          break;
        }
      }
    }
  }

  /// Resets all items to their original state.
  ///
  /// Clears any pending resize operations and restores items to their
  /// original values and collapsed states.
  void reset() {
    for (final item in items) {
      if (item.hasPendingValue) {
        item.resetPending();
      }
    }
  }
}
