part of '../../swiper.dart';

class _SwiperState extends State<Swiper> {
  DrawerOverlayCompleter? _activeOverlay;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  OverlayPosition get resolvedPosition {
    if (widget.position == OverlayPosition.start) {
      var textDirection = Directionality.of(context);
      return textDirection == TextDirection.ltr
          ? OverlayPosition.left
          : OverlayPosition.right;
    }
    if (widget.position == OverlayPosition.end) {
      var textDirection = Directionality.of(context);
      return textDirection == TextDirection.ltr
          ? OverlayPosition.right
          : OverlayPosition.left;
    }
    return widget.position;
  }

  void _onDrag(DragUpdateDetails details) {
    if (_activeOverlay != null) {
      var resolvedPosition = this.resolvedPosition;
      var controller = _activeOverlay!.animationController;
      double delta;
      switch (resolvedPosition) {
        case OverlayPosition.top:
        case OverlayPosition.left:
          delta = details.primaryDelta!;
          break;
        case OverlayPosition.bottom:
        case OverlayPosition.right:
          delta = -details.primaryDelta!;
          break;
        default:
          throw UnimplementedError('Unresolved position');
      }
      // normalize delta
      var size = _key.currentContext?.size;
      if (size == null) {
        return;
      }
      double axisSize;
      if (resolvedPosition == OverlayPosition.top ||
          resolvedPosition == OverlayPosition.bottom) {
        axisSize = size.height;
      } else {
        axisSize = size.width;
      }
      delta = delta / axisSize;
      controller?.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_activeOverlay != null) {
      var activeOverlay = _activeOverlay!;
      var controller = activeOverlay.animationController;
      if (controller != null) {
        if (controller.value < 0.5) {
          controller.reverse().then((value) {
            activeOverlay.remove();
          });
        } else {
          controller.forward();
        }
      }
      _activeOverlay = null;
    }
  }

  void _onDragCancel() {
    if (_activeOverlay != null) {
      var activeOverlay = _activeOverlay!;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        var controller = activeOverlay.animationController;
        if (controller != null) {
          controller.reverse().then((value) {
            activeOverlay.remove();
          });
        }
      });
      _activeOverlay = null;
    }
  }

  void _onDragStart(DragStartDetails details) {
    _onDragCancel();
    final compTheme = ComponentTheme.maybeOf<SwiperTheme>(context);
    _activeOverlay = widget.handler.openSwiper(
      context: context,
      builder: (context) {
        return KeyedSubtree(key: _key, child: widget.builder(context));
      },
      position: widget.position,
      expands: widget.expands ?? compTheme?.expands,
      draggable: widget.draggable ?? compTheme?.draggable,
      barrierDismissible:
          widget.barrierDismissible ?? compTheme?.barrierDismissible,
      backdropBuilder: widget.backdropBuilder ?? compTheme?.backdropBuilder,
      useSafeArea: widget.useSafeArea ?? compTheme?.useSafeArea,
      showDragHandle: widget.showDragHandle ?? compTheme?.showDragHandle,
      borderRadius: widget.borderRadius ?? compTheme?.borderRadius,
      dragHandleSize: widget.dragHandleSize ?? compTheme?.dragHandleSize,
      transformBackdrop:
          widget.transformBackdrop ?? compTheme?.transformBackdrop,
      surfaceOpacity: widget.surfaceOpacity ?? compTheme?.surfaceOpacity,
      surfaceBlur: widget.surfaceBlur ?? compTheme?.surfaceBlur,
      barrierColor: widget.barrierColor ?? compTheme?.barrierColor,
    );
  }

  Widget _buildGesture({required Widget child, required bool draggable}) {
    final compTheme = ComponentTheme.maybeOf<SwiperTheme>(context);
    final behavior =
        widget.behavior ?? compTheme?.behavior ?? HitTestBehavior.translucent;
    if (widget.position == OverlayPosition.top ||
        widget.position == OverlayPosition.bottom) {
      return GestureDetector(
        behavior: behavior,
        onVerticalDragUpdate: draggable ? _onDrag : null,
        onVerticalDragEnd: draggable ? _onDragEnd : null,
        onVerticalDragStart: draggable ? _onDragStart : null,
        onVerticalDragCancel: _onDragCancel,
        child: child,
      );
    }
    return GestureDetector(
      behavior: behavior,
      onHorizontalDragUpdate: draggable ? _onDrag : null,
      onHorizontalDragEnd: draggable ? _onDragEnd : null,
      onHorizontalDragStart: draggable ? _onDragStart : null,
      onHorizontalDragCancel: _onDragCancel,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGesture(child: widget.child, draggable: widget.enabled);
  }
}
