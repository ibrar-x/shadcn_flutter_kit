class ResizableItem {
  double _value;

  /// Minimum size this item can be resized to.
  final double min;

  /// Maximum size this item can be resized to.
  final double max;

  /// Whether this item is currently in collapsed state.
  final bool collapsed;

  /// Size of the item when collapsed. If null, collapsed size is 0.
  final double? collapsedSize;

  /// Whether this item can be resized.
  final bool resizable;
  double? _newValue;
  bool? _newCollapsed;

  /// Creates a resizable item with the given constraints.
  ///
  /// [value] is the initial size of the item.
  /// [min] is the minimum size (defaults to 0).
  /// [max] is the maximum size (defaults to infinity).
  /// [collapsed] indicates if the item starts collapsed.
  /// [collapsedSize] is the size when collapsed (defaults to 0 if null).
  /// [resizable] indicates if the item can be resized (defaults to true).
  ResizableItem({
    required double value,
    this.min = 0,
    this.max = double.infinity,
    this.collapsed = false,
    this.collapsedSize,
    this.resizable = true,
  }) : _value = value;

  /// Whether this item is collapsed after resizing operations.
  bool get newCollapsed => _newCollapsed ?? collapsed;

  /// The size of this item after resizing operations.
  double get newValue {
    return _newValue ?? _value;
  }

  /// The current size of this item before any resize operations.
  double get value {
    return _value;
  }

  bool get hasPendingValue => _newValue != null;

  void setNewValue(double? value) {
    _newValue = value;
  }

  void setNewCollapsed(bool? value) {
    _newCollapsed = value;
  }

  void setValue(double value) {
    _value = value;
  }

  void resetPending() {
    _newValue = null;
    _newCollapsed = null;
  }

  @override
  String toString() {
    return 'ResizableItem(value: $value, min: $min, max: $max)';
  }
}
