import 'package:data_widget/data_widget.dart';
import 'package:flutter/widgets.dart';

import 'stated_widget.dart';
import '../state/widget_states_data.dart';

class BuilderStatedWidget extends StatedWidget {
  final Widget Function(BuildContext context, Set<WidgetState> states) builder;

  const BuilderStatedWidget({
    super.key,
    required this.builder,
  }) : super.base();

  @override
  Widget build(BuildContext context) {
    WidgetStatesData? statesData = Data.maybeOf(context);
    Set<WidgetState> states = statesData?.states ?? {};
    return builder(context, states);
  }
}
