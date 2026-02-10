part of '../../toast.dart';

/// Theme data for toast notifications.
class ToastTheme extends ComponentThemeData {
  final EdgeInsetsGeometry? padding;
  final double? margin;
  final Duration? duration;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;

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
  });

  ToastTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<double?>? margin,
    ValueGetter<Duration?>? duration,
    ValueGetter<Duration?>? animationDuration,
    ValueGetter<Curve?>? animationCurve,
    ValueGetter<double?>? width,
    ValueGetter<double?>? borderRadius,
    ValueGetter<Color?>? backgroundColor,
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
    );
  }
}
