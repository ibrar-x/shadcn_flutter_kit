part of '../../keyboard_shortcut.dart';

/// Builder function type for creating custom keyboard key displays.
///
/// Takes the build context and logical keyboard key, and returns
/// a widget representing that key.
typedef KeyboardShortcutDisplayBuilder = Widget Function(
  BuildContext context,
  LogicalKeyboardKey key,
);

/// Handle for accessing keyboard shortcut display builders.
///
/// Wraps a keyboard shortcut display builder function to provide
/// a consistent API for building key displays.
class KeyboardShortcutDisplayHandle {
  final KeyboardShortcutDisplayBuilder _builder;

  /// Creates a handle with the specified builder.
  const KeyboardShortcutDisplayHandle(this._builder);

  /// Builds a display widget for the specified keyboard key.
  Widget buildKeyboardDisplay(BuildContext context, LogicalKeyboardKey key) {
    return _builder(context, key);
  }
}
