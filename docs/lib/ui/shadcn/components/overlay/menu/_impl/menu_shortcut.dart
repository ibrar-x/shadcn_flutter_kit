part of '../menu.dart';

class MenuShortcut extends StatelessWidget {
  /// The keyboard shortcut to display.
  final ShortcutActivator activator;

  /// Widget to display between multiple keys.
  final Widget? combiner;

  /// Creates a [MenuShortcut].
  ///
  /// Parameters:
  /// - [activator] (`ShortcutActivator`, required): The shortcut to display.
  /// - [combiner] (`Widget?`, optional): Separator between keys (default: " + ").
  const MenuShortcut({super.key, required this.activator, this.combiner});

  @override
  Widget build(BuildContext context) {
    var activator = this.activator;
    var combiner = this.combiner ?? const Text(' + ');
    final displayMapper = Data.maybeOf<KeyboardShortcutDisplayHandle>(context);
    Widget buildFallback(LogicalKeyboardKey key) {
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
          return const Text('Cmd');
        case LogicalKeyboardKey.enter:
          return const Text('Enter');
        case LogicalKeyboardKey.arrowLeft:
          return const Text('Left');
        case LogicalKeyboardKey.arrowRight:
          return const Text('Right');
        case LogicalKeyboardKey.arrowUp:
          return const Text('Up');
        case LogicalKeyboardKey.arrowDown:
          return const Text('Down');
        default:
          final label =
              key.keyLabel.isNotEmpty ? key.keyLabel : (key.debugName ?? 'Key');
          return Text(label);
      }
    }

    List<LogicalKeyboardKey> keys = shortcutActivatorToKeySet(activator);
    List<Widget> children = [];
    for (int i = 0; i < keys.length; i++) {
      if (i > 0) {
        children.add(combiner);
      }
      children.add(
        displayMapper?.buildKeyboardDisplay(context, keys[i]) ??
            buildFallback(keys[i]),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ).xSmall().muted();
  }
}

/// Abstract base class for menu item widgets.
///
/// All menu items (buttons, checkboxes, radio buttons, dividers, etc.) must
/// implement this interface. Menu items can be placed within menu groups and
/// support features like leading icons and popover controllers.
///
/// See also:
/// - [MenuButton], clickable menu item
/// - [MenuCheckbox], checkbox menu item
/// - [MenuRadio], radio button menu item
/// - [MenuDivider], divider between menu items
