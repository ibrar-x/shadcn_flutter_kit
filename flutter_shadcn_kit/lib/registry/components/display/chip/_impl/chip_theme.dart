part of '../chip.dart';

/// Theme config for chips that share padding/style defaults.
class ChipTheme extends ComponentThemeData {
  final EdgeInsetsGeometry? padding;
  final AbstractButtonStyle? style;

  const ChipTheme({this.padding, this.style});

  ChipTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<AbstractButtonStyle?>? style,
  }) {
    return ChipTheme(
      padding: padding == null ? this.padding : padding(),
      style: style == null ? this.style : style(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChipTheme &&
        other.padding == padding &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(padding, style);
}
