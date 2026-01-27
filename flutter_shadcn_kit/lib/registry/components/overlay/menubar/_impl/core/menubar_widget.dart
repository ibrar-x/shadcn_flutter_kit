part of '../../menubar.dart';

class Menubar extends StatefulWidget {
  /// List of menu items to display in the menubar.
  ///
  /// Type: `List<MenuItem>`. Each MenuItem represents a top-level menu that
  /// can contain nested menu items for dropdown functionality. Items are
  /// displayed horizontally in the order provided.
  final List<MenuItem> children;

  /// Positioning offset for submenu popovers when items are opened.
  ///
  /// Type: `Offset?`. If null, uses theme defaults or calculated values based
  /// on border presence. Controls where dropdown menus appear relative to
  /// their parent menu items.
  final Offset? popoverOffset;

  /// Whether to draw a border around the menubar container.
  ///
  /// Type: `bool`, default: `true`. When true, the menubar is wrapped with
  /// an outlined container using theme colors and border radius.
  final bool border;

  /// Creates a [Menubar] with horizontal menu layout.
  ///
  /// Configures a horizontal menubar that displays menu items and supports
  /// dropdown submenus with customizable styling and positioning.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [children] (`List<MenuItem>`, required): Menu items to display horizontally
  /// - [popoverOffset] (Offset?, optional): Positioning offset for dropdown menus
  /// - [border] (bool, default: true): Whether to show a border around the menubar
  ///
  /// Example:
  /// ```dart
  /// Menubar(
  ///   border: true,
  ///   popoverOffset: Offset(0, 8),
  ///   children: [
  ///     MenuItem(
  ///       title: Text('View'),
  ///       children: [
  ///         MenuItem(title: Text('Zoom In')),
  ///         MenuItem(title: Text('Zoom Out')),
  ///         MenuDivider(),
  ///         MenuItem(title: Text('Full Screen')),
  ///       ],
  ///     ),
  ///     MenuItem(
  ///       title: Text('Tools'),
  ///       children: [
  ///         MenuItem(title: Text('Preferences')),
  ///         MenuItem(title: Text('Extensions')),
  ///       ],
  ///     ),
  ///   ],
  /// )
  /// ```
  const Menubar({
    super.key,
    this.popoverOffset,
    this.border = true,
    required this.children,
  });

  @override
  State<Menubar> createState() => MenubarState();
}

/// State class for [Menubar] widget.
///
/// Manages the rendering and theming of the menubar container.
