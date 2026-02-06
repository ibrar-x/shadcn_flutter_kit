part of '../../switcher.dart';

class _SwitcherState extends State<Switcher> {
  late double _index;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _index = widget.index.toDouble();
  }

  @override
  void didUpdateWidget(covariant Switcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _index = widget.index.toDouble();
      _dragging = false; // cancels out dragging
    }
  }

  Widget buildDraggable(BuildContext context, Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (_) {
        _dragging = true;
      },
      onPanUpdate: (details) {
        if (_dragging) {
          final currentSize = context.size!;
          double delta;
          switch (widget.direction) {
            case AxisDirection.up:
              delta = -details.delta.dy / currentSize.height;
              break;
            case AxisDirection.down:
              delta = details.delta.dy / currentSize.height;
              break;
            case AxisDirection.left:
              delta = -details.delta.dx / currentSize.width;
              break;
            case AxisDirection.right:
              delta = details.delta.dx / currentSize.width;
              break;
          }
          setState(() {
            _index += delta;
            _index = _index.clamp(0, widget.children.length - 1).toDouble();
          });
        }
      },
      onPanEnd: (_) {
        _snapIndex();
      },
      onPanCancel: () {
        _snapIndex();
      },
      child: child,
    );
  }

  void _snapIndex() {
    setState(() {
      _dragging = false;
      _index = _index.roundToDouble();
      if (widget.onIndexChanged != null) {
        widget.onIndexChanged!(_index.toInt());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildDraggable(
      context,
      AnimatedValueBuilder(
        value: _index,
        duration: _dragging ? Duration.zero : widget.duration,
        curve: widget.curve,
        builder: (context, value, child) {
          final sourceChild = value.floor();
          final targetChild = value.ceil();
          final relativeProgress = value - sourceChild;
          return _SwitcherTransition(
            progress: relativeProgress,
            direction: widget.direction,
            absolute: false,
            children: [
              1 - relativeProgress == 0
                  ? const SizedBox.shrink()
                  : Opacity(
                      key: ValueKey(sourceChild),
                      opacity: 1 - relativeProgress,
                      child: widget.children[sourceChild],
                    ),
              relativeProgress == 0
                  ? const SizedBox.shrink()
                  : Opacity(
                      key: ValueKey(targetChild),
                      opacity: relativeProgress,
                      child: widget.children[targetChild],
                    ),
            ],
          );
        },
      ),
    );
  }
}
