part of '../menu.dart';

class MenuTheme extends ComponentThemeData {
  /// Default padding applied to each menu item.
  final EdgeInsets? itemPadding;

  /// Offset applied when showing a submenu.
  final Offset? subMenuOffset;

  /// {@macro menu_theme}
  const MenuTheme({
    this.itemPadding,
    this.subMenuOffset,
  });

  /// Creates a copy of this theme but with the given fields replaced.
  MenuTheme copyWith({
    ValueGetter<EdgeInsets?>? itemPadding,
    ValueGetter<Offset?>? subMenuOffset,
  }) {
    return MenuTheme(
      itemPadding: itemPadding == null ? this.itemPadding : itemPadding(),
      subMenuOffset:
          subMenuOffset == null ? this.subMenuOffset : subMenuOffset(),
    );
  }

  @override
  int get hashCode => Object.hash(itemPadding, subMenuOffset);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuTheme &&
        other.itemPadding == itemPadding &&
        other.subMenuOffset == subMenuOffset;
  }

  @override
  String toString() {
    return 'MenuTheme(itemPadding: $itemPadding, subMenuOffset: $subMenuOffset)';
  }
}

/// Displays a keyboard shortcut in a menu.
///
/// Renders the visual representation of a keyboard shortcut, typically
/// displayed on the right side of menu items.
///
/// Example:
/// ```dart
/// MenuShortcut(
///   activator: SingleActivator(LogicalKeyboardKey.keyS, control: true),
/// )
/// ```
