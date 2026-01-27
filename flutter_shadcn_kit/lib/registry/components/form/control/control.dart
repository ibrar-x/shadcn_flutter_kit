import 'package:flutter/widgets.dart';

part '_controlled_component_adapter_state.dart';
part 'component_value_controller.dart';
part 'controlled_component.dart';
part 'controlled_component_adapter.dart';
part 'controlled_component_data.dart';


/// A mixin that defines the interface for controlling component values.
///
/// This mixin combines the capabilities of [ValueNotifier] to provide
/// a standardized way for widgets to expose their current value and
/// notify listeners of changes. Components that implement this interface
/// can be controlled programmatically and integrated with form validation
/// systems.
///
/// The generic type [T] represents the type of value this controller manages.
mixin ComponentController<T> implements ValueNotifier<T> {}
