part of '../../popup.dart';

class MenuPopup extends StatelessWidget {
  /// Opacity of the surface blur effect.
  final double? surfaceOpacity;

  /// Amount of blur to apply to the surface behind the popup.
  final double? surfaceBlur;

  /// Internal padding around the menu items.
  final EdgeInsetsGeometry? padding;

  /// Background fill color of the popup.
  final Color? fillColor;

  /// Border color of the popup.
  final Color? borderColor;

  /// Corner radius of the popup border.
  final BorderRadiusGeometry? borderRadius;

  /// The menu items to display inside the popup.
  final List<Widget> children;

  /// Creates a menu popup container.
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

extension MenuPopupTextStyleExtensions on Widget {
  Widget normal() {
    return Builder(builder: (context) {
      final theme = Theme.of(context);
      return DefaultTextStyle.merge(
        style: theme.typography.normal,
        child: this,
      );
    });
  }
}
