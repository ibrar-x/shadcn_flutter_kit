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
    assert(displayMapper != null, 'Cannot find KeyboardShortcutDisplayMapper');
    List<LogicalKeyboardKey> keys = shortcutActivatorToKeySet(activator);
    List<Widget> children = [];
    for (int i = 0; i < keys.length; i++) {
      if (i > 0) {
        children.add(combiner);
      }
      children.add(displayMapper!.buildKeyboardDisplay(context, keys[i]));
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
