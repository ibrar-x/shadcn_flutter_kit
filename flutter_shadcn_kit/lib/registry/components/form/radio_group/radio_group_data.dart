part of 'radio_group.dart';

/// Data class holding radio group state information.
///
/// Contains the selected item and enabled state for a radio group.
class RadioGroupData<T> {
  /// The currently selected item value.
  final T? selectedItem;

  /// Whether the radio group is enabled.
  final bool enabled;

  /// Creates radio group data.
  RadioGroupData(this.selectedItem, this.enabled);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioGroupData<T> &&
        other.selectedItem == selectedItem &&
        other.enabled == enabled;
  }

  @override
  int get hashCode => Object.hash(selectedItem, enabled);
}
