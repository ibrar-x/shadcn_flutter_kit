import 'package:data_widget/data_widget.dart';
import 'package:flutter/widgets.dart';

import 'stated_widget.dart';
import '../state/widget_states_data.dart';

class MapStatedWidget extends StatedWidget {
  static final Map<String, WidgetState> _mappedNames =
      WidgetState.values.asNameMap();
  final Map<Object, Widget> states;
  final Widget? child;

  const MapStatedWidget({
    super.key,
    required this.states,
    this.child,
  }) : super.base();

  @override
  Widget build(BuildContext context) {
    WidgetStatesData? statesData = Data.maybeOf<WidgetStatesData>(context);
    Set<WidgetState> widgetStates = statesData?.states ?? {};
    for (var entry in states.entries) {
      final keys = entry.key;
      if (keys is Iterable<WidgetState>) {
        if (widgetStates.containsAll(keys)) {
          return entry.value;
        }
      } else if (keys is WidgetState) {
        if (widgetStates.contains(keys)) {
          return entry.value;
        }
      } else if (keys is String) {
        final state = _mappedNames[keys];
        if (state != null && widgetStates.contains(state)) {
          return entry.value;
        }
      } else {
        assert(false,
            'Invalid key type in states map (${keys.runtimeType}) expected WidgetState, Iterable<WidgetState>, or String');
      }
    }
    return child ?? const SizedBox();
  }
}
