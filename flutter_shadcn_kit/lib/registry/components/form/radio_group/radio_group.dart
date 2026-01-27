import 'package:data_widget/data_widget.dart';
import 'package:flutter/widgets.dart';

import '../../../shared/primitives/focus_outline.dart';
import '../../../shared/primitives/form_control.dart';
import '../../../shared/primitives/form_value_supplier.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/color_extensions.dart';
import '../../../shared/utils/constants.dart';
import '../../../shared/utils/style_value.dart';
import '../../layout/card/card.dart';

part 'radio_theme.dart';


part '_radio_card_state.dart';
part '_radio_item_state.dart';
part 'controlled_radio_group.dart';
part 'next_item_intent.dart';
part 'previous_item_intent.dart';
part 'radio.dart';
part 'radio_card.dart';
part 'radio_card_theme.dart';
part 'radio_group_controller.dart';
part 'radio_group_data.dart';
part 'radio_group_state.dart';
part 'radio_item.dart';
























/// A group of radio buttons for single-selection input.
///
/// Manages the selection state and provides context for child radio items.
class RadioGroup<T> extends StatefulWidget {
  /// The child widget containing radio items.
  final Widget child;

  /// The currently selected value.
  final T? value;

  /// Callback invoked when the selection changes.
  final ValueChanged<T>? onChanged;

  /// Whether the radio group is enabled.
  final bool? enabled;

  /// Creates a radio group.
  const RadioGroup({
    super.key,
    required this.child,
    this.value,
    this.onChanged,
    this.enabled,
  });

  @override
  RadioGroupState<T> createState() => RadioGroupState<T>();
}
