part of '../../dot_indicator.dart';

/// Theme data for [DotIndicator] and children.
class DotIndicatorTheme extends ComponentThemeData {
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final DotBuilder? dotBuilder;
  final double? size;
  final double? borderRadius;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? inactiveBorderColor;
  final double? inactiveBorderWidth;

  const DotIndicatorTheme({
    this.spacing,
    this.padding,
    this.dotBuilder,
    this.size,
    this.borderRadius,
    this.activeColor,
    this.inactiveColor,
    this.inactiveBorderColor,
    this.inactiveBorderWidth,
  });

  DotIndicatorTheme copyWith({
    ValueGetter<double?>? spacing,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<DotBuilder?>? dotBuilder,
    ValueGetter<double?>? size,
    ValueGetter<double?>? borderRadius,
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? inactiveColor,
    ValueGetter<Color?>? inactiveBorderColor,
    ValueGetter<double?>? inactiveBorderWidth,
  }) {
    return DotIndicatorTheme(
      spacing: spacing == null ? this.spacing : spacing(),
      padding: padding == null ? this.padding : padding(),
      dotBuilder: dotBuilder == null ? this.dotBuilder : dotBuilder(),
      size: size == null ? this.size : size(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      inactiveColor:
          inactiveColor == null ? this.inactiveColor : inactiveColor(),
      inactiveBorderColor: inactiveBorderColor == null
          ? this.inactiveBorderColor
          : inactiveBorderColor(),
      inactiveBorderWidth: inactiveBorderWidth == null
          ? this.inactiveBorderWidth
          : inactiveBorderWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DotIndicatorTheme &&
        other.spacing == spacing &&
        other.padding == padding &&
        other.dotBuilder == dotBuilder &&
        other.size == size &&
        other.borderRadius == borderRadius &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.inactiveBorderColor == inactiveBorderColor &&
        other.inactiveBorderWidth == inactiveBorderWidth;
  }

  @override
  int get hashCode => Object.hash(
      spacing,
      padding,
      dotBuilder,
      size,
      borderRadius,
      activeColor,
      inactiveColor,
      inactiveBorderColor,
      inactiveBorderWidth);
}
