part of '../../resizable.dart';

class _ResizablePaneState extends State<ResizablePane> {
  late ResizablePaneController _controller;

  _ResizablePanelData? _panelState;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else if (widget.initialSize != null) {
      _controller = AbsoluteResizablePaneController(
        widget.initialSize!,
        collapsed: widget.initialCollapsed!,
      );
    } else {
      assert(widget.initialFlex != null, 'initalFlex must not be null');
      _controller = FlexibleResizablePaneController(
        widget.initialFlex!,
        collapsed: widget.initialCollapsed!,
      );
    }
    _controller._attachPaneState(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newPanelState = Data.maybeOf<_ResizablePanelData>(context);
    if (_panelState != newPanelState) {
      _panelState?.detach(_controller);
      _panelState = newPanelState;
      _panelState?.attach(_controller);
    }
  }

  @override
  void didUpdateWidget(covariant ResizablePane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller._detachPaneState(this);
      _panelState?.detach(_controller);
      if (widget.controller != null) {
        _controller = widget.controller!;
      } else if (widget.initialSize != null) {
        if (_controller is! AbsoluteResizablePaneController) {
          _controller = AbsoluteResizablePaneController(
            widget.initialSize!,
            collapsed: widget.initialCollapsed!,
          );
        }
      } else {
        if (_controller is! FlexibleResizablePaneController) {
          assert(widget.initialFlex != null, 'initalFlex must not be null');
          _controller = FlexibleResizablePaneController(
            widget.initialFlex!,
            collapsed: widget.initialCollapsed!,
          );
        }
      }
      _panelState?.attach(_controller);
      assert(
        _panelState != null,
        'ResizablePane must be a child of ResizablePanel',
      );
      _controller._attachPaneState(this);
    }
  }

  bool tryExpand([PanelSibling direction = PanelSibling.both]) {
    if (!_controller.collapsed) {
      return false;
    }
    List<ResizableItem> draggers = _panelState!.state.computeDraggers();
    Resizer resizer = Resizer(draggers);
    bool result = resizer.attemptExpandCollapsed(
      _panelState!.index,
      direction.direction,
    );
    if (result) {
      _panelState!.state.updateDraggers(resizer.items);
    }
    return result;
  }

  bool tryCollapse([PanelSibling direction = PanelSibling.both]) {
    if (_controller.collapsed) {
      return false;
    }
    List<ResizableItem> draggers = _panelState!.state.computeDraggers();
    Resizer resizer = Resizer(draggers);
    bool result = resizer.attemptCollapse(
      _panelState!.index,
      direction.direction,
    );
    if (result) {
      _panelState!.state.updateDraggers(resizer.items);
    }
    return result;
  }

  bool tryExpandSize(
    double size, [
    PanelSibling direction = PanelSibling.both,
  ]) {
    List<ResizableItem> draggers = _panelState!.state.computeDraggers();
    Resizer resizer = Resizer(draggers);
    bool result = resizer.attemptExpand(
      _panelState!.index,
      direction.direction,
      size,
    );
    if (result) {
      _panelState!.state.updateDraggers(resizer.items);
    }
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    _controller._detachPaneState(this);
    _panelState?.detach(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        double? size;
        double? flex;
        if (_controller is AbsoluteResizablePaneController) {
          final controller = _controller as AbsoluteResizablePaneController;
          if (controller.collapsed) {
            size = widget.collapsedSize;
          } else {
            size = controller.value;
          }
        } else if (_controller is FlexibleResizablePaneController) {
          final controller = _controller as FlexibleResizablePaneController;
          if (controller.collapsed) {
            size = widget.collapsedSize;
          } else {
            flex = controller.value;
          }
        }
        return _ResizableLayoutChild(
          size: size,
          flex: flex,
          child: ClipRect(child: widget.child),
        );
      },
    );
  }
}
