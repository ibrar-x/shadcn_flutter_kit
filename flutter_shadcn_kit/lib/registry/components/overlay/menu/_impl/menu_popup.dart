part of '../menu.dart';

class MenuPopup extends StatelessWidget {
  /// Opacity of the surface blur effect.
  ///
  /// Controls the transparency of the backdrop blur. Higher values make
  /// the blur more visible. If `null`, uses theme default.
  final double? surfaceOpacity;

  /// Amount of blur to apply to the surface behind the popup.
  ///
  /// Higher values create more blur effect. If `null`, uses theme default.
  final double? surfaceBlur;

  /// Internal padding around the menu items.
  ///
  /// Defines the space between the popup's border and its content.
  /// If `null`, uses theme default or adaptive default based on overlay type.
  final EdgeInsetsGeometry? padding;

  /// Background fill color of the popup.
  ///
  /// If `null`, uses the theme's popover color.
  final Color? fillColor;

  /// Border color of the popup.
  ///
  /// If `null`, uses the theme's border color.
  final Color? borderColor;

  /// Corner radius of the popup border.
  ///
  /// If `null`, uses the theme's medium border radius.
  final BorderRadiusGeometry? borderRadius;

  /// The menu items to display inside the popup.
  ///
  /// Typically a list of [MenuItem] widgets or similar menu components.
  final List<Widget> children;

  /// Creates a menu popup container.
  ///
  /// Parameters:
  /// - [children]: Menu items to display (required)
  /// - [surfaceOpacity]: Backdrop blur opacity
  /// - [surfaceBlur]: Amount of surface blur
  /// - [padding]: Internal padding
  /// - [fillColor]: Background color
  /// - [borderColor]: Border color
  /// - [borderRadius]: Corner radius
  const MenuPopup({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    required this.children,
  });

  Widget _buildIntrinsicContainer(Widget child, Axis direction, bool wrap) {
    if (!wrap) {
      return child;
    }
    if (direction == Axis.vertical) {
      return IntrinsicWidth(child: child);
    }
    return IntrinsicHeight(child: child);
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<MenuGroupData>(context);
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<MenuPopupTheme>(context);
    final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    final isDialogOverlay = DialogOverlayHandler.isDialogOverlay(context);
    final pad = styleValue(
        widgetValue: padding,
        themeValue: compTheme?.padding,
        defaultValue: isSheetOverlay
            ? const EdgeInsets.symmetric(vertical: 12, horizontal: 4) *
                theme.scaling
            : const EdgeInsets.all(4) * theme.scaling);
    return ModalContainer(
      borderRadius: styleValue(
          widgetValue: borderRadius,
          themeValue: compTheme?.borderRadius,
          defaultValue: theme.borderRadiusMd),
      filled: true,
      fillColor: styleValue(
          widgetValue: fillColor,
          themeValue: compTheme?.fillColor,
          defaultValue: theme.colorScheme.popover),
      borderColor: styleValue(
          widgetValue: borderColor,
          themeValue: compTheme?.borderColor,
          defaultValue: theme.colorScheme.border),
      surfaceBlur: styleValue(
          widgetValue: surfaceBlur,
          themeValue: compTheme?.surfaceBlur,
          defaultValue: theme.surfaceBlur),
      surfaceOpacity: styleValue(
          widgetValue: surfaceOpacity,
          themeValue: compTheme?.surfaceOpacity,
          defaultValue: theme.surfaceOpacity),
      padding: pad,
      child: SingleChildScrollView(
        scrollDirection: data?.direction ?? Axis.vertical,
        child: _buildIntrinsicContainer(
          Flex(
            direction: data?.direction ?? Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
          data?.direction ?? Axis.vertical,
          !isSheetOverlay && !isDialogOverlay,
        ),
      ),
    ).normal();
  }
}
