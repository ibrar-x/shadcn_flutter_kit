import 'dart:math';

import 'package:data_widget/data_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../primitives/form_control.dart';
import '../primitives/form_value_supplier.dart';

part '_impl/core/bi_directional_convert.dart';
part '_impl/core/cached_value_widget.dart';
part '_impl/core/callback_context_action.dart';
part '_impl/core/captured_wrapper.dart';
part '_impl/core/context_callback_action.dart';
part '_impl/core/form_pending_builder.dart';
part '_impl/core/repeated_animation_builder.dart';
part '_impl/core/separated_flex.dart';
part '_impl/core/time_of_day.dart';
part '_impl/state/__cached_value_widget_state.dart';
part '_impl/state/__captured_wrapper_state.dart';
part '_impl/state/__repeated_animation_builder_state.dart';
part '_impl/state/__separated_flex_state.dart';
part '_impl/utils/converted_controller.dart';

typedef Predicate<T> = bool Function(T value);
typedef UnaryOperator<T> = T Function(T value);
typedef ContextedCallback = void Function(BuildContext context);
typedef ContextedValueChanged<T> = void Function(BuildContext context, T value);
typedef SearchPredicate<T> = double Function(T value, String query);

/// Mixin for values that need custom rebuild logic.
mixin CachedValue {
  /// Determines if the widget should rebuild when value changes.
  bool shouldRebuild(covariant CachedValue oldValue);
}

/// A widget that caches a computed value.
