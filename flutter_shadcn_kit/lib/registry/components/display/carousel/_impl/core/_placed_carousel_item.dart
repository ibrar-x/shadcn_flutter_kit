part of '../../carousel.dart';

class _PlacedCarouselItem {
  final int relativeIndex;
  final Widget child;
  final double position;

  const _PlacedCarouselItem._({
    required this.relativeIndex,
    required this.child,
    required this.position,
  });
}
