part of '../../switch.dart';

/// Theme configuration for switch styling.
class SwitchTheme extends ComponentThemeData {
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final double? gap;
  final BorderRadiusGeometry? borderRadius;

  const SwitchTheme({
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.gap,
    this.borderRadius,
  });

  SwitchTheme copyWith({
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? inactiveColor,
    ValueGetter<Color?>? activeThumbColor,
    ValueGetter<Color?>? inactiveThumbColor,
    ValueGetter<double?>? gap,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return SwitchTheme(
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      inactiveColor:
          inactiveColor == null ? this.inactiveColor : inactiveColor(),
      activeThumbColor:
          activeThumbColor == null ? this.activeThumbColor : activeThumbColor(),
      inactiveThumbColor: inactiveThumbColor == null
          ? this.inactiveThumbColor
          : inactiveThumbColor(),
      gap: gap == null ? this.gap : gap(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SwitchTheme &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.activeThumbColor == activeThumbColor &&
        other.inactiveThumbColor == inactiveThumbColor &&
        other.gap == gap &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        activeColor,
        inactiveColor,
        activeThumbColor,
        inactiveThumbColor,
        gap,
        borderRadius,
      );
}
