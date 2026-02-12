part of '../../feature_carousel.dart';

/// Internal helper class used by the feature carousel component implementation.
class _GhostTransform {
  /// Input parameter used by `_GhostTransform` during rendering and behavior handling.
  final double dx;

  /// Input parameter used by `_GhostTransform` during rendering and behavior handling.
  final double dy;

  /// Input parameter used by `_GhostTransform` during rendering and behavior handling.
  final double rotation;

  /// Input parameter used by `_GhostTransform` during rendering and behavior handling.
  final double scale;

  /// Input parameter used by `_GhostTransform` during rendering and behavior handling.
  final double opacity;

  /// Creates `_GhostTransform` for configuring or rendering feature carousel.
  const _GhostTransform({
    required this.dx,
    required this.dy,
    required this.rotation,
    required this.scale,
    required this.opacity,
  });
}
