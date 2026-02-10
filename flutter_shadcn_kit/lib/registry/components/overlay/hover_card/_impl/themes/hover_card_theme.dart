part of '../../hover_card.dart';

/// Theme configuration for hover card behavior and appearance.
class HoverCardTheme extends ComponentThemeData {
  final Duration? debounce;
  final Duration? wait;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? anchorAlignment;
  final Offset? popoverOffset;
  final HitTestBehavior? behavior;

  const HoverCardTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.debounce,
    this.wait,
    this.popoverAlignment,
    this.anchorAlignment,
    this.popoverOffset,
    this.behavior,
  });

  HoverCardTheme copyWith({
    ValueGetter<Duration?>? debounce,
    ValueGetter<Duration?>? wait,
    ValueGetter<AlignmentGeometry?>? popoverAlignment,
    ValueGetter<AlignmentGeometry?>? anchorAlignment,
    ValueGetter<Offset?>? popoverOffset,
    ValueGetter<HitTestBehavior?>? behavior,
  }) {
    return HoverCardTheme(
      debounce: debounce == null ? this.debounce : debounce(),
      wait: wait == null ? this.wait : wait(),
      popoverAlignment: popoverAlignment == null
          ? this.popoverAlignment
          : popoverAlignment(),
      anchorAlignment: anchorAlignment == null
          ? this.anchorAlignment
          : anchorAlignment(),
      popoverOffset: popoverOffset == null
          ? this.popoverOffset
          : popoverOffset(),
      behavior: behavior == null ? this.behavior : behavior(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HoverCardTheme &&
        other.debounce == debounce &&
        other.wait == wait &&
        other.popoverAlignment == popoverAlignment &&
        other.anchorAlignment == anchorAlignment &&
        other.popoverOffset == popoverOffset &&
        other.behavior == behavior;
  }

  @override
  int get hashCode => Object.hash(
    debounce,
    wait,
    popoverAlignment,
    anchorAlignment,
    popoverOffset,
    behavior,
  );
}
