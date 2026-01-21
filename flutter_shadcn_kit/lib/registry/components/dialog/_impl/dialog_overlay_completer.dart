part of '../dialog.dart';

class DialogOverlayCompleter<T> extends OverlayCompleter<T> {
  /// The dialog route managed by this completer.
  final DialogRoute<T> route;

  /// Creates a [DialogOverlayCompleter].
  ///
  /// Parameters:
  /// - [route] (`DialogRoute<T>`, required): the dialog route to manage
  ///
  /// Example:
  /// ```dart
  /// DialogOverlayCompleter(myDialogRoute)
  /// ```
  DialogOverlayCompleter(this.route);

  @override
  Future<void> get animationFuture => route.completed;

  @override
  void dispose() {
    route.dispose();
  }

  @override
  Future<T> get future => route.popped.then((value) {
        assert(value is T, 'Dialog route was closed without returning a value');
        return value as T;
      });

  @override
  bool get isAnimationCompleted => route.animation?.isCompleted ?? true;

  @override
  bool get isCompleted => route.animation?.isCompleted ?? true;

  @override
  void remove() {
    if (route.isCurrent) {
      route.navigator?.pop();
    } else {
      route.navigator?.removeRoute(route);
    }
  }
}
