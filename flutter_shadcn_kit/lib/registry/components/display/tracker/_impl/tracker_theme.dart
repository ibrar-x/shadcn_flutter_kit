part of '../tracker.dart';

/// Theme for tracker appearance.
class TrackerTheme extends ComponentThemeData {
  final double? radius;
  final double? gap;
  final double? itemHeight;

  const TrackerTheme({
    this.radius,
    this.gap,
    this.itemHeight,
  });

  TrackerTheme copyWith({
    ValueGetter<double?>? radius,
    ValueGetter<double?>? gap,
    ValueGetter<double?>? itemHeight,
  }) {
    return TrackerTheme(
      radius: radius == null ? this.radius : radius(),
      gap: gap == null ? this.gap : gap(),
      itemHeight: itemHeight == null ? this.itemHeight : itemHeight(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TrackerTheme &&
        other.radius == radius &&
        other.gap == gap &&
        other.itemHeight == itemHeight;
  }

  @override
  int get hashCode => Object.hash(radius, gap, itemHeight);
}
