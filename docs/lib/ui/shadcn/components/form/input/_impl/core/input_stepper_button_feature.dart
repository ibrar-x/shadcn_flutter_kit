part of '../../input.dart';

/// Adds a single increment button to numeric input fields.
class InputStepperButtonFeature extends InputFeature {
  /// The amount to increment on each press.
  final double step;

  /// Default value when the input is invalid or empty.
  final double? invalidValue;

  /// Position of the increment button.
  final InputFeaturePosition position;

  /// Custom icon for the increment button.
  final Widget? icon;

  /// Creates an [InputStepperButtonFeature].
  const InputStepperButtonFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.step = 1.0,
    this.invalidValue = 0.0,
    this.position = InputFeaturePosition.trailing,
    this.icon = const Icon(LucideIcons.plus),
  });

  /// Creates a decrement button feature for numeric inputs.
  const InputStepperButtonFeature.decrement({
    super.visibility,
    super.skipFocusTraversal,
    this.step = -1.0,
    this.invalidValue = 0.0,
    this.position = InputFeaturePosition.trailing,
    this.icon = const Icon(LucideIcons.minus),
  });

  @override
  InputFeatureState createState() => _InputStepperButtonFeatureState();
}
