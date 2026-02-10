part of '../../multiple_choice.dart';

/// Theme data for [MultipleChoice] and [MultipleAnswer].
class MultipleChoiceTheme extends ComponentThemeData {
  /// Whether selections can be unselected.
  final bool? allowUnselect;

  /// Creates a [MultipleChoiceTheme].
  const MultipleChoiceTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.allowUnselect,
  });

  /// Returns a copy of this theme with the given fields replaced by the
  /// non-null parameters.
  MultipleChoiceTheme copyWith({ValueGetter<bool?>? allowUnselect}) {
    return MultipleChoiceTheme(
      allowUnselect: allowUnselect == null
          ? this.allowUnselect
          : allowUnselect(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MultipleChoiceTheme && other.allowUnselect == allowUnselect;

  @override
  int get hashCode => allowUnselect.hashCode;

  @override
  String toString() => 'MultipleChoiceTheme(allowUnselect: $allowUnselect)';
}
