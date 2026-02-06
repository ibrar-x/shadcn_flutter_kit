part of '../../refresh_trigger.dart';

class RefreshTriggerState extends State<RefreshTrigger>
    with SingleTickerProviderStateMixin {
  double _currentExtent = 0;
  bool _scrolling = false;
  ScrollDirection _userScrollDirection = ScrollDirection.idle;
  TriggerStage _stage = TriggerStage.idle;
  Future<void>? _currentFuture;
  int _currentFutureCount = 0;

  // Computed theme values
  late double _minExtent;
  late double _maxExtent;
  late RefreshIndicatorBuilder _indicatorBuilder;
  late Curve _curve;
  late Duration _completeDuration;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateThemeValues();
  }

  @override
  void didUpdateWidget(RefreshTrigger oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateThemeValues();
  }

  void _updateThemeValues() {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<RefreshTriggerTheme>(context);

    _minExtent = styleValue(
        widgetValue: widget.minExtent,
        themeValue: compTheme?.minExtent,
        defaultValue: 75.0 * theme.scaling);
    _maxExtent = styleValue(
        widgetValue: widget.maxExtent,
        themeValue: compTheme?.maxExtent,
        defaultValue: 150.0 * theme.scaling);
    _indicatorBuilder = widget.indicatorBuilder ??
        compTheme?.indicatorBuilder ??
        RefreshTrigger.defaultIndicatorBuilder;
    _curve = widget.curve ?? compTheme?.curve ?? Curves.easeOutSine;
    _completeDuration = widget.completeDuration ??
        compTheme?.completeDuration ??
        const Duration(milliseconds: 500);
  }

  double _calculateSafeExtent(double extent) {
    if (widget.reverse) {
      extent = -extent;
    }
    if (extent > _minExtent) {
      double relativeExtent = extent - _minExtent;
      double maxExtent = _maxExtent;
      double diff = (maxExtent - _minExtent) - relativeExtent;
      double diffNormalized = diff / (maxExtent - _minExtent);
      return maxExtent - _decelerateCurve(diffNormalized.clamp(0, 1)) * diff;
    }
    return extent;
  }

  double _decelerateCurve(double value) {
    return Curves.decelerate.transform(value);
  }

  Widget _wrapPositioned(Widget child) {
    if (widget.direction == Axis.vertical) {
      return Positioned(
        top: !widget.reverse ? 0 : null,
        bottom: !widget.reverse ? null : 0,
        left: 0,
        right: 0,
        child: child,
      );
    } else {
      return Positioned(
        top: 0,
        bottom: 0,
        left: widget.reverse ? null : 0,
        right: widget.reverse ? 0 : null,
        child: child,
      );
    }
  }

  Offset get _offset {
    if (widget.direction == Axis.vertical) {
      return Offset(0, widget.reverse ? 1 : -1);
    } else {
      return Offset(widget.reverse ? 1 : -1, 0);
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0) {
      return false;
    }
    if (notification is ScrollEndNotification && _scrolling) {
      setState(() {
        double normalizedExtent =
            widget.reverse ? -_currentExtent : _currentExtent;
        if (normalizedExtent >= _minExtent) {
          _scrolling = false;
          refresh();
        } else {
          _stage = TriggerStage.idle;
          _currentExtent = 0;
        }
      });
    } else if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta;
      if (delta != null) {
        final axisDirection = notification.metrics.axisDirection;
        final normalizedDelta = (axisDirection == AxisDirection.down ||
                axisDirection == AxisDirection.right)
            ? -delta
            : delta;
        if (_stage == TriggerStage.pulling) {
          final forward = normalizedDelta > 0;
          if ((forward && _userScrollDirection == ScrollDirection.forward) ||
              (!forward && _userScrollDirection == ScrollDirection.reverse)) {
            setState(() {
              _currentExtent +=
                  widget.reverse ? -normalizedDelta : normalizedDelta;
            });
          } else {
            if (_currentExtent >= _minExtent) {
              _scrolling = false;
              refresh();
            } else {
              setState(() {
                _currentExtent +=
                    widget.reverse ? -normalizedDelta : normalizedDelta;
              });
            }
          }
        } else if (_stage == TriggerStage.idle &&
            (widget.reverse
                ? notification.metrics.extentAfter == 0
                : notification.metrics.extentBefore == 0) &&
            (widget.reverse ? -normalizedDelta : normalizedDelta) > 0) {
          setState(() {
            _currentExtent = 0;
            _scrolling = true;
            _stage = TriggerStage.pulling;
          });
        }
      }
    } else if (notification is UserScrollNotification) {
      _userScrollDirection = notification.direction;
    } else if (notification is OverscrollNotification) {
      final axisDirection = notification.metrics.axisDirection;
      final overscroll = (axisDirection == AxisDirection.down ||
              axisDirection == AxisDirection.right)
          ? -notification.overscroll
          : notification.overscroll;
      if (overscroll > 0) {
        if (_stage == TriggerStage.idle) {
          setState(() {
            _currentExtent = 0;
            _scrolling = true;
            _stage = TriggerStage.pulling;
          });
        } else {
          setState(() {
            _currentExtent += overscroll;
          });
        }
      }
    }
    return false;
  }

  /// Triggers a refresh programmatically.
  ///
  /// Initiates the refresh animation and invokes the provided callback or
  /// widget's [onRefresh] callback. Can be called from parent widgets to
  /// trigger refresh without user gesture.
  ///
  /// Parameters:
  /// - [refreshCallback]: Optional callback to use instead of widget's onRefresh
  ///
  /// Returns a Future that completes when refresh finishes.
  Future<void> refresh([FutureVoidCallback? refreshCallback]) async {
    _scrolling = false;
    int count = ++_currentFutureCount;
    if (_currentFuture != null) {
      await _currentFuture;
    }
    setState(() {
      _currentFuture = _refresh(refreshCallback);
    });
    return _currentFuture!.whenComplete(() {
      if (!mounted || count != _currentFutureCount) {
        return;
      }
      setState(() {
        _currentFuture = null;
        _stage = TriggerStage.completed;
        // Future.delayed works the same
        Timer(_completeDuration, () {
          if (!mounted) {
            return;
          }
          setState(() {
            _stage = TriggerStage.idle;
            _currentExtent = 0;
          });
        });
      });
    });
  }

  Future<void> _refresh([FutureVoidCallback? refresh]) {
    if (_stage != TriggerStage.refreshing) {
      setState(() {
        _stage = TriggerStage.refreshing;
      });
    }
    refresh ??= widget.onRefresh;
    return refresh?.call() ?? Future.value();
  }

  @override
  Widget build(BuildContext context) {
    var tween = _RefreshTriggerTween(_minExtent);
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: AnimatedValueBuilder<double>(
        value: _stage == TriggerStage.refreshing ||
                _stage == TriggerStage.completed
            ? _minExtent
            : _currentExtent,
        duration: _scrolling ? Duration.zero : kDefaultDuration,
        curve: _curve,
        builder: (context, value, _) {
          final extentAnimation =
              AlwaysStoppedAnimation<double>(tween.transform(value));
          final indicator = _indicatorBuilder(
            context,
            RefreshTriggerStage(
              _stage,
              extentAnimation,
              widget.direction,
              widget.reverse,
            ),
          );
          return Stack(
            fit: StackFit.passthrough,
            children: [
              widget.child,
              Positioned.fill(
                child: ClipRect(
                  child: Stack(
                    children: [
                      _wrapPositioned(
                        FractionalTranslation(
                          translation: _offset,
                          child: Transform.translate(
                            offset: widget.direction == Axis.vertical
                                ? Offset(0, _calculateSafeExtent(value))
                                : Offset(_calculateSafeExtent(value), 0),
                            child: indicator,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Lifecycle stages of a refresh trigger.
///
/// Represents the different states a refresh indicator can be in:
/// - [idle]: No refresh in progress, waiting for user interaction
/// - [pulling]: User is pulling but hasn't reached min extent
/// - [refreshing]: Refresh callback is executing
/// - [completed]: Refresh completed, showing completion state
enum TriggerStage {
  /// Idle state, no refresh in progress.
  idle,

  /// Pulling state, user is dragging the indicator.
  pulling,

  /// Refreshing state, async refresh operation is executing.
  refreshing,

  /// Completed state, refresh finished successfully.
  completed,
}

/// Immutable snapshot of refresh trigger state.
///
/// Provides information about the current refresh stage and pull extent
/// to indicator builders for rendering appropriate UI.
