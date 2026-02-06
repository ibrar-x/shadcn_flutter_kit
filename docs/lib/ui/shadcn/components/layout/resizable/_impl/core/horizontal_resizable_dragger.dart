part of '../../resizable.dart';

class HorizontalResizableDragger extends StatelessWidget {
  /// Creates a [HorizontalResizableDragger].
  const HorizontalResizableDragger({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ResizableDraggerTheme>(context);
    final color = styleValue(
        widgetValue: null,
        themeValue: compTheme?.color,
        defaultValue: theme.colorScheme.border);
    final borderRadius = styleValue(
        widgetValue: null,
        themeValue: compTheme?.borderRadius,
        defaultValue: theme.radiusSm);
    final width = styleValue(
        widgetValue: null,
        themeValue: compTheme?.width,
        defaultValue: 3 * 4 * scaling);
    final height = styleValue(
        widgetValue: null,
        themeValue: compTheme?.height,
        defaultValue: 4 * 4 * scaling);
    final iconSize = styleValue(
        widgetValue: null,
        themeValue: compTheme?.iconSize,
        defaultValue: 4 * 2.5 * scaling);
    final iconColor =
        styleValue(themeValue: compTheme?.iconColor, defaultValue: null);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Icon(
          RadixIcons.dragHandleDots2,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
