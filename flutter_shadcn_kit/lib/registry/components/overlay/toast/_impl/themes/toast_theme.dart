part of '../../toast.dart';

/// Theme data for toast notifications.
class ToastTheme extends ComponentThemeData {
  /// Stores `padding` state/configuration for this implementation.
  final EdgeInsetsGeometry? padding;

  /// Stores `margin` state/configuration for this implementation.
  final double? margin;

  /// Stores `duration` state/configuration for this implementation.
  final Duration? duration;

  /// Stores `animationDuration` state/configuration for this implementation.
  final Duration? animationDuration;

  /// Stores `animationCurve` state/configuration for this implementation.
  final Curve? animationCurve;

  /// Stores `width` state/configuration for this implementation.
  final double? width;

  /// Stores `borderRadius` state/configuration for this implementation.
  final double? borderRadius;

  /// Stores `backgroundColor` state/configuration for this implementation.
  final Color? backgroundColor;

  /// Stores `pauseOnHover` state/configuration for this implementation.
  final bool? pauseOnHover;

  /// Stores `dismissDirections` state/configuration for this implementation.
  final Set<ToastSwipeDirection>? dismissDirections;

  /// Stores `dismissDragThreshold` state/configuration for this implementation.
  final double? dismissDragThreshold;

  /// Creates a `ToastTheme` instance.
  const ToastTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.padding,
    this.margin,
    this.duration,
    this.animationDuration,
    this.animationCurve,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.pauseOnHover,
    this.dismissDirections,
    this.dismissDragThreshold,
  });

  /// Creates a `ToastTheme` instance.
  ToastTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<double?>? margin,
    ValueGetter<Duration?>? duration,
    ValueGetter<Duration?>? animationDuration,
    ValueGetter<Curve?>? animationCurve,
    ValueGetter<double?>? width,
    ValueGetter<double?>? borderRadius,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<bool?>? pauseOnHover,
    ValueGetter<Set<ToastSwipeDirection>?>? dismissDirections,
    ValueGetter<double?>? dismissDragThreshold,
  }) {
    return ToastTheme(
      padding: padding == null ? this.padding : padding(),
      margin: margin == null ? this.margin : margin(),
      duration: duration == null ? this.duration : duration(),
      animationDuration: animationDuration == null
          ? this.animationDuration
          : animationDuration(),
      animationCurve: animationCurve == null
          ? this.animationCurve
          : animationCurve(),
      width: width == null ? this.width : width(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      backgroundColor: backgroundColor == null
          ? this.backgroundColor
          : backgroundColor(),
      pauseOnHover: pauseOnHover == null ? this.pauseOnHover : pauseOnHover(),
      dismissDirections: dismissDirections == null
          ? this.dismissDirections
          : dismissDirections(),
      dismissDragThreshold: dismissDragThreshold == null
          ? this.dismissDragThreshold
          : dismissDragThreshold(),
    );
  }
}
