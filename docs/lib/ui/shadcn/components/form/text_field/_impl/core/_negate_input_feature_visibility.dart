part of '../../text_field.dart';

class _NegateInputFeatureVisibility extends InputFeatureVisibility {
  final InputFeatureVisibility feature;
  const _NegateInputFeatureVisibility(this.feature);
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) =>
      feature.getDependencies(state);

  @override
  bool canShow(TextFieldState state) => !feature.canShow(state);

  @override
  bool operator ==(Object other) =>
      other is _NegateInputFeatureVisibility && other.feature == feature;

  @override
  int get hashCode => feature.hashCode;
}
