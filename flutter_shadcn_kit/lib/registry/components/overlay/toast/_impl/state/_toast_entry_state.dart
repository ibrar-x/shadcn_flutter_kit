part of '../../toast.dart';

/// _ToastEntryState defines a reusable type for this registry module.
class _ToastEntryState extends State<ToastEntry>
    with SingleTickerProviderStateMixin {
  /// Stores `_controller` state/configuration for this implementation.
  late AnimationController _controller;
  Timer? _dismissTimer;
  Duration _remaining = Duration.zero;
  final Stopwatch _watch = Stopwatch();
  bool _dismissing = false;
  bool _mouseInside = false;
  bool _pointerDown = false;
  bool _dragging = false;
  bool _interactionActive = false;
  Offset _dragOffset = Offset.zero;

  bool get _swipeEnabled => widget.dismissDirections.isNotEmpty;

  @override
  /// Executes `initState` behavior for this component/composite.
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _controller.forward();
    _remaining = widget.duration;
    if (widget.autoDismiss) {
      _scheduleDismiss();
    }
  }

  @override
  void didUpdateWidget(covariant ToastEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dismissSignal != widget.dismissSignal &&
        widget.dismissSignal > 0 &&
        !_dismissing) {
      _dismiss();
      return;
    }
    if (oldWidget.duration != widget.duration &&
        widget.duration < _remaining &&
        !_dismissing) {
      _remaining = widget.duration;
      if (widget.autoDismiss) {
        _scheduleDismiss();
      }
    }
    if (oldWidget.autoDismiss == widget.autoDismiss || _dismissing) return;
    if (widget.autoDismiss) {
      _resumeIfIdle();
    } else {
      _pauseDismiss();
    }
  }

  void _scheduleDismiss() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    if (!widget.autoDismiss) return;
    if (_remaining <= Duration.zero || _dismissing) {
      _dismiss();
      return;
    }
    _watch
      ..reset()
      ..start();
    _dismissTimer = Timer(_remaining, _dismiss);
  }

  void _pauseDismiss() {
    if (_dismissing || _dismissTimer == null) return;
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _watch.stop();
    final elapsed = _watch.elapsed;
    _remaining = _remaining - elapsed;
    if (_remaining.isNegative) {
      _remaining = Duration.zero;
    }
  }

  void _resumeDismiss() {
    if (_dismissing || _dismissTimer != null || !widget.autoDismiss) return;
    _scheduleDismiss();
  }

  void _dismiss() {
    if (!mounted || _dismissing) return;
    _dismissing = true;
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _watch.stop();
    _controller.reverse().whenComplete(widget.onDismissed);
  }

  void _onPanStart(DragStartDetails details) {
    if (!_swipeEnabled || _dismissing) return;
    _beginInteraction();
    _dragging = true;
    _pauseDismiss();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_swipeEnabled || _dismissing) return;
    final constrained = _constrainOffset(_dragOffset + details.delta);
    if (constrained == _dragOffset) return;
    setState(() => _dragOffset = constrained);
  }

  void _onPanCancel() {
    if (!_swipeEnabled || _dismissing) {
      _dragging = false;
      _resumeIfIdle();
      return;
    }
    setState(() => _dragOffset = Offset.zero);
    _dragging = false;
    _endInteraction();
    _resumeIfIdle();
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_swipeEnabled || _dismissing) {
      _dragging = false;
      _resumeIfIdle();
      return;
    }
    final direction = _dominantDirection(_dragOffset);
    final distance = direction == null
        ? 0.0
        : _distanceInDirection(_dragOffset, direction);
    final velocity = direction == null
        ? 0.0
        : _distanceInDirection(details.velocity.pixelsPerSecond, direction);
    final shouldDismiss =
        direction != null &&
        widget.dismissDirections.contains(direction) &&
        (distance >= widget.dismissDragThreshold || velocity >= 850);

    _dragging = false;
    _endInteraction();

    if (shouldDismiss) {
      final handledExternally = widget.onDismissRequest?.call() ?? false;
      if (handledExternally) {
        setState(() => _dragOffset = Offset.zero);
        _resumeIfIdle();
        return;
      }
      setState(() => _dragOffset = _dismissOffset(direction));
      Future.delayed(const Duration(milliseconds: 190), () {
        if (mounted) _dismiss();
      });
      return;
    }
    setState(() => _dragOffset = Offset.zero);
    _resumeIfIdle();
  }

  void _resumeIfIdle() {
    if (_mouseInside || _pointerDown || _dragging || _dismissing) return;
    _resumeDismiss();
  }

  void _beginInteraction() {
    if (_interactionActive) return;
    _interactionActive = true;
    widget.onInteractionStart?.call();
  }

  void _endInteraction() {
    if (!_interactionActive) return;
    _interactionActive = false;
    widget.onInteractionEnd?.call();
  }

  Offset _constrainOffset(Offset offset) {
    var dx = offset.dx;
    var dy = offset.dy;
    final allowsLeft = widget.dismissDirections.contains(
      ToastSwipeDirection.left,
    );
    final allowsRight = widget.dismissDirections.contains(
      ToastSwipeDirection.right,
    );
    final allowsUp = widget.dismissDirections.contains(ToastSwipeDirection.up);
    final allowsDown = widget.dismissDirections.contains(
      ToastSwipeDirection.down,
    );
    final allowsHorizontal = allowsLeft || allowsRight;
    final allowsVertical = allowsUp || allowsDown;

    if (!allowsHorizontal) dx = 0;
    if (!allowsVertical) dy = 0;
    if (!allowsLeft && dx < 0) dx = 0;
    if (!allowsRight && dx > 0) dx = 0;
    if (!allowsUp && dy < 0) dy = 0;
    if (!allowsDown && dy > 0) dy = 0;

    return Offset(dx, dy);
  }

  ToastSwipeDirection? _dominantDirection(Offset offset) {
    if (offset == Offset.zero) return null;
    if (offset.dx.abs() >= offset.dy.abs()) {
      return offset.dx >= 0
          ? ToastSwipeDirection.right
          : ToastSwipeDirection.left;
    }
    return offset.dy >= 0 ? ToastSwipeDirection.down : ToastSwipeDirection.up;
  }

  double _distanceInDirection(Offset offset, ToastSwipeDirection direction) {
    return switch (direction) {
      ToastSwipeDirection.left =>
        (-offset.dx).clamp(0.0, double.infinity).toDouble(),
      ToastSwipeDirection.right =>
        offset.dx.clamp(0.0, double.infinity).toDouble(),
      ToastSwipeDirection.up =>
        (-offset.dy).clamp(0.0, double.infinity).toDouble(),
      ToastSwipeDirection.down =>
        offset.dy.clamp(0.0, double.infinity).toDouble(),
    };
  }

  Offset _dismissOffset(ToastSwipeDirection direction) {
    const amount = 260.0;
    return switch (direction) {
      ToastSwipeDirection.left => const Offset(-amount, 0),
      ToastSwipeDirection.right => const Offset(amount, 0),
      ToastSwipeDirection.up => const Offset(0, -amount),
      ToastSwipeDirection.down => const Offset(0, amount),
    };
  }

  @override
  /// Executes `dispose` behavior for this component/composite.
  void dispose() {
    _endInteraction();
    _dismissTimer?.cancel();
    _watch.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    Widget child = FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
      child: widget.child,
    );
    if (_swipeEnabled) {
      child = AnimatedSlide(
        duration: _dragging ? Duration.zero : const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        offset: Offset(_dragOffset.dx / 280, _dragOffset.dy / 120),
        child: child,
      );
      child = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.onTap,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        onPanCancel: _onPanCancel,
        child: child,
      );
    }
    if (!_swipeEnabled && widget.onTap != null) {
      child = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.onTap,
        child: child,
      );
    }
    if (!widget.pauseOnHover) {
      return child;
    }
    return Listener(
      onPointerDown: (_) {
        _beginInteraction();
        _pointerDown = true;
        _pauseDismiss();
      },
      onPointerUp: (_) {
        _pointerDown = false;
        _endInteraction();
        _resumeIfIdle();
      },
      onPointerCancel: (_) {
        _pointerDown = false;
        _endInteraction();
        _resumeIfIdle();
      },
      child: MouseRegion(
        onEnter: (_) {
          _beginInteraction();
          _mouseInside = true;
          _pauseDismiss();
        },
        onExit: (_) {
          _mouseInside = false;
          _endInteraction();
          _resumeIfIdle();
        },
        child: child,
      ),
    );
  }
}
