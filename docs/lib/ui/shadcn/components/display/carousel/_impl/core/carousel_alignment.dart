part of '../../carousel.dart';

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
