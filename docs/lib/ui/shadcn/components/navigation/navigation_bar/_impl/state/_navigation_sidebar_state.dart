part of '../../navigation_bar.dart';

class _NavigationSidebarState extends State<NavigationSidebar>
    with NavigationContainerMixin {
  BoxConstraints getDefaultConstraints(BuildContext context, ThemeData theme) {
    final scaling = theme.scaling;
    return BoxConstraints(
      minWidth: (200 * scaling).toDouble(),
      maxWidth: (200 * scaling).toDouble(),
    );
  }

  EdgeInsets _childPadding(EdgeInsets padding, Axis direction) {
    if (direction == Axis.vertical) {
      return EdgeInsets.only(left: padding.left, right: padding.right);
    }
    return EdgeInsets.only(top: padding.top, bottom: padding.bottom);
  }

  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    List<Widget> children = wrapChildren(context, widget.children);
    var parentPadding = widget.padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    const direction = Axis.vertical;
    return Data.inherit(
      data: NavigationControlData(
        containerType: NavigationContainerType.sidebar,
        parentLabelType: widget.labelType,
        parentLabelPosition: widget.labelPosition,
        parentLabelSize: widget.labelSize,
        parentPadding: resolvedPadding,
        direction: direction,
        onSelected: _onSelected,
        selectedIndex: widget.index,
        expanded: widget.expanded,
        childCount: children.length,
        spacing: widget.spacing ?? 0,
        keepCrossAxisSize: widget.keepCrossAxisSize,
        keepMainAxisSize: widget.keepMainAxisSize,
      ),
      child: ConstrainedBox(
        constraints:
            widget.constraints ?? getDefaultConstraints(context, theme),
        child: SurfaceBlur(
          surfaceBlur: widget.surfaceBlur,
          child: Container(
            color: widget.backgroundColor,
            child: ClipRect(
              child: RepaintBoundary(
                child: CustomScrollView(
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  scrollDirection: direction,
                  slivers: [
                    SliverGap(_startPadding(resolvedPadding, direction)),
                    ...children.map((e) {
                      return SliverPadding(
                        padding: _childPadding(
                          resolvedPadding,
                          direction,
                        ),
                        sliver: e,
                      ) as Widget;
                    }).toList().joinSeparator(
                          SliverGap(widget.spacing ?? 0),
                        ),
                    SliverGap(_endPadding(resolvedPadding, direction)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
