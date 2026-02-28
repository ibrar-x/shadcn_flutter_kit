part of '../../window.dart';

/// _DraggingWindow defines a reusable type for this registry module.
class _DraggingWindow {
/// Stores `window` state/configuration for this implementation.
  final Window window;
/// Stores `cursorPosition` state/configuration for this implementation.
  final Offset cursorPosition;

  _DraggingWindow(this.window, this.cursorPosition);
}
