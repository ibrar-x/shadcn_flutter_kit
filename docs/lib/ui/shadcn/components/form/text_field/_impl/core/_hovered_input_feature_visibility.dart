part of '../../text_field.dart';

class _HoveredInputFeatureVisibility extends InputFeatureVisibility {
  const _HoveredInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._statesController;
  }

  @override
  bool canShow(TextFieldState state) {
    return state._statesController.value.hovered;
  }
}
