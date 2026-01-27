import 'package:data_widget/data_widget.dart';
import 'package:flutter/widgets.dart';

import '../../../shared/primitives/form_control.dart';
import '../../../shared/primitives/form_value_supplier.dart';
import '../../../shared/theme/theme.dart';

part 'multiple_choice_theme.dart';


part '_multiple_answer_state.dart';
part '_multiple_choice_state.dart';
part 'choice.dart';
part 'controlled_multiple_answer.dart';
part 'controlled_multiple_choice.dart';
part 'multiple_answer.dart';
part 'multiple_answer_controller.dart';
part 'multiple_choice_controller.dart';














/// A widget for single-selection choice scenarios.
///
/// [MultipleChoice] manages a single selected value from multiple options.
/// It prevents multiple selections and optionally allows deselecting the
/// current choice by clicking it again.
///
/// This widget is typically used with choice items like [ChoiceChip] or
/// [ChoiceButton] which integrate with the inherited [Choice] data.
///
/// Example:
/// ```dart
/// MultipleChoice<String>(
///   value: selectedOption,
///   onChanged: (value) => setState(() => selectedOption = value),
///   child: Wrap(
///     children: [
///       ChoiceChip(value: 'A', child: Text('Option A')),
///       ChoiceChip(value: 'B', child: Text('Option B')),
///     ],
///   ),
/// )
/// ```
class MultipleChoice<T> extends StatefulWidget {
  /// The child widget tree containing choice items.
  final Widget child;

  /// The currently selected value.
  final T? value;

  /// Callback when the selection changes.
  final ValueChanged<T?>? onChanged;

  /// Whether choices are enabled.
  final bool? enabled;

  /// Whether the current selection can be unselected.
  final bool? allowUnselect;

  /// Creates a [MultipleChoice].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget tree with choice items.
  /// - [value] (`T?`, optional): Currently selected value.
  /// - [onChanged] (`ValueChanged<T?>?`, optional): Selection callback.
  /// - [enabled] (`bool?`, optional): Whether choices are enabled.
  /// - [allowUnselect] (`bool?`, optional): Allow deselecting the current choice.
  const MultipleChoice({
    super.key,
    required this.child,
    this.value,
    this.onChanged,
    this.enabled,
    this.allowUnselect,
  });

  @override
  State<MultipleChoice<T>> createState() => _MultipleChoiceState<T>();
}
