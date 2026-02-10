part of '../../input.dart';

/// Adds a custom widget above or below the text input area.
///
/// Use this feature to place helper content directly above or below the field.
class InputAboveBelowFeature extends InputFeature {
  /// Widget shown above or below the input.
  final Widget? child;

  /// Position of the [child] relative to the input.
  final InputFeaturePosition position;

  /// Creates an [InputAboveBelowFeature].
  const InputAboveBelowFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.child,
    this.position = InputFeaturePosition.below,
  });

  /// Creates an [InputAboveBelowFeature] above the input.
  const InputAboveBelowFeature.above(
    this.child, {
    super.visibility,
    super.skipFocusTraversal,
  }) : position = InputFeaturePosition.above;

  /// Creates an [InputAboveBelowFeature] below the input.
  const InputAboveBelowFeature.below(
    this.child, {
    super.visibility,
    super.skipFocusTraversal,
  }) : position = InputFeaturePosition.below;

  @override
  InputFeatureState createState() => _InputAboveBelowFeatureState();
}
