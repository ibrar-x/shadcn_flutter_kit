part of '../../resizable.dart';

class _ResizerState extends State<_Resizer> {
  Resizer? _dragSession;

  void _onDragStart(DragStartDetails details) {
    _dragSession = Resizer(
      widget.panelState.computeDraggers(),
    );

    // Call onSizeChangeStart callbacks for affected panes
    _callSizeChangeStartCallbacks();
    widget.onResizeStart?.call();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _dragSession!.dragDivider(widget.index + 1, details.primaryDelta!);
    widget.panelState.updateDraggers(_dragSession!.items);

    // Call onSizeChange callbacks for affected panes
    _callSizeChangeCallbacks();
  }

  void _onDragEnd(DragEndDetails details) {
    // Call onSizeChangeEnd callbacks for affected panes
    _callSizeChangeEndCallbacks();
    _dragSession = null;
    widget.onResizeEnd?.call();
  }

  void _onDragCancel() {
    _dragSession!.reset();
    widget.panelState.updateDraggers(_dragSession!.items);

    // Call onSizeChangeCancel callbacks for affected panes
    _callSizeChangeCancelCallbacks();
    _dragSession = null;
    widget.onResizeEnd?.call();
  }

  void _callSizeChangeStartCallbacks() {
    if (_dragSession == null) return;

    // Call callbacks for the two panes adjacent to this divider
    _callStartCallbackForPane(
        widget.index, _dragSession!.items[widget.index].value);
    if (widget.index + 1 < _dragSession!.items.length) {
      _callStartCallbackForPane(
          widget.index + 1, _dragSession!.items[widget.index + 1].value);
    }
  }

  void _callSizeChangeCallbacks() {
    if (_dragSession == null) return;

    // Call callbacks for the two panes adjacent to this divider
    _callChangeCallbackForPane(
        widget.index, _dragSession!.items[widget.index].newValue);
    if (widget.index + 1 < _dragSession!.items.length) {
      _callChangeCallbackForPane(
          widget.index + 1, _dragSession!.items[widget.index + 1].newValue);
    }
  }

  void _callSizeChangeEndCallbacks() {
    if (_dragSession == null) return;

    // Call callbacks for the two panes adjacent to this divider
    _callEndCallbackForPane(
        widget.index, _dragSession!.items[widget.index].newValue);
    if (widget.index + 1 < _dragSession!.items.length) {
      _callEndCallbackForPane(
          widget.index + 1, _dragSession!.items[widget.index + 1].newValue);
    }
  }

  void _callSizeChangeCancelCallbacks() {
    if (_dragSession == null) return;

    // Call callbacks for the two panes adjacent to this divider
    _callCancelCallbackForPane(
        widget.index, _dragSession!.items[widget.index].newValue);
    if (widget.index + 1 < _dragSession!.items.length) {
      _callCancelCallbackForPane(
          widget.index + 1, _dragSession!.items[widget.index + 1].newValue);
    }
  }

  ResizablePaneController? _getControllerAtIndex(int paneIndex) {
    if (paneIndex < 0 ||
        paneIndex >= widget.panelState.widget.children.length) {
      return null;
    }

    // Find controller by matching the widget at the given index
    final targetWidget = widget.panelState.widget.children[paneIndex];
    for (final controller in widget.panelState._controllers) {
      final paneState = controller._paneState;
      if (paneState?.widget == targetWidget) {
        return controller;
      }
    }
    return null;
  }

  void _callStartCallbackForPane(int paneIndex, double size) {
    final controller = _getControllerAtIndex(paneIndex);
    final callback = controller?._paneState?.widget.onSizeChangeStart;
    callback?.call(size);
  }

  void _callChangeCallbackForPane(int paneIndex, double size) {
    final controller = _getControllerAtIndex(paneIndex);
    final callback = controller?._paneState?.widget.onSizeChange;
    callback?.call(size);
  }

  void _callEndCallbackForPane(int paneIndex, double size) {
    final controller = _getControllerAtIndex(paneIndex);
    final callback = controller?._paneState?.widget.onSizeChangeEnd;
    callback?.call(size);
  }

  void _callCancelCallbackForPane(int paneIndex, double size) {
    final controller = _getControllerAtIndex(paneIndex);
    final callback = controller?._paneState?.widget.onSizeChangeCancel;
    callback?.call(size);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.direction == Axis.horizontal ? widget.thickness : null,
      height: widget.direction == Axis.vertical ? widget.thickness : null,
      child: MouseRegion(
        cursor: widget.direction == Axis.horizontal
            ? SystemMouseCursors.resizeColumn
            : SystemMouseCursors.resizeRow,
        hitTestBehavior: HitTestBehavior.translucent,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragStart:
              widget.direction == Axis.vertical ? _onDragStart : null,
          onHorizontalDragStart:
              widget.direction == Axis.horizontal ? _onDragStart : null,
          onVerticalDragUpdate:
              widget.direction == Axis.vertical ? _onDragUpdate : null,
          onHorizontalDragUpdate:
              widget.direction == Axis.horizontal ? _onDragUpdate : null,
          onVerticalDragEnd:
              widget.direction == Axis.vertical ? _onDragEnd : null,
          onHorizontalDragEnd:
              widget.direction == Axis.horizontal ? _onDragEnd : null,
          onVerticalDragCancel:
              widget.direction == Axis.vertical ? _onDragCancel : null,
          onHorizontalDragCancel:
              widget.direction == Axis.horizontal ? _onDragCancel : null,
        ),
      ),
    );
  }
}
