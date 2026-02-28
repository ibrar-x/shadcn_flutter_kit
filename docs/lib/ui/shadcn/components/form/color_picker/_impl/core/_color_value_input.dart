part of '../../color_picker.dart';

/// _ColorValueInput renders form UI and wires input behavior.
class _ColorValueInput extends StatefulWidget {
  /// Current value stored for `value`.
  final String value;

  /// Field storing `placeholder` for this form implementation.
  final Widget? placeholder;

  /// Callback invoked for `onChanged` events.
  final ValueChanged<String>? onChanged;

  /// Field storing `inputFormatters` for this form implementation.
  final List<TextInputFormatter>? inputFormatters;

  /// Field storing `keyboardType` for this form implementation.
  final TextInputType? keyboardType;

  /// Constructs `_ColorValueInput` with the provided parameters.
  const _ColorValueInput({
    required this.value,
    this.placeholder,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
  });

  /// Creates the `State` object for this widget.
  @override
  State<_ColorValueInput> createState() => _ColorValueInputState();
}
