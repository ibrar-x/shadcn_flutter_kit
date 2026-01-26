part of '../sortable.dart';

class _SortableDragHandleState extends State<SortableDragHandle>
    with AutomaticKeepAliveClientMixin {
  _SortableState? _state;

  bool _dragging = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = Data.maybeOf<_SortableState>(context);
  }

  @override
  bool get wantKeepAlive {
    return _dragging;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MouseRegion(
      cursor: widget.enabled
          ? (widget.cursor ?? SystemMouseCursors.grab)
          : MouseCursor.defer,
      hitTestBehavior: widget.behavior,
      child: GestureDetector(
        behavior: widget.behavior,
        onPanStart: widget.enabled && _state != null
            ? (details) {
                _dragging = true;
                _state!._onDragStart(details);
              }
            : null,
        onPanUpdate:
            widget.enabled && _state != null ? _state!._onDragUpdate : null,
        onPanEnd: widget.enabled && _state != null
            ? (details) {
                _state!._onDragEnd(details);
                _dragging = false;
              }
            : null,
        onPanCancel: widget.enabled && _state != null
            ? () {
                _state!._onDragCancel();
                _dragging = false;
              }
            : null,
        child: widget.child,
      ),
    );
  }
}
