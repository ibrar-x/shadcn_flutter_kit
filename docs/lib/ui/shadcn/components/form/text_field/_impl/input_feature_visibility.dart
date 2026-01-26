part of '../text_field.dart';

abstract class InputFeatureVisibility {
  /// Creates a visibility condition that is true when all [features] are true.
  const factory InputFeatureVisibility.and(
    Iterable<InputFeatureVisibility> features,
  ) = _LogicAndInputFeatureVisibility;

  /// Creates a visibility condition that is true when any [features] is true.
  const factory InputFeatureVisibility.or(
    Iterable<InputFeatureVisibility> features,
  ) = _LogicOrInputFeatureVisibility;

  /// Creates a visibility condition that inverts the given [feature].
  const factory InputFeatureVisibility.not(InputFeatureVisibility feature) =
      _NegateInputFeatureVisibility;

  /// Visibility condition: text field is not empty.
  static const InputFeatureVisibility textNotEmpty =
      _TextNotEmptyInputFeatureVisibility();

  /// Visibility condition: text field is empty.
  static const InputFeatureVisibility textEmpty =
      _TextEmptyInputFeatureVisibility();

  /// Visibility condition: text field has focus.
  static const InputFeatureVisibility focused =
      _FocusedInputFeatureVisibility();

  /// Visibility condition: text field is being hovered.
  static const InputFeatureVisibility hovered =
      _HoveredInputFeatureVisibility();

  /// Visibility condition: never visible.
  static const InputFeatureVisibility never =
      _NeverVisibleInputFeatureVisibility();

  /// Visibility condition: always visible.
  static const InputFeatureVisibility always =
      _AlwaysVisibleInputFeatureVisibility();

  /// Visibility condition: text field has selected text.
  static const InputFeatureVisibility hasSelection =
      _HasSelectionInputFeatureVisibility();

  /// Creates an [InputFeatureVisibility].
  const InputFeatureVisibility();

  /// Gets the listenable dependencies for this visibility condition.
  ///
  /// Returns the state objects that should be monitored for changes.
  Iterable<Listenable> getDependencies(TextFieldState state);

  /// Checks if the feature can be shown in the current state.
  ///
  /// Returns `true` if all visibility conditions are met.
  bool canShow(TextFieldState state);

  /// Combines this visibility with [other] using logical AND.
  InputFeatureVisibility and(InputFeatureVisibility other) =>
      InputFeatureVisibility.and([this, other]);

  /// Operator form of [and]. Combines conditions with logical AND.
  InputFeatureVisibility operator &(InputFeatureVisibility other) => and(other);

  /// Combines this visibility with [other] using logical OR.
  InputFeatureVisibility or(InputFeatureVisibility other) =>
      InputFeatureVisibility.or([this, other]);

  /// Operator form of [or]. Combines conditions with logical OR.
  InputFeatureVisibility operator |(InputFeatureVisibility other) => or(other);

  /// Inverts this visibility condition using logical NOT.
  InputFeatureVisibility operator ~() => InputFeatureVisibility.not(this);
}

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

class _LogicOrInputFeatureVisibility extends InputFeatureVisibility {
  final Iterable<InputFeatureVisibility> features;
  const _LogicOrInputFeatureVisibility(this.features);
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    for (final feature in features) {
      yield* feature.getDependencies(state);
    }
  }

  @override
  bool canShow(TextFieldState state) {
    return features.any((feature) => feature.canShow(state));
  }

  @override
  bool operator ==(Object other) =>
      other is _LogicOrInputFeatureVisibility &&
      other.features.length == features.length &&
      other.features.every((otherFeature) => features.contains(otherFeature));

  @override
  int get hashCode => features.hashCode;
}

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

class _TextNotEmptyInputFeatureVisibility extends InputFeatureVisibility {
  const _TextNotEmptyInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._effectiveText;
  }

  @override
  bool canShow(TextFieldState state) {
    return state._effectiveText.value.isNotEmpty;
  }
}

class _TextEmptyInputFeatureVisibility extends InputFeatureVisibility {
  const _TextEmptyInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._effectiveText;
  }

  @override
  bool canShow(TextFieldState state) {
    return state._effectiveText.value.isEmpty;
  }
}

class _HasSelectionInputFeatureVisibility extends InputFeatureVisibility {
  const _HasSelectionInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._effectiveSelection;
  }

  @override
  bool canShow(TextFieldState state) {
    var selection = state._effectiveSelection.value;
    return selection.isValid && selection.start != selection.end;
  }
}

class _FocusedInputFeatureVisibility extends InputFeatureVisibility {
  const _FocusedInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._effectiveFocusNode;
  }

  @override
  bool canShow(TextFieldState state) {
    return state._effectiveFocusNode.hasFocus;
  }
}

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

class _NeverVisibleInputFeatureVisibility extends InputFeatureVisibility {
  const _NeverVisibleInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {}

  @override
  bool canShow(TextFieldState state) => false;
}

class _AlwaysVisibleInputFeatureVisibility extends InputFeatureVisibility {
  const _AlwaysVisibleInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {}

  @override
  bool canShow(TextFieldState state) => true;
}

/// Abstract factory for creating input field feature components.
///
/// Provides factory constructors for common text field features like password
/// toggles, clear buttons, hints, autocomplete, and spinners. Features can be
/// conditionally shown based on field state using [InputFeatureVisibility].
///
/// Example:
/// ```dart
/// TextField(
///   leading: [
///     InputFeature.hint(
///       popupBuilder: (context) => Text('Enter email'),
///     ),
///   ],
///   trailing: [
///     InputFeature.clear(),
///     InputFeature.passwordToggle(),
///   ],
/// )
/// ```
