import 'package:flutter/widgets.dart';

import '../styles/button_style_class.dart';
import '../state/toggle_state.dart';

class Toggle extends StatefulWidget {
  /// The current toggle state (on/off).
  final bool value;

  /// Called when the toggle state changes.
  ///
  /// If `null`, the toggle is considered disabled and won't respond to user input.
  final ValueChanged<bool>? onChanged;

  /// The widget displayed inside the toggle button.
  final Widget child;

  /// The visual style for the button.
  ///
  /// Defaults to ghost style for a subtle appearance.
  final ButtonStyle style;

  /// Whether the toggle button is enabled.
  ///
  /// If `null`, the button is enabled only when [onChanged] is not `null`.
  final bool? enabled;

  /// Creates a [Toggle].
  ///
  /// The toggle button maintains its own state and calls [onChanged] when
  /// the state changes. Uses ghost button styling by default.
  ///
  /// Parameters:
  /// - [value] (bool, required): current toggle state
  /// - [onChanged] (`ValueChanged<bool>?`, optional): callback when state changes
  /// - [child] (Widget, required): content displayed inside the button
  /// - [enabled] (bool?, optional): whether button is interactive
  /// - [style] (ButtonStyle, default: ghost): button styling
  ///
  /// Example:
  /// ```dart
  /// Toggle(
  ///   value: isToggled,
  ///   onChanged: (value) => setState(() => isToggled = value),
  ///   child: Row(
  ///     children: [
  ///       Icon(Icons.notifications),
  ///       Text('Notifications'),
  ///     ],
  ///   ),
  /// )
  /// ```
  const Toggle({
    super.key,
    required this.value,
    this.onChanged,
    required this.child,
    this.enabled,
    this.style = const ButtonStyle.ghost(),
  });

  @override
  ToggleState createState() => ToggleState();
}

// toggle button is just ghost button
/// State class for [Toggle] that manages the toggle behavior and form integration.
///
/// This state class handles:
/// - Maintaining widget states (selected, pressed, hovered, etc.)
/// - Form value integration via [FormValueSupplier]
/// - Updating the selected state based on the toggle value
