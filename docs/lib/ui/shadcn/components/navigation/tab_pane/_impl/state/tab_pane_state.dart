part of '../../tab_pane.dart';

class TabPaneState<T> extends State<TabPane<T>> {
  final ScrollController _scrollController = ScrollController();

  /// Drag gesture identifier for tab interactions.
  static const kTabDrag = #tabDrag;

  Widget _childBuilder(
      BuildContext context, TabContainerData data, Widget child) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<TabPaneTheme>(context);
    final isFocused = data.index == data.selected;
    final backgroundColor = widget.backgroundColor ??
        compTheme?.backgroundColor ??
        theme.colorScheme.card;
    final border = widget.border ?? compTheme?.border;
    final borderColor = border?.color ?? theme.colorScheme.border;
    final borderWidth = border?.width ?? 1;
    final borderRadius =
        (widget.borderRadius ?? compTheme?.borderRadius ?? theme.borderRadiusLg)
            .optionallyResolve(context);
    return Builder(builder: (context) {
      var tabGhost = Data.maybeOf<_TabGhostData>(context);
      return SizedBox(
          height: double.infinity,
          child: CustomPaint(
              painter: _TabItemPainter(
                  borderRadius: borderRadius,
                  backgroundColor: backgroundColor,
                  isFocused: isFocused || tabGhost != null,
                  borderColor: borderColor,
                  borderWidth: borderWidth),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8) * theme.scaling,
                  child: IntrinsicWidth(
                    child: child,
                  ))));
    });
  }

  List<TabChild> _buildTabItems() {
    List<TabChild> children = [];
    for (int i = 0; i < widget.items.length; i++) {
      children.add(widget.itemBuilder(context, widget.items[i], i));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<TabPaneTheme>(context);
    final BorderRadiusGeometry borderRadius =
        widget.borderRadius ?? compTheme?.borderRadius ?? theme.borderRadiusLg;
    final BorderRadius resolvedBorderRadius =
        borderRadius.optionallyResolve(context);
    final backgroundColor = widget.backgroundColor ??
        compTheme?.backgroundColor ??
        theme.colorScheme.card;
    final border = widget.border ?? compTheme?.border;
    final barHeight =
        widget.barHeight ?? compTheme?.barHeight ?? (32 * theme.scaling);
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context)
          .copyWith(scrollbars: false, overscroll: false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        verticalDirection: VerticalDirection.up,
        children: [
          Flexible(
            child: OutlinedContainer(
              borderRadius: resolvedBorderRadius,
              backgroundColor: backgroundColor,
              child: widget.child,
            ),
          ),
          Container(
            height: barHeight,
            padding: EdgeInsets.only(
              left: resolvedBorderRadius.bottomLeft.x,
              right: resolvedBorderRadius.bottomRight.x,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2) * theme.scaling,
                  child: Row(
                    spacing: 2 * theme.scaling,
                    children: widget.leading,
                  ),
                ),
                Flexible(
                  child: FadeScroll(
                    startOffset: resolvedBorderRadius.bottomLeft.x,
                    endOffset: resolvedBorderRadius.bottomRight.x,
                    gradient: [
                      Colors.white.withAlpha(0),
                    ],
                    endCrossOffset: border?.width ?? 1,
                    controller: _scrollController,
                    child: ClipRect(
                      clipper: _ClipRectWithAdjustment(border?.width ?? 1),
                      child: SortableLayer(
                        clipBehavior: Clip.none,
                        lock: true,
                        child: SortableDropFallback<T>(
                          onAccept: (value) {
                            if (value is! TabPaneData<T>) {
                              return;
                            }
                            bool wasFocused = widget.focused == value.data;
                            List<TabPaneData<T>> tabs = widget.items;
                            tabs.swapItem(value, tabs.length);
                            widget.onSort?.call(tabs);
                            if (wasFocused) {
                              widget.onFocused(tabs.length - 1);
                            }
                          },
                          child: ScrollableSortableLayer(
                            controller: _scrollController,
                            child: TabContainer(
                              selected: widget.focused,
                              onSelect: widget.onFocused,
                              builder: (context, children) {
                                return ListView.separated(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.none,
                                  padding: EdgeInsets.only(
                                    left: resolvedBorderRadius.bottomLeft.x,
                                    right: resolvedBorderRadius.bottomRight.x,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        widget.onFocused(index);
                                      },
                                      child: Sortable<T>(
                                        key: ValueKey(index),
                                        data: widget.items[index],
                                        enabled: widget.onSort != null,
                                        onDragStart: () {
                                          widget.onFocused(index);
                                        },
                                        onAcceptLeft: (value) {
                                          if (value is! TabPaneData<T>) {
                                            return;
                                          }
                                          List<TabPaneData<T>> tabs =
                                              widget.items;
                                          tabs.swapItem(value, index);
                                          widget.onSort?.call(tabs);
                                          widget.onFocused(index);
                                        },
                                        onAcceptRight: (value) {
                                          if (value is! TabPaneData<T>) {
                                            return;
                                          }
                                          List<TabPaneData<T>> tabs =
                                              widget.items;
                                          tabs.swapItem(value, index + 1);
                                          widget.onSort?.call(tabs);
                                          widget.onFocused(index);
                                        },
                                        ghost: Data.inherit(
                                          data: _TabGhostData(),
                                          child: children[index],
                                        ),
                                        child: children[index],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    bool beforeIsFocused =
                                        widget.focused == index;
                                    bool afterIsFocused =
                                        widget.focused == index + 1;
                                    if (!beforeIsFocused && !afterIsFocused) {
                                      return VerticalDivider(
                                        indent: 8 * theme.scaling,
                                        endIndent: 8 * theme.scaling,
                                        width: 8 * theme.scaling,
                                      );
                                    }
                                    return SizedBox(width: 8 * theme.scaling);
                                  },
                                  itemCount: children.length,
                                );
                              },
                              childBuilder: _childBuilder,
                              children: _buildTabItems(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2) * theme.scaling,
                  child: Row(
                    spacing: 2 * theme.scaling,
                    children: widget.trailing,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
