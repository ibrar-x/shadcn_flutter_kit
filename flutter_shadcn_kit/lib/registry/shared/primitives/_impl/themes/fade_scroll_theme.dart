part of '../../fade_scroll.dart';

class FadeScrollTheme extends ComponentThemeData {
  /// The distance from the start before fading begins.
  final double? startOffset;

  /// The distance from the end before fading begins.
  final double? endOffset;

  /// The gradient colors used for the fade.
  final List<Color>? gradient;

  /// Creates a [FadeScrollTheme].
  const FadeScrollTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.startOffset,
    this.endOffset,
    this.gradient,
  });

  /// Creates a copy of this theme but with the given fields replaced.
  FadeScrollTheme copyWith({
    ValueGetter<double?>? startOffset,
    ValueGetter<double?>? endOffset,
    ValueGetter<List<Color>?>? gradient,
  }) {
    return FadeScrollTheme(
      startOffset: startOffset == null ? this.startOffset : startOffset(),
      endOffset: endOffset == null ? this.endOffset : endOffset(),
      gradient: gradient == null ? this.gradient : gradient(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FadeScrollTheme &&
        other.startOffset == startOffset &&
        other.endOffset == endOffset &&
        listEquals(other.gradient, gradient);
  }

  @override
  int get hashCode => Object.hash(startOffset, endOffset, gradient);
}

/// A widget that applies fade effects at the edges of scrollable content.
///
/// Adds gradient fade overlays to the start and end of scrollable content,
/// creating a visual cue that there's more content to scroll.
