part of '../../carousel.dart';

/// Size constraint for the carousel.
abstract class CarouselSizeConstraint {
  /// Creates a carousel size constraint.
  const CarouselSizeConstraint();

  /// Creates a fixed carousel size constraint.
  const factory CarouselSizeConstraint.fixed(double size) =
      CarouselFixedConstraint;

  /// Creates a fractional carousel size constraint.
  const factory CarouselSizeConstraint.fractional(double fraction) =
      CarouselFractionalConstraint;
}











/// Builds a carousel item.
/// The [index] is the index of the item.
typedef CarouselItemBuilder = Widget Function(BuildContext context, int index);
