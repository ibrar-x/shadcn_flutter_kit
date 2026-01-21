part of '../carousel.dart';

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

/// A fixed carousel size constraint.
class CarouselFixedConstraint extends CarouselSizeConstraint {
  /// The size of the constraint.
  final double size;

  /// Creates a fixed carousel size constraint.
  const CarouselFixedConstraint(this.size)
      : assert(size > 0, 'size must be greater than 0');
}

/// A fractional carousel size constraint.
class CarouselFractionalConstraint extends CarouselSizeConstraint {
  /// The fraction of the constraint.
  final double fraction;

  /// Creates a fractional carousel size constraint.
  const CarouselFractionalConstraint(this.fraction)
      : assert(fraction > 0, 'fraction must be greater than 0');
}

/// A carousel layout.
abstract class CarouselTransition {
  /// Creates a carousel layout.
  const CarouselTransition();

  /// Creates a sliding carousel layout.
  const factory CarouselTransition.sliding({double gap}) =
      SlidingCarouselTransition;

  /// Creates a fading carousel layout.
  const factory CarouselTransition.fading() = FadingCarouselTransition;

  /// Layouts the carousel items.
  List<Widget> layout(
    BuildContext context, {
    required double progress,
    required BoxConstraints constraints,
    required CarouselAlignment alignment,
    required Axis direction,
    required CarouselSizeConstraint sizeConstraint,
    required double progressedIndex,
    required int? itemCount,
    required CarouselItemBuilder itemBuilder,
    required bool wrap,
    required bool reverse,
  });
}

/// A sliding carousel transition.
class SlidingCarouselTransition extends CarouselTransition {
  /// The gap between the carousel items.
  final double gap;

  /// Creates a sliding carousel transition.
  const SlidingCarouselTransition({this.gap = 0});

  @override
  List<Widget> layout(
    BuildContext context, {
    required double progress,
    required BoxConstraints constraints,
    required CarouselAlignment alignment,
    required Axis direction,
    required CarouselSizeConstraint sizeConstraint,
    required double progressedIndex,
    required int? itemCount,
    required CarouselItemBuilder itemBuilder,
    required bool wrap,
    required bool reverse,
  }) {
    int additionalPreviousItems = 1;
    int additionalNextItems = 1;
    double originalSize = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double size;
    if (sizeConstraint is CarouselFixedConstraint) {
      size = sizeConstraint.size;
    } else if (sizeConstraint is CarouselFractionalConstraint) {
      size = originalSize * sizeConstraint.fraction;
    } else {
      size = originalSize;
    }
    double snapOffsetAlignment = (originalSize - size) * alignment.alignment;
    double gapBeforeItem = snapOffsetAlignment;
    double gapAfterItem = originalSize - size - gapBeforeItem;
    additionalPreviousItems += max(0, (gapBeforeItem / size).ceil());
    additionalNextItems += max(0, (gapAfterItem / size).ceil());
    List<_PlacedCarouselItem> items = [];
    int start = progressedIndex.floor() - additionalPreviousItems;
    int end = progressedIndex.floor() + additionalNextItems;
    if (!wrap && itemCount != null) {
      start = start.clamp(0, itemCount - 1);
      end = end.clamp(0, itemCount - 1);
    }
    double currentIndex = progressedIndex + (gap / size) * progressedIndex;
    for (int i = start; i <= end; i++) {
      double index;
      if (itemCount != null) {
        index = wrapDouble(i.toDouble(), 0.0, itemCount.toDouble());
      } else {
        index = i.toDouble();
      }
      var itemIndex = reverse ? (-index).toInt() : index.toInt();
      final item = itemBuilder(context, itemIndex);
      double position = i.toDouble();
      items.add(
        _PlacedCarouselItem._(
          relativeIndex: i,
          child: item,
          position: position,
        ),
      );
    }
    if (direction == Axis.horizontal) {
      return [
        for (var item in items)
          Positioned(
            left: snapOffsetAlignment +
                (item.position - currentIndex) * size +
                (gap * item.relativeIndex),
            width: size,
            height: constraints.maxHeight,
            child: item.child,
          ),
      ];
    } else {
      return [
        for (var item in items)
          Positioned(
            top: snapOffsetAlignment +
                (item.position - currentIndex) * size +
                (gap * item.relativeIndex),
            width: constraints.maxWidth,
            height: size,
            child: item.child,
          ),
      ];
    }
  }
}

/// A fading carousel transition.
class FadingCarouselTransition extends CarouselTransition {
  /// Creates a fading carousel transition.
  const FadingCarouselTransition();

  @override
  List<Widget> layout(
    BuildContext context, {
    required double progress,
    required BoxConstraints constraints,
    required CarouselAlignment alignment,
    required Axis direction,
    required CarouselSizeConstraint sizeConstraint,
    required double progressedIndex,
    required int? itemCount,
    required CarouselItemBuilder itemBuilder,
    required bool wrap,
    required bool reverse,
  }) {
    double originalSize = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double size;
    if (sizeConstraint is CarouselFixedConstraint) {
      size = sizeConstraint.size;
    } else if (sizeConstraint is CarouselFractionalConstraint) {
      size = originalSize * sizeConstraint.fraction;
    } else {
      size = originalSize;
    }
    double snapOffsetAlignment = (originalSize - size) * alignment.alignment;
    List<_PlacedCarouselItem> items = [];
    int start = progressedIndex.floor() - 1;
    int end = progressedIndex.floor() + 1;
    if (!wrap && itemCount != null) {
      start = start.clamp(0, itemCount - 1);
      end = end.clamp(0, itemCount - 1);
    }
    for (int i = start; i <= end; i++) {
      double index;
      if (itemCount != null) {
        index = wrapDouble(i.toDouble(), 0.0, itemCount.toDouble());
      } else {
        index = i.toDouble();
      }
      var itemIndex = reverse ? (-index).toInt() : index.toInt();
      final item = itemBuilder(context, itemIndex);
      double position = i.toDouble();
      items.add(
        _PlacedCarouselItem._(
          relativeIndex: i,
          child: item,
          position: position,
        ),
      );
    }
    if (direction == Axis.horizontal) {
      return [
        for (var item in items)
          Positioned(
            left: snapOffsetAlignment,
            width: size,
            height: constraints.maxHeight,
            child: Opacity(
              opacity: (1 - (progress - item.position).abs()).clamp(0.0, 1.0),
              child: item.child,
            ),
          ),
      ];
    } else {
      return [
        for (var item in items)
          Positioned(
            top: snapOffsetAlignment,
            width: constraints.maxWidth,
            height: size,
            child: Opacity(
              opacity: (1 - (progress - item.position).abs()).clamp(0.0, 1.0),
              child: item.child,
            ),
          ),
      ];
    }
  }
}

/// Builds a carousel item.
/// The [index] is the index of the item.
typedef CarouselItemBuilder = Widget Function(BuildContext context, int index);

/// CarouselAlignment is used to align the carousel items.
enum CarouselAlignment {
  /// Aligns the carousel items to the start.
  start(0),

  /// Aligns the carousel items to the center.
  center(0.5),

  /// Aligns the carousel items to the end.
  end(1);

  /// The alignment value.
  final double alignment;

  const CarouselAlignment(this.alignment);
}

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
