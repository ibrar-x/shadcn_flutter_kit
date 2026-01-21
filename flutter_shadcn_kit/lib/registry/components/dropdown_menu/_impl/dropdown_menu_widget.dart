part of '../dropdown_menu.dart';

class DropdownMenu extends StatefulWidget {
  /// Opacity of the surface blur effect.
  ///
  /// If `null`, uses theme default.
  final double? surfaceOpacity;

  /// Amount of blur to apply to the surface.
  ///
  /// If `null`, uses theme default.
  final double? surfaceBlur;

  /// Menu items to display in the dropdown.
  ///
  /// Each item should be a [MenuItem] or similar menu component.
  final List<MenuItem> children;

  /// Creates a dropdown menu.
  ///
  /// Parameters:
  /// - [children]: Menu items to display (required)
  /// - [surfaceOpacity]: Backdrop blur opacity
  /// - [surfaceBlur]: Amount of surface blur
  const DropdownMenu({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.children,
  });

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    final compTheme = ComponentTheme.maybeOf<DropdownMenuTheme>(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 192,
      ),
      child: MenuGroup(
        regionGroupId: Data.maybeOf<DropdownMenuData>(context)?.key,
        subMenuOffset: const Offset(8, -4) * theme.scaling,
        itemPadding: isSheetOverlay
            ? const EdgeInsets.symmetric(horizontal: 8) * theme.scaling
            : EdgeInsets.zero,
        onDismissed: () {
          closeOverlay(context);
        },
        direction: Axis.vertical,
        builder: (context, children) {
          return MenuPopup(
            // does not need to check for theme.surfaceOpacity and theme.surfaceBlur
            // MenuPopup already has default values for these properties
            surfaceOpacity: widget.surfaceOpacity ?? compTheme?.surfaceOpacity,
            surfaceBlur: widget.surfaceBlur ?? compTheme?.surfaceBlur,
            children: children,
          );
        },
        children: widget.children,
      ),
    );
  }
}
