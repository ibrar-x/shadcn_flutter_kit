import 'package:flutter/widgets.dart';

/// Represents a directional axis (up/down/start/end) that can be resolved to
/// a concrete [AxisDirection] based on [TextDirection].
enum AxisDirectional {
  up,
  down,
  start,
  end;

  /// Resolves this directional axis to a concrete [AxisDirection].
  AxisDirection resolve(TextDirection textDirection) {
    return switch ((this, textDirection)) {
      (AxisDirectional.up, _) => AxisDirection.up,
      (AxisDirectional.down, _) => AxisDirection.down,
      (AxisDirectional.start, TextDirection.ltr) => AxisDirection.left,
      (AxisDirectional.start, TextDirection.rtl) => AxisDirection.right,
      (AxisDirectional.end, TextDirection.ltr) => AxisDirection.right,
      (AxisDirectional.end, TextDirection.rtl) => AxisDirection.left,
    };
  }

  /// Returns the reversed directional axis.
  AxisDirectional get reversed => switch (this) {
        AxisDirectional.up => AxisDirectional.down,
        AxisDirectional.down => AxisDirectional.up,
        AxisDirectional.start => AxisDirectional.end,
        AxisDirectional.end => AxisDirectional.start,
      };
}

/// Base class for axis alignments that can resolve based on [TextDirection].
abstract class AxisAlignmentGeometry {
  /// Creates an [AxisAlignmentGeometry].
  const AxisAlignmentGeometry();

  /// Resolves this alignment to a concrete [AxisAlignment] for a specific direction.
  AxisAlignment resolve(TextDirection textDirection);
}

/// Alignment along a single axis, compatible with [AxisAlignmentGeometry].
class AxisAlignment extends AxisAlignmentGeometry {
  static const AxisAlignment left = AxisAlignment(-1.0);
  static const AxisAlignment right = AxisAlignment(1.0);
  static const AxisAlignment center = AxisAlignment(0.0);

  final TextDirection? direction;
  final double value;

  const AxisAlignment._(this.direction, this.value);
  const AxisAlignment(this.value) : direction = null;

  /// Returns the resolved alignment value for the provided [axis].
  double resolveValue(Axis axis) {
    return switch ((direction, axis)) {
      (TextDirection.ltr, Axis.horizontal) => value,
      (TextDirection.rtl, Axis.horizontal) => value * -1,
      _ => value,
    };
  }

  /// Positions a child within a span of [size] using this alignment.
  double alongValue(Axis axis, double size) {
    final center = size / 2;
    return center + resolveValue(axis) * center;
  }

  /// Converts this axis alignment to an [Alignment] using the provided horizontal value.
  Alignment asHorizontalAlignment(AxisAlignment crossAxisAlignment) {
    return Alignment(resolveValue(Axis.horizontal), crossAxisAlignment.value);
  }

  /// Converts this axis alignment to an [Alignment] using the provided vertical value.
  Alignment asVerticalAlignment(AxisAlignment crossAxisAlignment) {
    return Alignment(crossAxisAlignment.value, resolveValue(Axis.vertical));
  }

  @override
  AxisAlignment resolve(TextDirection textDirection) {
    return AxisAlignment._(textDirection, value);
  }
}

/// Directional axis alignment that resolves relative to text direction.
class AxisAlignmentDirectional extends AxisAlignmentGeometry {
  static const AxisAlignmentDirectional start = AxisAlignmentDirectional(-1.0);
  static const AxisAlignmentDirectional end = AxisAlignmentDirectional(1.0);
  static const AxisAlignmentDirectional center =
      AxisAlignmentDirectional(0.0);

  final double value;

  const AxisAlignmentDirectional(this.value);

  @override
  AxisAlignment resolve(TextDirection textDirection) {
    return AxisAlignment._(textDirection, value);
  }
}
