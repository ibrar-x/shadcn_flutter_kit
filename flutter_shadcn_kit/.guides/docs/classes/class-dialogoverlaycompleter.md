---
title: "Class: DialogOverlayCompleter"
description: "Reference for DialogOverlayCompleter"
---

```dart
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
  Future<void> get animationFuture;
  void dispose();
  Future<T> get future;
  bool get isAnimationCompleted;
  bool get isCompleted;
  void remove();
}
```
