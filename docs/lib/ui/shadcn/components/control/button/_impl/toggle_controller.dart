part of '../button.dart';

/// A controller for managing toggle state in toggle buttons and switches.
///
/// [ToggleController] extends [ValueNotifier] to provide reactive state management
/// for boolean toggle values. It implements [ComponentController] to integrate
/// with the shadcn_flutter form system and provides convenient methods for
/// programmatic state changes.
///
/// The controller maintains a boolean value representing the toggle state and
/// notifies listeners when the state changes, making it suitable for use with
/// toggle buttons, switches, and other binary state controls.
///
/// Example:
/// ```dart
/// final toggleController = ToggleController(false);
///
/// // Listen to changes
/// toggleController.addListener(() {
///   print('Toggle state: ${toggleController.value}');
/// });
///
/// // Toggle the state programmatically
/// toggleController.toggle();
///
/// // Set specific value
/// toggleController.value = true;
/// ```
class ToggleController extends ValueNotifier<bool>
    with ComponentController<bool> {
  /// Creates a [ToggleController] with an initial toggle state.
  ///
  /// Parameters:
  /// - [value] (bool, default: false): The initial toggle state.
  ///
  /// Example:
  /// ```dart
  /// // Create controller starting in off state
  /// final controller = ToggleController();
  ///
  /// // Create controller starting in on state
  /// final controller = ToggleController(true);
  /// ```
  ToggleController([super.value = false]);

  /// Toggles the current boolean state.
  ///
  /// Changes `true` to `false` and `false` to `true`, then notifies all listeners
  /// of the change. This is equivalent to setting `value = !value` but provides
  /// a more semantic API for toggle operations.
  ///
  /// Example:
  /// ```dart
  /// final controller = ToggleController(false);
  /// controller.toggle(); // value is now true
  /// controller.toggle(); // value is now false
  /// ```
  void toggle() {
    value = !value;
  }
}

/// A controlled version of [Toggle] that integrates with form state management.
///
/// [ControlledToggle] implements the [ControlledComponent] mixin to provide
/// automatic form integration, validation, and state management. It serves as
/// a bridge between external state management (via [ToggleController] or
/// [onChanged] callbacks) and the underlying [Toggle] widget.
///
/// This widget is ideal for use in forms where the toggle state needs to be
/// managed externally, validated, or persisted. It automatically handles the
/// conversion between controlled and uncontrolled modes based on the provided
/// parameters.
///
/// Example:
/// ```dart
/// final controller = ToggleController(false);
///
/// ControlledToggle(
///   controller: controller,
///   child: Row(
///     children: [
///       Icon(Icons.notifications),
///       Text('Enable notifications'),
///     ],
///   ),
/// );
/// ```
class ControlledToggle extends StatelessWidget with ControlledComponent<bool> {
  /// The initial toggle state when no controller is provided.
  ///
  /// Used only in uncontrolled mode. If both [controller] and [initialValue]
  /// are provided, [controller] takes precedence.
  @override
  final bool? initialValue;

  /// Callback invoked when the toggle state changes.
  ///
  /// Called with the new boolean value whenever the user toggles the button.
  /// If null, the toggle becomes read-only (though it can still be controlled
  /// via [controller] if provided).
  @override
  final ValueChanged<bool>? onChanged;

  /// Whether the toggle is interactive.
  ///
  /// When false, the toggle appears disabled and doesn't respond to user input.
  /// The toggle can still be changed programmatically via [controller].
  @override
  final bool enabled;

  /// Controller for managing toggle state externally.
  ///
  /// When provided, the toggle operates in controlled mode and its state is
  /// managed entirely by this controller. Changes are reflected immediately
  /// and [onChanged] is called when the user interacts with the toggle.
  @override
  final ToggleController? controller;

  /// The child widget to display inside the toggle button.
  ///
  /// Typically contains text, icons, or a combination of both. The child
  /// receives the visual styling and interaction behavior of the toggle button.
  final Widget child;

  /// Visual styling for the toggle button.
  ///
  /// Defines the appearance, colors, padding, and other visual characteristics
  /// of the toggle. Defaults to ghost button style with subtle appearance changes
  /// between toggled and untoggled states.
  final ButtonStyle style;

  /// Creates a [ControlledToggle] widget.
  ///
  /// Parameters:
  /// - [controller] (ToggleController?, optional): External state controller.
  /// - [initialValue] (bool?, optional): Initial state for uncontrolled mode.
  /// - [onChanged] (`ValueChanged<bool>?`, optional): State change callback.
  /// - [enabled] (bool, default: true): Whether the toggle is interactive.
  /// - [child] (Widget, required): Content to display in the toggle button.
  /// - [style] (ButtonStyle, default: ButtonStyle.ghost()): Visual styling.
  ///
  /// Example:
  /// ```dart
  /// ControlledToggle(
  ///   initialValue: false,
  ///   onChanged: (value) => print('Toggled: $value'),
  ///   enabled: true,
  ///   style: ButtonStyle.secondary(),
  ///   child: Text('Toggle Me'),
  /// );
  /// ```
  const ControlledToggle({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    required this.child,
    this.style = const ButtonStyle.ghost(),
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Toggle(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          style: style,
          child: child,
        );
      },
    );
  }
}
