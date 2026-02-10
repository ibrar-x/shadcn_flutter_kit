part of '../../hidden.dart';

class HiddenTheme extends ComponentThemeData {
  final Axis? direction;
  final Duration? duration;
  final Curve? curve;
  final bool? reverse;
  final bool? keepCrossAxisSize;
  final bool? keepMainAxisSize;

  const HiddenTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.direction,
    this.duration,
    this.curve,
    this.reverse,
    this.keepCrossAxisSize,
    this.keepMainAxisSize,
  });

  HiddenTheme copyWith({
    ValueGetter<Axis?>? direction,
    ValueGetter<Duration?>? duration,
    ValueGetter<Curve?>? curve,
    ValueGetter<bool?>? reverse,
    ValueGetter<bool?>? keepCrossAxisSize,
    ValueGetter<bool?>? keepMainAxisSize,
  }) {
    return HiddenTheme(
      direction: direction == null ? this.direction : direction(),
      duration: duration == null ? this.duration : duration(),
      curve: curve == null ? this.curve : curve(),
      reverse: reverse == null ? this.reverse : reverse(),
      keepCrossAxisSize: keepCrossAxisSize == null
          ? this.keepCrossAxisSize
          : keepCrossAxisSize(),
      keepMainAxisSize: keepMainAxisSize == null
          ? this.keepMainAxisSize
          : keepMainAxisSize(),
    );
  }
}

/// A widget that conditionally hides its child with optional animation.
