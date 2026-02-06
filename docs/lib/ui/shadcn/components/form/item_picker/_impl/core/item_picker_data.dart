part of '../../item_picker.dart';

/// Data provided by [ItemPickerDialog] to its descendants.
///
/// Contains the current selection value, change callback, and layout strategy.
/// Used internally for coordinating state across the item picker tree.
class ItemPickerData {
  /// The currently selected value.
  final Object? value;

  /// Callback invoked when the selection changes.
  final ValueChanged<Object?>? onChanged;

  /// The layout strategy being used.
  final ItemPickerLayout layout;

  /// Creates an [ItemPickerData].
  ///
  /// Parameters:
  /// - [value] (`Object?`, optional): Current selection.
  /// - [onChanged] (`ValueChanged<Object?>?`, optional): Change callback.
  /// - [layout] (`ItemPickerLayout`, required): Layout strategy.
  const ItemPickerData({this.value, this.onChanged, required this.layout});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemPickerData) return false;
    return other.value == value &&
        other.onChanged == onChanged &&
        other.layout == layout;
  }

  @override
  int get hashCode => Object.hash(value, onChanged, layout);
}
