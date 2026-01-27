part of '../../feature_carousel.dart';

class _CarouselIntent extends Intent {
  const _CarouselIntent._(this.direction);
  final _CarouselDirection? direction;
  static const left = _CarouselIntent._(_CarouselDirection.left);
  static const right = _CarouselIntent._(_CarouselDirection.right);
  static const action = _CarouselIntent._(null);
}
