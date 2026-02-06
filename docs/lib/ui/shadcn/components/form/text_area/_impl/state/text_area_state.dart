part of '../../text_area.dart';

class _TextAreaState extends State<TextArea> {
  late double _height;
  late double _width;

  @override
  void initState() {
    super.initState();
    _height = widget.initialHeight;
    _width = widget.initialWidth;
  }

  @override
  void didUpdateWidget(covariant TextArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialHeight != oldWidget.initialHeight) {
      _height = widget.initialHeight;
    }
    if (widget.initialWidth != oldWidget.initialWidth) {
      _width = widget.initialWidth;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return SizedBox(
      height: _height,
      width: _width,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: widget.copyWith(
              expands: () => true,
              maxLines: () => null,
              minLines: () => null,
            ),
          ),
          Positioned(
            bottom: -1 * scaling,
            right: -1 * scaling,
            width: (8 + 8) * scaling,
            height: (8 + 8) * scaling,
            child: MouseRegion(
              hitTestBehavior: HitTestBehavior.translucent,
              cursor: widget.expandableWidth
                  ? widget.expandableHeight
                      ? SystemMouseCursors.resizeDownRight
                      : SystemMouseCursors.resizeLeftRight
                  : widget.expandableHeight
                      ? SystemMouseCursors.resizeUpDown
                      : SystemMouseCursors.basic,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanUpdate: (details) {
                  if (widget.expandableHeight && _height.isFinite) {
                    setState(() {
                      _height += details.delta.dy;
                      _height =
                          _height.clamp(widget.minHeight, widget.maxHeight);
                      widget.onHeightChanged?.call(_height);
                    });
                  }
                  if (widget.expandableWidth && _width.isFinite) {
                    setState(() {
                      _width += details.delta.dx;
                      _width = _width.clamp(widget.minWidth, widget.maxWidth);
                      widget.onWidthChanged?.call(_width);
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(4.0 * scaling),
                  child: CustomPaint(
                    painter: _TextAreaDragHandlePainter(
                        theme.colorScheme.foreground),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
