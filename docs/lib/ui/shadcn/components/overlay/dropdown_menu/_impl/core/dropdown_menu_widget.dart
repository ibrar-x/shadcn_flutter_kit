part of '../../dropdown_menu.dart';

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
