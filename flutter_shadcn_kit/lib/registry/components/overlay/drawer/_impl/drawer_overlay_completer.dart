part of '../drawer.dart';

class DrawerOverlayCompleter<T> extends OverlayCompleter<T> {
  final DrawerOverlayEntry<T> _entry;

  /// Creates a drawer overlay completer.
  ///
  /// Parameters:
  /// - [_entry] (`DrawerOverlayEntry<T>`, required): The drawer entry to manage
  DrawerOverlayCompleter(this._entry);

  @override
  Future<void> get animationFuture => _entry.completer.future;

  @override
  void dispose() {
    _entry.completer.complete();
  }

  /// Gets the animation controller for the drawer.
  ///
  /// Returns the external animation controller if provided, otherwise
  /// returns the internal controller from the drawer entry widget state.
  ///
  /// Returns [AnimationController] or null if not available.
  AnimationController? get animationController =>
      _entry.animationController ?? _entry.key.currentState?._controller;

  @override
  Future<T> get future => _entry.completer.future;

  @override
  bool get isAnimationCompleted => _entry.completer.isCompleted;

  @override
  bool get isCompleted => _entry.completer.isCompleted;

  @override
  void remove() {
    _entry.completer.complete();
  }
}

/// Overlay handler specialized for sheet-style overlays.
///
/// Provides a simplified API for showing sheet overlays (bottom sheets,
/// side sheets, etc.) with standard positioning and barrier behavior.
