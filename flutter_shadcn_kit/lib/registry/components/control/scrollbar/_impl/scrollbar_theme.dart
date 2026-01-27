import 'package:flutter/widgets.dart';

import '../../../../shared/theme/theme.dart';

/// Theme configuration for Scrollbar.
class ScrollbarTheme extends ComponentThemeData {
  final Color? color;
  final double? thickness;
  final Radius? radius;

  const ScrollbarTheme({
    this.color,
    this.thickness,
    this.radius,
  });

  ScrollbarTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? thickness,
    ValueGetter<Radius?>? radius,
  }) {
    return ScrollbarTheme(
      color: color == null ? this.color : color(),
      thickness: thickness == null ? this.thickness : thickness(),
      radius: radius == null ? this.radius : radius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScrollbarTheme &&
        other.color == color &&
        other.thickness == thickness &&
        other.radius == radius;
  }

  @override
  int get hashCode => Object.hash(color, thickness, radius);
}
