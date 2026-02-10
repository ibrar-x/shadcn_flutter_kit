part of '../../overlay.dart';

class PopoverOverlayWidgetState extends State<PopoverOverlayWidget>
    with SingleTickerProviderStateMixin, OverlayHandlerStateMixin {
  late BuildContext _anchorContext;
  late Offset? _position;
  late Offset? _offset;
  late AlignmentGeometry _alignment;
  late AlignmentGeometry _anchorAlignment;
  late PopoverConstraint _widthConstraint;
  late PopoverConstraint _heightConstraint;
  late EdgeInsetsGeometry? _margin;
  Size? _anchorSize;
  late bool _follow;
  late bool _allowInvertHorizontal;
  late bool _allowInvertVertical;
  late Ticker _ticker;
  late LayerLink? _layerLink;
  Offset? _followAnchorDelta;
  ScrollableState? _scrollable;
  ScrollPosition? _scrollPosition;
  bool _isClosingForRegionLoss = false;

  @override
  set offset(Offset? offset) {
    if (offset != null) {
      setState(() {
        _offset = offset;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _offset = widget.offset;
    _position = widget.position;
    _alignment = widget.alignment;
    _anchorSize = widget.anchorSize;
    _anchorAlignment = widget.anchorAlignment;
    _widthConstraint = widget.widthConstraint;
    _heightConstraint = widget.heightConstraint;
    _margin = widget.margin;
    _follow = widget.follow;
    _anchorContext = widget.anchorContext;
    _allowInvertHorizontal = widget.allowInvertHorizontal;
    _allowInvertVertical = widget.allowInvertVertical;
    _layerLink = widget.layerLink;
    _followAnchorDelta = null;
    _isClosingForRegionLoss = false;
    _ticker = createTicker(_tick);
    if (_follow && _layerLink == null) {
      _ticker.start();
    }
    _attachScrollListener();
    if (_follow) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _updatePosition();
        }
      });
    }
  }

  @override
  Future<void> close([bool immediate = false]) {
    if (!immediate) {
      return widget.onClose?.call() ?? Future.value();
    } else {
      widget.onImmediateClose?.call();
    }
    return Future.value();
  }

  @override
  void closeLater() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onClose?.call();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant PopoverOverlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.alignment != widget.alignment) {
      _alignment = widget.alignment;
    }
    if (oldWidget.anchorSize != widget.anchorSize) {
      _anchorSize = widget.anchorSize;
    }
    if (oldWidget.anchorAlignment != widget.anchorAlignment) {
      _anchorAlignment = widget.anchorAlignment;
    }
    if (oldWidget.widthConstraint != widget.widthConstraint) {
      _widthConstraint = widget.widthConstraint;
    }
    if (oldWidget.heightConstraint != widget.heightConstraint) {
      _heightConstraint = widget.heightConstraint;
    }
    if (oldWidget.offset != widget.offset) {
      _offset = widget.offset;
    }

    if (oldWidget.margin != widget.margin) {
      _margin = widget.margin;
    }
    if (oldWidget.follow != widget.follow) {
      _follow = widget.follow;
    }
    if (_layerLink != widget.layerLink) {
      _layerLink = widget.layerLink;
    }
    final shouldRunTicker = _follow && _layerLink == null;
    if (shouldRunTicker && !_ticker.isActive) {
      _ticker.start();
    } else if (!shouldRunTicker && _ticker.isActive) {
      _ticker.stop();
    }
    if (oldWidget.anchorContext != widget.anchorContext) {
      _anchorContext = widget.anchorContext;
      _attachScrollListener();
    }
    if (oldWidget.allowInvertHorizontal != widget.allowInvertHorizontal) {
      _allowInvertHorizontal = widget.allowInvertHorizontal;
    }
    if (oldWidget.allowInvertVertical != widget.allowInvertVertical) {
      _allowInvertVertical = widget.allowInvertVertical;
    }
    if (_follow) {
      _attachScrollListener();
      if (oldWidget.position != widget.position ||
          oldWidget.anchorAlignment != widget.anchorAlignment ||
          oldWidget.anchorContext != widget.anchorContext) {
        _followAnchorDelta = null;
      }
      _updatePosition();
    } else {
      _detachScrollListener();
    }
    if (oldWidget.position != widget.position && !_follow) {
      _position = widget.position;
    }
  }

  /// Gets the anchor widget's size.
  Size? get anchorSize => _anchorSize;

  /// Gets the anchor alignment for positioning.
  AlignmentGeometry get anchorAlignment => _anchorAlignment;

  /// Gets the explicit position offset.
  Offset? get position => _position;

  /// Gets the popover alignment.
  AlignmentGeometry get alignment => _alignment;

  /// Gets the width constraint strategy.
  PopoverConstraint get widthConstraint => _widthConstraint;

  /// Gets the height constraint strategy.
  PopoverConstraint get heightConstraint => _heightConstraint;

  /// Gets the position offset.
  Offset? get offset => _offset;

  /// Gets the margin around the popover.
  EdgeInsetsGeometry? get margin => _margin;

  /// Gets whether the popover follows the anchor on movement.
  bool get follow => _follow;

  /// Gets the anchor build context.
  BuildContext get anchorContext => _anchorContext;

  /// Gets whether horizontal inversion is allowed.
  bool get allowInvertHorizontal => _allowInvertHorizontal;

  /// Gets whether vertical inversion is allowed.
  bool get allowInvertVertical => _allowInvertVertical;

  /// Gets the layer link for positioning.
  LayerLink? get layerLink => _layerLink;

  /// Sets the layer link for positioning.
  ///
  /// Updates the layer link and manages ticker state for anchor tracking.
  set layerLink(LayerLink? value) {
    if (_layerLink != value) {
      setState(() {
        _layerLink = value;
        if (_follow && _layerLink == null) {
          if (!_ticker.isActive) {
            _ticker.start();
          }
        } else {
          _ticker.stop();
        }
      });
    }
  }

  @override
  set alignment(AlignmentGeometry value) {
    if (_alignment != value) {
      setState(() {
        _alignment = value;
      });
    }
  }

  /// Sets the popover position.
  ///
  /// Updates the explicit position and triggers a rebuild.
  set position(Offset? value) {
    if (_position != value) {
      setState(() {
        _position = value;
      });
    }
  }

  @override
  set anchorAlignment(AlignmentGeometry value) {
    if (_anchorAlignment != value) {
      setState(() {
        _anchorAlignment = value;
      });
    }
  }

  @override
  set widthConstraint(PopoverConstraint value) {
    if (_widthConstraint != value) {
      setState(() {
        _widthConstraint = value;
      });
    }
  }

  @override
  set heightConstraint(PopoverConstraint value) {
    if (_heightConstraint != value) {
      setState(() {
        _heightConstraint = value;
      });
    }
  }

  @override
  set margin(EdgeInsetsGeometry? value) {
    if (_margin != value) {
      setState(() {
        _margin = value;
      });
    }
  }

  @override
  set follow(bool value) {
    if (_follow != value) {
      setState(() {
        _follow = value;
      });
      if (_follow) {
        if (_layerLink == null && !_ticker.isActive) {
          _ticker.start();
        }
        _attachScrollListener();
        _followAnchorDelta = null;
        _updatePosition();
      } else {
        if (_ticker.isActive) {
          _ticker.stop();
        }
        _detachScrollListener();
      }
    }
  }

  @override
  set anchorContext(BuildContext value) {
    if (_anchorContext != value) {
      setState(() {
        _anchorContext = value;
      });
      _attachScrollListener();
      if (_follow) {
        _followAnchorDelta = null;
        _updatePosition();
      }
    }
  }

  @override
  set allowInvertHorizontal(bool value) {
    if (_allowInvertHorizontal != value) {
      setState(() {
        _allowInvertHorizontal = value;
      });
    }
  }

  @override
  set allowInvertVertical(bool value) {
    if (_allowInvertVertical != value) {
      setState(() {
        _allowInvertVertical = value;
      });
    }
  }

  @override
  void dispose() {
    _detachScrollListener();
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    _updatePosition();
  }

  Rect _globalRectForRenderBox(RenderBox box) {
    final topLeft = box.localToGlobal(Offset.zero);
    return topLeft & box.size;
  }

  Rect? _resolveVisibleRegionRect() {
    final scrollableRenderObject = _scrollable?.context.findRenderObject();
    if (scrollableRenderObject is RenderBox && scrollableRenderObject.hasSize) {
      return _globalRectForRenderBox(scrollableRenderObject);
    }
    final overlayRenderObject = context.findRenderObject();
    if (overlayRenderObject is RenderBox && overlayRenderObject.hasSize) {
      return _globalRectForRenderBox(overlayRenderObject);
    }
    return null;
  }

  void _updatePosition() {
    if (!mounted || !anchorContext.mounted) return;
    // update position based on anchorContext
    final renderObject = anchorContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;
    final anchorRect = _globalRectForRenderBox(renderObject);
    final visibleRegionRect = _resolveVisibleRegionRect();
    if (_follow &&
        visibleRegionRect != null &&
        !visibleRegionRect.overlaps(anchorRect)) {
      if (!_isClosingForRegionLoss) {
        _isClosingForRegionLoss = true;
        closeLater();
      }
      return;
    }
    _isClosingForRegionLoss = false;

    final pos = renderObject.localToGlobal(Offset.zero);
    final size = renderObject.size;
    final resolvedAnchorAlignment = _anchorAlignment.optionallyResolve(context);
    final anchorPosition = Offset(
      pos.dx + size.width / 2 + size.width / 2 * resolvedAnchorAlignment.x,
      pos.dy + size.height / 2 + size.height / 2 * resolvedAnchorAlignment.y,
    );

    Offset newPos = anchorPosition;
    if (_follow && widget.position != null) {
      _followAnchorDelta ??= widget.position! - anchorPosition;
      newPos = anchorPosition + _followAnchorDelta!;
    }

    if (_position != newPos || _anchorSize != size) {
      setState(() {
        _anchorSize = size;
        _position = newPos;
        widget.onTickFollow?.call(this);
      });
    }
  }

  void _attachScrollListener() {
    if (!_follow || !mounted || !anchorContext.mounted) return;
    final scrollable = Scrollable.maybeOf(anchorContext);
    if (scrollable == _scrollable && scrollable?.position == _scrollPosition) {
      return;
    }
    _detachScrollListener();
    _scrollable = scrollable;
    _scrollPosition = scrollable?.position;
    _scrollPosition?.addListener(_updatePosition);
  }

  void _detachScrollListener() {
    _scrollPosition?.removeListener(_updatePosition);
    _scrollPosition = null;
    _scrollable = null;
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = Data<OverlayHandlerStateMixin>.inherit(
      data: this,
      child: TapRegion(
        // enabled: widget.consumeOutsideTaps,
        onTapOutside: widget.onTapOutside != null
            ? (event) {
                widget.onTapOutside?.call();
              }
            : null,
        groupId: widget.regionGroupId,
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          removeLeft: true,
          removeRight: true,
          removeTop: true,
          child: Builder(
            builder: (context) {
              final theme = Theme.of(context);
              final scaling = theme.scaling;
              return PopoverLayout(
                alignment: _alignment.optionallyResolve(context),
                position: _position,
                anchorSize: _anchorSize,
                anchorAlignment: _anchorAlignment.optionallyResolve(context),
                widthConstraint: _widthConstraint,
                heightConstraint: _heightConstraint,
                offset: _offset,
                margin:
                    _margin?.optionallyResolve(context) ??
                    (const EdgeInsets.all(8) * scaling),
                scale: tweenValue(0.9, 1.0, widget.animation),
                scaleAlignment: (widget.transitionAlignment ?? _alignment)
                    .optionallyResolve(context),
                allowInvertVertical: _allowInvertVertical,
                allowInvertHorizontal: _allowInvertHorizontal,
                child: FadeTransition(
                  opacity: AlwaysStoppedAnimation<double>(widget.animation),
                  child: Builder(
                    builder: (context) {
                      return widget.builder(context);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
    if (widget.themes != null) {
      childWidget = widget.themes!.wrap(childWidget);
    }
    if (widget.data != null) {
      childWidget = widget.data!.wrap(childWidget);
    }
    return childWidget;
  }

  @override
  Future<void> closeWithResult<X>([X? value]) {
    return widget.onCloseWithResult?.call(value) ?? Future.value();
  }
}

/// Closes the current popover overlay.
///
/// Deprecated: Use [closeOverlay] instead.
///
/// Parameters:
/// - [context] (`BuildContext`, required): Widget context.
/// - [result] (`T?`, optional): Result to return when closing.
///
/// Returns: `Future<void>` — completes when popover is closed.
@Deprecated('Use closeOverlay instead')
Future<void> closePopover<T>(BuildContext context, [T? result]) {
  return closeOverlay<T>(context, result);
}

/// Implementation of [OverlayCompleter] for popover overlays.
///
/// Manages the lifecycle of a popover overlay entry, tracking completion
/// state and handling overlay/barrier entry disposal.
