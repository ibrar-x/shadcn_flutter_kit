part of '../../carousel.dart';

/// A fractional carousel size constraint.
class CarouselFractionalConstraint extends CarouselSizeConstraint {
  /// The fraction of the constraint.
  final double fraction;

  /// Creates a fractional carousel size constraint.
  const CarouselFractionalConstraint(this.fraction)
      : assert(fraction > 0, 'fraction must be greater than 0');
}
