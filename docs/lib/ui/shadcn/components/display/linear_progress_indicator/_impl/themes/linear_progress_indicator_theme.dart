part of '../../linear_progress_indicator.dart';

/// Theme data for [LinearProgressIndicator].
class LinearProgressIndicatorTheme extends ComponentThemeData {
  final Color? color;
  final Color? backgroundColor;
  final double? minHeight;
  final BorderRadiusGeometry? borderRadius;
  final bool? showSparks;
  final bool? disableAnimation;

  const LinearProgressIndicatorTheme({
    this.color,
    this.backgroundColor,
    this.minHeight,
    this.borderRadius,
    this.showSparks,
    this.disableAnimation,
  });

  LinearProgressIndicatorTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<double?>? minHeight,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<bool?>? showSparks,
    ValueGetter<bool?>? disableAnimation,
  }) {
    return LinearProgressIndicatorTheme(
      color: color == null ? this.color : color(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      minHeight: minHeight == null ? this.minHeight : minHeight(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      showSparks: showSparks == null ? this.showSparks : showSparks(),
      disableAnimation:
          disableAnimation == null ? this.disableAnimation : disableAnimation(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LinearProgressIndicatorTheme &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.minHeight == minHeight &&
        other.borderRadius == borderRadius &&
        other.showSparks == showSparks &&
        other.disableAnimation == disableAnimation;
  }

  @override
  int get hashCode => Object.hash(
        color,
        backgroundColor,
        minHeight,
        borderRadius,
        showSparks,
        disableAnimation,
      );
}
