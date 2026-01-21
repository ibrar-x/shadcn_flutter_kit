part of '../menu.dart';

class DirectionalMenuFocusIntent extends Intent {
  /// Direction of focus traversal.
  final TraversalDirection direction;

  /// Creates a directional menu focus intent.
  ///
  /// Parameters:
  /// - [direction] (TraversalDirection, required): Traversal direction
  const DirectionalMenuFocusIntent(this.direction);
}
