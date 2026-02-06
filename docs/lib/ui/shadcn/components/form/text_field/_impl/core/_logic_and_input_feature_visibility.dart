part of '../../text_field.dart';

class _LogicAndInputFeatureVisibility extends InputFeatureVisibility {
  final Iterable<InputFeatureVisibility> features;
  const _LogicAndInputFeatureVisibility(this.features);
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    for (final feature in features) {
      yield* feature.getDependencies(state);
    }
  }

  @override
  bool canShow(TextFieldState state) {
    return features.every((feature) => feature.canShow(state));
  }

  @override
  bool operator ==(Object other) =>
      other is _LogicAndInputFeatureVisibility &&
      other.features.length == features.length &&
      other.features.every((otherFeature) => features.contains(otherFeature));

  @override
  int get hashCode => features.hashCode;
}
