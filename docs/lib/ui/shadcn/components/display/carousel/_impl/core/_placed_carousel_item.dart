part of '../../carousel.dart';

/// Internal helper class used by the carousel component implementation.
class _PlacedCarouselItem {
  /// Input parameter used by `_PlacedCarouselItem` during rendering and behavior handling.
  final int relativeIndex;

  /// Child content displayed inside the carousel widget.
  final Widget child;

  /// Input parameter used by `_PlacedCarouselItem` during rendering and behavior handling.
  final double position;

  /// Creates `_PlacedCarouselItem._` for configuring or rendering carousel.
  const _PlacedCarouselItem._({
    required this.relativeIndex,
    required this.child,
    required this.position,
  });
}
