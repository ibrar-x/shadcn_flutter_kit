part of '../../resizable.dart';

class _ResizablePanelState extends State<ResizablePanel> {
  final List<ResizablePaneController> _controllers = [];
  final Set<int> _hoveredDividers = {};
  final Set<int> _draggingDividers = {};
  late double _panelSize;

  List<ResizableItem> computeDraggers() {
    List<ResizableItem> draggers = [];
    List<ResizablePaneController> controllers = _controllers;
    controllers.sort((a, b) {
      var stateA = a._paneState;
      var stateB = b._paneState;
      if (stateA == null || stateB == null) {
        return 0;
      }
      var widgetA = stateA.widget;
      var widgetB = stateB.widget;
      var indexWidgetA = widget.children.indexOf(widgetA);
      var indexWidgetB = widget.children.indexOf(widgetB);
      return indexWidgetA.compareTo(indexWidgetB);
    });
    for (final controller in controllers) {
      double computedSize = controller.computeSize(
        _panelSize,
        minSize: controller.collapsed
            ? null
            : controller._paneState!.widget.minSize,
        maxSize: controller.collapsed
            ? null
            : controller._paneState!.widget.maxSize,
      );
      draggers.add(
        _ResizableItem(
          value: computedSize,
          min: controller._paneState!.widget.minSize ?? 0,
          max: controller._paneState!.widget.maxSize ?? double.infinity,
          controller: controller,
          collapsed: controller.collapsed,
          collapsedSize: controller._paneState!.widget.collapsedSize,
        ),
      );
    }
    return draggers;
  }

  void updateDraggers(List<ResizableItem> draggers) {
    for (var i = 0; i < draggers.length; i++) {
      final item = draggers[i];
      if (item is _ResizableItem) {
        final controller = item.controller;
        if (item.newCollapsed) {
          controller.collapse();
        } else {
          controller.expand();
        }
        controller.resize(item.newValue, _panelSize);
      }
    }
  }

  void attachController(ResizablePaneController controller) {
    _controllers.add(controller);
  }

  void detachController(ResizablePaneController controller) {
    _controllers.remove(controller);
  }

  @override
  void didUpdateWidget(covariant ResizablePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.optionalDivider != oldWidget.optionalDivider) {
      if (!widget.optionalDivider) {
        _hoveredDividers.clear();
        _draggingDividers.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: ResizableData(widget.direction),
      child: Builder(builder: _build),
    );
  }

  Widget _build(BuildContext context) {
    List<Widget> dividers = [];
    if (widget.direction == Axis.horizontal) {
      for (var i = 0; i < widget.children.length - 1; i++) {
        Widget divider =
            widget.dividerBuilder?.call(context) ?? const SizedBox();
        dividers.add(divider);
      }
    } else {
      for (var i = 0; i < widget.children.length - 1; i++) {
        Widget divider =
            widget.dividerBuilder?.call(context) ?? const SizedBox();
        dividers.add(divider);
      }
    }
    List<Widget> children = [];
    for (var i = 0; i < widget.children.length; i++) {
      children.add(
        Data<_ResizablePanelData>.inherit(
          key: widget.children[i].key,
          data: _ResizablePanelData(this, i),
          child: widget.children[i],
        ),
      );
      if (i < dividers.length) {
        children.add(
          _ResizableLayoutChild(
            isDivider: true,
            child: widget.optionalDivider
                ? AnimatedOpacity(
                    opacity:
                        _hoveredDividers.contains(i) ||
                            _draggingDividers.contains(i)
                        ? 1.0
                        : 0.0,
                    duration: kDefaultDuration,
                    child: dividers[i],
                  )
                : dividers[i],
          ),
        );
      }
    }
    if (widget.draggerBuilder != null) {
      for (var i = 0; i < widget.children.length - 1; i++) {
        children.add(
          _ResizableLayoutChild(
            index: i,
            isDragger: true,
            // child: widget.draggerBuilder!(context) ?? const SizedBox(),
            child: widget.optionalDivider
                ? AnimatedOpacity(
                    opacity:
                        _hoveredDividers.contains(i) ||
                            _draggingDividers.contains(i)
                        ? 1.0
                        : 0.0,
                    duration: kDefaultDuration,
                    child: widget.draggerBuilder!(context) ?? const SizedBox(),
                  )
                : widget.draggerBuilder!(context) ?? const SizedBox(),
          ),
        );
      }
    }
    for (var i = 0; i < widget.children.length - 1; i++) {
      children.add(
        _ResizableLayoutChild(
          index: i,
          isDragger: false,
          child: MouseRegion(
            onEnter: (_) {
              if (!widget.optionalDivider) return;
              setState(() {
                _hoveredDividers.add(i);
              });
            },
            onExit: (_) {
              if (!widget.optionalDivider) return;
              setState(() {
                _hoveredDividers.remove(i);
              });
            },
            child: _Resizer(
              direction: widget.direction,
              index: i,
              thickness: widget.draggerThickness ?? 8,
              panelState: this,
              onResizeStart: () {
                if (!widget.optionalDivider) return;
                setState(() {
                  _draggingDividers.add(i);
                });
              },
              onResizeEnd: () {
                if (!widget.optionalDivider) return;
                setState(() {
                  _draggingDividers.remove(i);
                });
              },
            ),
          ),
        ),
      );
    }
    return _ResizableLayout(
      direction: widget.direction,
      onLayout: (panelSize, flexCount) {
        _panelSize = panelSize;
      },
      children: children,
    );
  }
}
