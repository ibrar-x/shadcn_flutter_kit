part of '../menu.dart';

class MenuGap extends StatelessWidget implements MenuItem {
  /// Size of the gap in logical pixels.
  final double size;

  /// Creates a menu gap.
  ///
  /// Parameters:
  /// - [size] (double, required): Gap size in logical pixels
  const MenuGap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Gap(size);
  }

  @override
  bool get hasLeading => false;

  @override
  PopoverController? get popoverController => null;
}

/// Clickable button menu item with optional submenu support.
///
/// Primary menu item type that responds to user interaction. Can display
/// leading icons, trailing widgets (shortcuts), and nested submenus.
///
/// Example:
/// ```dart
/// MenuButton(
///   leading: Icon(Icons.cut),
///   trailing: Text('Ctrl+X').textSmall().muted(),
///   onPressed: (context) => _handleCut(),
///   child: Text('Cut'),
/// )
/// ```
