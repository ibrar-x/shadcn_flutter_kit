part of '../../clickable.dart';

class WidgetStatesData {
  /// The set of current widget states.
  ///
  /// Common states include [WidgetState.hovered], [WidgetState.pressed],
  /// [WidgetState.focused], [WidgetState.disabled], and [WidgetState.selected].
  final Set<WidgetState> states;

  /// Creates widget states data with the specified states.
  const WidgetStatesData(this.states);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WidgetStatesData && setEquals(states, other.states);
  }

  @override
  int get hashCode => states.hashCode;

  @override
  String toString() => 'WidgetStatesData(states: $states)';
}
