part of '../../input.dart';

/// _InputAboveBelowFeatureState stores and manages mutable widget state.
class _InputAboveBelowFeatureState
    extends InputFeatureState<InputAboveBelowFeature> {
  /// Performs `wrap` logic for this form component.
  @override
  Widget wrap(Widget child) {
    final featureChild = feature.child;
    if (featureChild == null) {
      return child;
    }
    if (feature.position == InputFeaturePosition.above) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [featureChild, child],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [child, featureChild],
    );
  }
}
