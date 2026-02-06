part of '../../axis.dart';

abstract class AxisAlignmentGeometry {
  /// Creates an [AxisAlignmentGeometry].
  const AxisAlignmentGeometry();

  /// Resolves this alignment to a concrete [AxisAlignment] for a specific direction.
  AxisAlignment resolve(TextDirection textDirection);
}

/// Alignment along a single axis, compatible with [AxisAlignmentGeometry].
