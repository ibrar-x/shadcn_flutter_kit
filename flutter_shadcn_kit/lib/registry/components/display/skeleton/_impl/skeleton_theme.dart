part of '../skeleton.dart';

/// Theme configuration for skeleton loading effects.
class SkeletonTheme extends ComponentThemeData {
  final Duration? duration;
  final Color? fromColor;
  final Color? toColor;
  final bool? enableSwitchAnimation;

  const SkeletonTheme({
    this.duration,
    this.fromColor,
    this.toColor,
    this.enableSwitchAnimation,
  });

  SkeletonTheme copyWith({
    ValueGetter<Duration?>? duration,
    ValueGetter<Color?>? fromColor,
    ValueGetter<Color?>? toColor,
    ValueGetter<bool?>? enableSwitchAnimation,
  }) {
    return SkeletonTheme(
      duration: duration == null ? this.duration : duration(),
      fromColor: fromColor == null ? this.fromColor : fromColor(),
      toColor: toColor == null ? this.toColor : toColor(),
      enableSwitchAnimation: enableSwitchAnimation == null
          ? this.enableSwitchAnimation
          : enableSwitchAnimation(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SkeletonTheme &&
        other.duration == duration &&
        other.fromColor == fromColor &&
        other.toColor == toColor &&
        other.enableSwitchAnimation == enableSwitchAnimation;
  }

  @override
  int get hashCode =>
      Object.hash(duration, fromColor, toColor, enableSwitchAnimation);
}
