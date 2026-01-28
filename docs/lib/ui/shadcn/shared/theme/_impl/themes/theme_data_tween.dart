part of '../../theme.dart';

class ThemeDataTween extends Tween<ThemeData> {
  /// Creates a [ThemeDataTween].
  ///
  /// Parameters:
  /// - [begin] (`ThemeData`, required): Starting theme.
  /// - [end] (`ThemeData`, required): Ending theme.
  ThemeDataTween({required ThemeData super.begin, required super.end});

  @override
  ThemeData lerp(double t) {
    if (end == null) {
      return begin!;
    }
    return ThemeData.lerp(begin!, end!, t);
  }
}

/// A widget that animates theme changes over time.
