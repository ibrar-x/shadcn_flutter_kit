part of '../sortable.dart';

class _ScrollableSortableLayerState extends State<ScrollableSortableLayer>
    with SingleTickerProviderStateMixin {
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker(_scroll);
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  _SortableState? _attached;
  Offset? _globalPosition;
  Duration? _lastElapsed;
  void _scroll(Duration elapsed) {
    var position = _globalPosition;
    if (position != null && _lastElapsed != null) {
      var renderBox = context.findRenderObject() as RenderBox;
      position = renderBox.globalToLocal(position);
      int delta = elapsed.inMicroseconds - _lastElapsed!.inMicroseconds;
      double scrollDelta = 0;
      var pos = widget.controller.position.axisDirection == AxisDirection.down
          ? position.dy
          : position.dx;
      var size = widget.controller.position.axisDirection == AxisDirection.down
          ? renderBox.size.height
          : renderBox.size.width;
      if (pos < widget.scrollThreshold) {
        scrollDelta = -delta / 10000;
      } else if (pos > size - widget.scrollThreshold) {
        scrollDelta = delta / 10000;
      }
      for (var pos in widget.controller.positions) {
        pos.pointerScroll(scrollDelta);
      }
      _attached?._handleDrag(Offset.zero);
    }
    _lastElapsed = elapsed;
  }

  void _startDrag(_SortableState state, Offset globalPosition) {
    if (_attached != null && _attached!.context.mounted) {
      return;
    }
    _attached = state;
    _globalPosition = globalPosition;
    if (!ticker.isActive) {
      ticker.start();
    }
  }

  void _updateDrag(_SortableState state, Offset globalPosition) {
    if (state != _attached) {
      return;
    }
    _globalPosition = globalPosition;
  }

  void _endDrag(_SortableState state) {
    if (state != _attached) {
      return;
    }
    if (ticker.isActive) {
      ticker.stop();
    }
    _globalPosition = null;
    _attached = null;
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: this,
      child: widget.child,
    );
  }
}
