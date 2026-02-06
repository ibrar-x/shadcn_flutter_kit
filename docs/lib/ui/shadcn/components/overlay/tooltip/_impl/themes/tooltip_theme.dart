part of '../../tooltip.dart';

/// Theme data for customizing tooltip container appearance.
class TooltipTheme extends ComponentThemeData {
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  const TooltipTheme({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
  });

  TooltipTheme copyWith({
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return TooltipTheme(
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      padding: padding == null ? this.padding : padding(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TooltipTheme &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.padding == padding &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
      surfaceOpacity, surfaceBlur, padding, backgroundColor, borderRadius);
}
