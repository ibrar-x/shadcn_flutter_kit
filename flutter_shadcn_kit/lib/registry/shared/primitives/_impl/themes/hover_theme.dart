part of '../../hover.dart';

class HoverTheme extends ComponentThemeData {
  /// Debounce duration for repeated hover events.
  final Duration? debounceDuration;

  /// Hit test behavior for hover detection.
  final HitTestBehavior? hitTestBehavior;

  /// Wait duration before showing hover feedback.
  final Duration? waitDuration;

  /// Minimum duration to keep hover feedback visible.
  final Duration? minDuration;

  /// Duration for hover feedback show animations.
  final Duration? showDuration;

  const HoverTheme({
    this.debounceDuration,
    this.hitTestBehavior,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
  });

  HoverTheme copyWith({
    ValueGetter<Duration?>? debounceDuration,
    ValueGetter<HitTestBehavior?>? hitTestBehavior,
    ValueGetter<Duration?>? waitDuration,
    ValueGetter<Duration?>? minDuration,
    ValueGetter<Duration?>? showDuration,
  }) {
    return HoverTheme(
      debounceDuration:
          debounceDuration == null ? this.debounceDuration : debounceDuration(),
      hitTestBehavior:
          hitTestBehavior == null ? this.hitTestBehavior : hitTestBehavior(),
      waitDuration: waitDuration == null ? this.waitDuration : waitDuration(),
      minDuration: minDuration == null ? this.minDuration : minDuration(),
      showDuration: showDuration == null ? this.showDuration : showDuration(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HoverTheme &&
        other.debounceDuration == debounceDuration &&
        other.hitTestBehavior == hitTestBehavior &&
        other.waitDuration == waitDuration &&
        other.minDuration == minDuration &&
        other.showDuration == showDuration;
  }

  @override
  int get hashCode => Object.hash(
        debounceDuration,
        hitTestBehavior,
        waitDuration,
        minDuration,
        showDuration,
      );
}

/// Tracks mouse hover state and triggers callbacks.
