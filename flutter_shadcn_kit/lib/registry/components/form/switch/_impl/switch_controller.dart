part of '../switch.dart';

/// Controller for managing switch state.
class SwitchController extends ValueNotifier<bool>
    with ComponentController<bool> {
  SwitchController([super.value = false]);

  void toggle() {
    value = !value;
  }
}
