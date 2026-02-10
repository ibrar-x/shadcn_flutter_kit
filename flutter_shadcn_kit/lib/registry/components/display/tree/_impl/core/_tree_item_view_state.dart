part of '../../tree.dart';

class _TreeItemViewState extends State<TreeItemView> {
  late FocusNode _focusNode;
  final WidgetStatesController _statesController = WidgetStatesController();

  TreeNodeData? _data;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant TreeItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    if (_data != null && _focusNode.hasFocus) {
      _data!.onFocusChanged?.call(FocusChangeReason.focusScope);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newData = Data.maybeOf<TreeNodeData>(context);
    if (_data != newData) {
      _data = newData;
      if (_data != null) {
        _statesController.update(WidgetState.selected, _data!.node.selected);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final data = _data;
    assert(data != null, 'TreeItemView must be a descendant of TreeView');
    List<Widget> rowChildren = [];
    if (data!.expandIcon)
      rowChildren.add(SizedBox(width: theme.density.baseGap * scaling));
    for (int i = 0; i < data.depth.length; i++) {
      if (i == 0) {
        continue; // skip the first depth
      }
      if (!data.expandIcon)
        rowChildren.add(SizedBox(width: theme.density.baseGap * scaling));
      rowChildren.add(
        SizedBox(
          width: 16 * scaling,
          child: data.indentGuide.build(context, data.depth, i),
        ),
      );
    }
    List<Widget> subRowChildren = [];
    if (data.expandIcon) {
      if (widget.expandable ?? data.node.children.isNotEmpty) {
        rowChildren.add(
          GestureDetector(
            onTap: () {
              if (widget.onExpand != null) {
                widget.onExpand!(!data.node.expanded);
              }
            },
            child: AnimatedRotation(
              duration: kDefaultDuration,
              turns: data.node.expanded ? 0.25 : 0,
              child: const Icon(Icons.chevron_right).iconSmall(),
            ),
          ),
        );
      } else {
        if (data.depth.length > 1) {
          rowChildren.add(
            SizedBox(
              width: 16 * scaling,
              child: data.indentGuide.build(context, data.depth, -1),
            ),
          );
        } else {
          rowChildren.add(
            SizedBox(width: theme.density.baseContentPadding * scaling),
          );
        }
      }
    }
    if (widget.leading != null) {
      subRowChildren.add(widget.leading!);
      subRowChildren.add(SizedBox(width: theme.density.baseGap * scaling));
    }
    subRowChildren.add(Expanded(child: widget.child));
    if (widget.trailing != null) {
      subRowChildren.add(SizedBox(width: theme.density.baseGap * scaling));
      subRowChildren.add(widget.trailing!);
    }
    rowChildren.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.density.baseGap * scaling,
            vertical: theme.density.baseGap * scaling * 0.5,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: subRowChildren,
          ),
        ),
      ),
    );
    return ExcludeFocus(
      excluding: !data.expanded && !data.node.expanded,
      child: DefaultTextStyle.merge(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        child: AnimatedCrossFade(
          duration: kDefaultDuration,
          firstCurve: Curves.easeInOut,
          secondCurve: Curves.easeInOut,
          crossFadeState: data.expanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          secondChild: const SizedBox(),
          firstChild: IntrinsicHeight(
            child: Clickable(
              focusNode: _focusNode,
              focusOutline: !(_data?.node.selected ?? false),
              disableTransition: true,
              statesController: _statesController,
              shortcuts: {
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty))
                  LogicalKeySet(LogicalKeyboardKey.arrowRight):
                      const ExpandTreeNodeIntent(),
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty))
                  LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                      const CollapseTreeNodeIntent(),
              },
              actions: {
                ActivateIntent: CallbackAction(
                  onInvoke: (e) {
                    if (widget.onExpand != null &&
                        (widget.expandable ?? data.node.children.isNotEmpty)) {
                      widget.onExpand!(!data.node.expanded);
                    }
                    widget.onPressed?.call();
                    return null;
                  },
                ),
                CollapseTreeNodeIntent: CallbackAction(
                  onInvoke: (e) {
                    if (widget.onExpand != null &&
                        (widget.expandable ?? data.node.children.isNotEmpty)) {
                      widget.onExpand!(false);
                    }
                    return null;
                  },
                ),
                ExpandTreeNodeIntent: CallbackAction(
                  onInvoke: (e) {
                    if (widget.onExpand != null &&
                        (widget.expandable ?? data.node.children.isNotEmpty)) {
                      widget.onExpand!(true);
                    }
                    return null;
                  },
                ),
              },
              decoration: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  if (states.contains(WidgetState.focused)) {
                    return BoxDecoration(
                      color: theme.colorScheme.primary.scaleAlpha(0.1),
                      borderRadius: _borderRadiusFromPosition(
                        data.selectionPosition,
                        theme.radiusMd,
                      ),
                    );
                  }
                  return BoxDecoration(
                    color: theme.colorScheme.primary.scaleAlpha(0.05),
                    borderRadius: _borderRadiusFromPosition(
                      data.selectionPosition,
                      theme.radiusMd,
                    ),
                  );
                }
                return const BoxDecoration();
              }),
              behavior: HitTestBehavior.translucent,
              mouseCursor:
                  widget.onDoublePressed != null ||
                      widget.onPressed != null ||
                      (widget.onExpand != null &&
                          (widget.expandable ?? data.node.children.isNotEmpty))
                  ? const WidgetStatePropertyAll(SystemMouseCursors.click)
                  : const WidgetStatePropertyAll(SystemMouseCursors.basic),
              onDoubleTap: () {
                if (widget.onDoublePressed != null) {
                  widget.onDoublePressed!();
                }
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty)) {
                  widget.onExpand!(!data.node.expanded);
                }
                _focusNode.requestFocus();
              },
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
                _focusNode.requestFocus();
                _data!.onFocusChanged?.call(FocusChangeReason.userInteraction);
              },
              enabled:
                  widget.onPressed != null ||
                  widget.onDoublePressed != null ||
                  (widget.onExpand != null &&
                      (widget.expandable ?? data.node.children.isNotEmpty)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: rowChildren,
              ),
            ),
          ),
        ).iconSmall(),
      ),
    );
  }
}
