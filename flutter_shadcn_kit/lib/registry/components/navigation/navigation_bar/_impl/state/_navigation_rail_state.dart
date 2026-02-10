part of '../../navigation_bar.dart';

class _NavigationRailState extends State<NavigationRail>
    with NavigationContainerMixin {
  AlignmentGeometry get _alignment {
    switch ((widget.alignment, widget.direction)) {
      case (NavigationRailAlignment.start, Axis.horizontal):
        return AlignmentDirectional.centerStart;
      case (NavigationRailAlignment.center, Axis.horizontal):
        return AlignmentDirectional.topCenter;
      case (NavigationRailAlignment.end, Axis.horizontal):
        return AlignmentDirectional.centerEnd;
      case (NavigationRailAlignment.start, Axis.vertical):
        return AlignmentDirectional.topCenter;
      case (NavigationRailAlignment.center, Axis.vertical):
        return AlignmentDirectional.center;
      case (NavigationRailAlignment.end, Axis.vertical):
        return AlignmentDirectional.bottomCenter;
    }
  }

  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var parentPadding =
        widget.padding ??
        (EdgeInsets.symmetric(
          vertical: theme.density.baseGap * scaling,
          horizontal: theme.density.baseContentPadding * scaling * 0.75,
        ));
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    return RepaintBoundary(
      child: Data.inherit(
        data: NavigationControlData(
          containerType: NavigationContainerType.rail,
          parentLabelType: widget.labelType,
          parentLabelPosition: widget.labelPosition,
          parentLabelSize: widget.labelSize,
          parentPadding: resolvedPadding,
          direction: widget.direction,
          selectedIndex: widget.index,
          onSelected: _onSelected,
          expanded: widget.expanded,
          childCount: widget.children.length,
          spacing: widget.spacing ?? (theme.density.baseGap * scaling),
          keepCrossAxisSize: widget.keepCrossAxisSize,
          keepMainAxisSize: widget.keepMainAxisSize,
        ),
        child: SurfaceBlur(
          surfaceBlur: widget.surfaceBlur,
          child: Container(
            color:
                widget.backgroundColor ??
                (theme.colorScheme.background.scaleAlpha(
                  widget.surfaceOpacity ?? 1,
                )),
            alignment: _alignment,
            child: SingleChildScrollView(
              scrollDirection: widget.direction,
              padding: resolvedPadding,
              child: _wrapIntrinsic(
                Flex(
                  direction: widget.direction,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: wrapChildren(context, widget.children),
                ),
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
