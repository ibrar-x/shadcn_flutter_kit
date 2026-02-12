part of '../../feature_carousel.dart';

/// Internal helper class used by the feature carousel component implementation.
class _CarouselIntent extends Intent {
  const _CarouselIntent._(this.direction);

  /// Input parameter used by `_CarouselIntent` during rendering and behavior handling.
  final _CarouselDirection? direction;

  /// Input parameter used by `_CarouselIntent` during rendering and behavior handling.
  static const left = _CarouselIntent._(_CarouselDirection.left);

  /// Input parameter used by `_CarouselIntent` during rendering and behavior handling.
  static const right = _CarouselIntent._(_CarouselDirection.right);

  /// Input parameter used by `_CarouselIntent` during rendering and behavior handling.
  static const action = _CarouselIntent._(null);
}
