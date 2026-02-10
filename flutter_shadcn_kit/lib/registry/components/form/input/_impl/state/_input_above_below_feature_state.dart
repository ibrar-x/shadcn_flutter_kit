part of '../../input.dart';

class _InputAboveBelowFeatureState
    extends InputFeatureState<InputAboveBelowFeature> {
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
