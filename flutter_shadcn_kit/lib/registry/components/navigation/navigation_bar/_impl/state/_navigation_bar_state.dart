part of '../../navigation_bar.dart';

class _NavigationBarState extends State<NavigationBar>
    with NavigationContainerMixin {
  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  void didUpdateWidget(covariant NavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<NavigationBarTheme>(context);
    final alignment = styleValue(
      widgetValue: widget.alignment,
      themeValue: compTheme?.alignment,
      defaultValue: NavigationBarAlignment.center,
    );
    final direction = styleValue(
      widgetValue: widget.direction,
      themeValue: compTheme?.direction,
      defaultValue: Axis.horizontal,
    );
    final spacing = styleValue<double>(
      widgetValue: widget.spacing,
      themeValue: compTheme?.spacing,
      defaultValue: 8 * scaling,
    );
    final labelType = styleValue(
      widgetValue: widget.labelType,
      themeValue: compTheme?.labelType,
      defaultValue: NavigationLabelType.none,
    );
    final labelPosition = styleValue(
      widgetValue: widget.labelPosition,
      themeValue: compTheme?.labelPosition,
      defaultValue: NavigationLabelPosition.bottom,
    );
    final labelSize = styleValue(
      widgetValue: widget.labelSize,
      themeValue: compTheme?.labelSize,
      defaultValue: NavigationLabelSize.small,
    );
    final parentPadding = styleValue(
      widgetValue: widget.padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.symmetric(
        vertical: theme.density.baseGap * scaling,
        horizontal: theme.density.baseContentPadding * scaling * 0.75,
      ),
    );
    final backgroundColor = styleValue<Color?>(
      widgetValue: widget.backgroundColor,
      themeValue: compTheme?.backgroundColor,
      defaultValue: null,
    );
    final expands = widget.expands ?? true;
    final expanded = widget.expanded ?? true;
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    List<Widget> rawChildren = wrapChildren(context, widget.children);
    List<Widget> children = [];
    if (!expands) {
      children = List.of(rawChildren);
    } else {
      if (alignment == NavigationBarAlignment.spaceEvenly) {
        children.add(const Spacer());
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(child: rawChildren[i]));
        }
        children.add(const Spacer());
      } else if (alignment == NavigationBarAlignment.spaceAround) {
        children.add(const Spacer());
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(flex: 2, child: rawChildren[i]));
        }
        children.add(const Spacer());
      } else if (alignment == NavigationBarAlignment.spaceBetween) {
        for (var i = 0; i < rawChildren.length; i++) {
          if (i > 0) {
            children.add(const Spacer());
          }
          children.add(Expanded(flex: 2, child: rawChildren[i]));
        }
      } else {
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(child: rawChildren[i]));
        }
      }
    }
    return SurfaceBlur(
      surfaceBlur: widget.surfaceBlur,
      child: RepaintBoundary(
        child: Data.inherit(
          data: NavigationControlData(
            containerType: NavigationContainerType.bar,
            parentLabelType: labelType,
            parentLabelSize: labelSize,
            parentPadding: resolvedPadding,
            direction: direction,
            selectedIndex: widget.index,
            onSelected: _onSelected,
            parentLabelPosition: labelPosition,
            expanded: expanded,
            childCount: children.length,
            spacing: spacing,
            keepCrossAxisSize: widget.keepCrossAxisSize ?? false,
            keepMainAxisSize: widget.keepMainAxisSize ?? false,
          ),
          child: Container(
            color:
                backgroundColor ??
                theme.colorScheme.background.scaleAlpha(
                  widget.surfaceOpacity ?? 1,
                ),
            padding: resolvedPadding,
            child: _wrapIntrinsic(
              Flex(
                direction: direction,
                mainAxisAlignment: alignment.mainAxisAlignment,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wrapIntrinsic(Widget child) {
    if (widget.direction == Axis.horizontal) {
      return IntrinsicHeight(child: child);
    }
    return IntrinsicWidth(child: child);
  }
}
