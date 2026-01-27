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

/// Widget that provides keyboard shortcut display customization.
///
/// Allows customization of how keyboard shortcuts are displayed
/// throughout the widget tree using a builder function.
class KeyboardShortcutDisplayMapper extends StatefulWidget {
  static Widget _defaultBuilder(BuildContext context, LogicalKeyboardKey key) {
    switch (key) {
      case LogicalKeyboardKey.control:
      case LogicalKeyboardKey.controlLeft:
      case LogicalKeyboardKey.controlRight:
        return const Text('Ctrl');
      case LogicalKeyboardKey.shift:
      case LogicalKeyboardKey.shiftLeft:
      case LogicalKeyboardKey.shiftRight:
        return const Text('Shift');
      case LogicalKeyboardKey.alt:
      case LogicalKeyboardKey.altLeft:
      case LogicalKeyboardKey.altRight:
        return const Text('Alt');
      case LogicalKeyboardKey.meta:
      case LogicalKeyboardKey.metaLeft:
      case LogicalKeyboardKey.metaRight:
        return const Text('⌘');
      case LogicalKeyboardKey.enter:
        return const Text('↵');
      case LogicalKeyboardKey.arrowLeft:
        return const Text('←');
      case LogicalKeyboardKey.arrowRight:
        return const Text('→');
      case LogicalKeyboardKey.arrowUp:
        return const Text('↑');
      case LogicalKeyboardKey.arrowDown:
        return const Text('↓');
      default:
        return Text(key.keyLabel);
    }
  }

  /// The builder function for creating key displays.
  final KeyboardShortcutDisplayBuilder builder;

  /// The child widget that will have access to this mapper.
  final Widget child;

  /// Creates a keyboard shortcut display mapper.
  const KeyboardShortcutDisplayMapper({
    super.key,
    this.builder = _defaultBuilder,
    required this.child,
  });

  @override
  State<KeyboardShortcutDisplayMapper> createState() =>
      _KeyboardShortcutDisplayMapperState();
}

class _KeyboardShortcutDisplayMapperState
    extends State<KeyboardShortcutDisplayMapper> {
  late KeyboardShortcutDisplayHandle _handle;

  @override
  void initState() {
    super.initState();
    _handle = KeyboardShortcutDisplayHandle(widget.builder);
  }

  @override
  void didUpdateWidget(covariant KeyboardShortcutDisplayMapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.builder != widget.builder) {
      _handle = KeyboardShortcutDisplayHandle(widget.builder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: _handle,
      child: widget.child,
    );
  }
}
