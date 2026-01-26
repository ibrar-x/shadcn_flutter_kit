part of '../menu.dart';

class MenuLabel extends StatelessWidget implements MenuItem {
  /// Content widget displayed in the label.
  final Widget child;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Optional leading widget (e.g., icon).
  final Widget? leading;

  /// Creates a menu label.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content
  /// - [trailing] (Widget?): Trailing widget
  /// - [leading] (Widget?): Leading icon or widget
  const MenuLabel({
    super.key,
    required this.child,
    this.trailing,
    this.leading,
  });

  @override
  bool get hasLeading => leading != null;

  @override
  PopoverController? get popoverController => null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    assert(menuGroupData != null, 'MenuLabel must be a child of MenuGroup');
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 6, right: 6, bottom: 6) *
              scaling +
          menuGroupData!.itemPadding,
      child: Basic(
        contentSpacing: 8 * scaling,
        leading: leading == null && menuGroupData.hasLeading
            ? SizedBox(width: 16 * scaling)
            : leading == null
                ? null
                : SizedBox(
                    width: 16 * scaling,
                    height: 16 * scaling,
                    child: leading!.iconSmall(),
                  ),
        trailing: trailing,
        content: child.semiBold(),
        trailingAlignment: Alignment.center,
        leadingAlignment: Alignment.center,
        contentAlignment: menuGroupData.direction == Axis.vertical
            ? AlignmentDirectional.centerStart
            : Alignment.center,
      ),
    );
  }
}

/// Checkbox menu item with checked/unchecked state.
///
/// Displays a checkmark when selected. Used for togglable menu options.
///
/// Example:
/// ```dart
/// MenuCheckbox(
///   value: showToolbar,
///   onChanged: (context, value) => setState(() => showToolbar = value),
///   child: Text('Show Toolbar'),
/// )
/// ```
