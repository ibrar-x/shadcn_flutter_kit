part of '../../card_image.dart';

class _CardImageState extends State<CardImage> {
  final WidgetStatesController _statesController = WidgetStatesController();

  Widget _wrapIntrinsic(Widget child, Axis direction) {
    return direction == Axis.horizontal
        ? IntrinsicHeight(child: child)
        : IntrinsicWidth(child: child);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<CardImageTheme>(context);
    final style = styleValue(
        widgetValue: widget.style,
        themeValue: compTheme?.style,
        defaultValue: const ButtonStyle.fixed(
          density: ButtonDensity.compact,
        ));
    final direction = styleValue(
        widgetValue: widget.direction,
        themeValue: compTheme?.direction,
        defaultValue: Axis.vertical);
    final hoverScale = styleValue(
        widgetValue: widget.hoverScale,
        themeValue: compTheme?.hoverScale,
        defaultValue: 1.05);
    final normalScale = styleValue(
        widgetValue: widget.normalScale,
        themeValue: compTheme?.normalScale,
        defaultValue: 1.0);
    final backgroundColor = styleValue(
        widgetValue: widget.backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: Colors.transparent);
    final borderColor = styleValue(
        widgetValue: widget.borderColor,
        themeValue: compTheme?.borderColor,
        defaultValue: Colors.transparent);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 12 * scaling);
    return Button(
      statesController: _statesController,
      style: style,
      onPressed: widget.onPressed,
      enabled: widget.enabled,
      child: _wrapIntrinsic(
        Flex(
          direction: direction,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: OutlinedContainer(
                backgroundColor: backgroundColor,
                borderColor: borderColor,
                child: AnimatedBuilder(
                  animation: _statesController,
                  builder: (context, child) {
                    return AnimatedScale(
                      duration: kDefaultDuration,
                      scale: _statesController.value.contains(WidgetState.hovered)
                          ? hoverScale
                          : normalScale,
                      child: widget.image,
                    );
                  },
                ),
              ),
            ),
            Gap(gap),
            Basic(
              title: widget.title,
              subtitle: widget.subtitle,
              trailing: widget.trailing,
              leading: widget.leading,
            ),
          ],
        ),
        direction,
      ),
    );
  }
}
