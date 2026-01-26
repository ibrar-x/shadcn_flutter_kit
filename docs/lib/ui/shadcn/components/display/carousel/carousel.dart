import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../../shared/theme/theme.dart';
import '../../../shared/utils/animation_queue.dart';
import '../../../shared/utils/style_value.dart';
import '../../../shared/utils/wrap_utils.dart';
import '../dot_indicator/dot_indicator.dart';

part '_impl/carousel_controller.dart';
part '_impl/carousel_dot_indicator.dart';
part '_impl/carousel_layout.dart';
part '_impl/carousel_theme.dart';

/// Interactive carousel widget with automatic transitions and customizable layouts.
class Carousel extends StatefulWidget {
  /// The carousel transition.
  final CarouselTransition transition;

  /// The item builder.
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// The duration of the carousel.
  final Duration? duration;

  /// The duration builder of the carousel.
  final Duration? Function(int index)? durationBuilder;

  /// The item count of the carousel.
  final int? itemCount;

  /// The carousel controller.
  final CarouselController? controller;

  /// The carousel alignment.
  final CarouselAlignment alignment;

  /// The carousel direction.
  final Axis direction;

  /// Whether the carousel should wrap.
  final bool wrap;

  /// Whether the carousel should pause on hover.
  final bool pauseOnHover;

  /// Whether the carousel should wait the item duration on start.
  final bool waitOnStart;

  /// The autoplay speed of the carousel.
  final Duration? autoplaySpeed;

  /// Whether the carousel should autoplay in reverse.
  final bool autoplayReverse;

  /// Whether the carousel is draggable.
  final bool draggable;

  /// Whether the carousel is reverse in layout direction.
  final bool reverse;

  /// The size constraint of the carousel.
  final CarouselSizeConstraint sizeConstraint;

  /// The speed of the carousel.
  final Duration speed;

  /// The curve of the carousel.
  final Curve curve;

  /// The index change callback.
  final ValueChanged<int>? onIndexChanged;

  /// Whether to disable overhead scrolling.
  final bool disableOverheadScrolling;

  /// Whether to disable dragging velocity.
  final bool disableDraggingVelocity;

  /// Creates a carousel.
  const Carousel({
    super.key,
    required this.itemBuilder,
    this.itemCount,
    this.controller,
    this.alignment = CarouselAlignment.center,
    this.direction = Axis.horizontal,
    this.wrap = true,
    this.pauseOnHover = true,
    this.autoplaySpeed,
    this.waitOnStart = false,
    this.draggable = true,
    this.reverse = false,
    this.autoplayReverse = false,
    this.sizeConstraint = const CarouselFractionalConstraint(1),
    this.speed = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.duration,
    this.durationBuilder,
    this.onIndexChanged,
    this.disableOverheadScrolling = true,
    this.disableDraggingVelocity = false,
    required this.transition,
  }) : assert(
          wrap || itemCount != null,
          'itemCount must be provided if wrap is false',
        );

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  late CarouselController _controller;
  Duration? _startTime;
  late Ticker _ticker;
  bool hovered = false;
  bool dragging = false;

  late double _lastDragValue;
  double _dragVelocity = 0;

  late int _currentIndex;

  CarouselTheme? _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = ComponentTheme.maybeOf<CarouselTheme>(context);
  }

  CarouselAlignment get _alignment => styleValue(
        widgetValue: widget.alignment,
        themeValue: _theme?.alignment,
        defaultValue: CarouselAlignment.center,
      );

  Axis get _direction => styleValue(
        widgetValue: widget.direction,
        themeValue: _theme?.direction,
        defaultValue: Axis.horizontal,
      );

  bool get _wrap => styleValue(
        widgetValue: widget.wrap,
        themeValue: _theme?.wrap,
        defaultValue: true,
      );

  bool get _pauseOnHover => styleValue(
        widgetValue: widget.pauseOnHover,
        themeValue: _theme?.pauseOnHover,
        defaultValue: true,
      );

  Duration? get _autoplaySpeed => styleValue(
        widgetValue: widget.autoplaySpeed,
        themeValue: _theme?.autoplaySpeed,
        defaultValue: null,
      );

  bool get _draggable => styleValue(
        widgetValue: widget.draggable,
        themeValue: _theme?.draggable,
        defaultValue: true,
      );

  Duration get _speed => styleValue(
        widgetValue: widget.speed,
        themeValue: _theme?.speed,
        defaultValue: const Duration(milliseconds: 200),
      );

  Curve get _curve => styleValue(
        widgetValue: widget.curve,
        themeValue: _theme?.curve,
        defaultValue: Curves.easeInOut,
      );

  Duration? get _currentSlideDuration {
    double currentIndex = _controller.getCurrentIndex(widget.itemCount);
    final int index = currentIndex.floor();
    Duration? duration = widget.durationBuilder?.call(index) ?? widget.duration;
    if (duration != null && _autoplaySpeed != null) {
      duration += _autoplaySpeed!;
    }
    return duration;
  }

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    _controller = widget.controller ?? CarouselController();
    _controller.addListener(_onControllerChange);
    _currentIndex = _controller.getCurrentIndex(widget.itemCount).round();
    _dispatchControllerChange();
  }

  void _check() {
    bool shouldStart = false;
    if (_controller.shouldAnimate) {
      shouldStart = true;
    }
    if (!shouldStart) {
      if (_currentSlideDuration != null) {
        if (!_pauseOnHover || !hovered) {
          shouldStart = true;
        }
      }
    }
    if (!shouldStart) {
      if (_dragVelocity.abs() > 0.0001) {
        shouldStart = true;
      }
    }
    if (shouldStart) {
      if (!_ticker.isActive) {
        _lastTime = null;
        _startTime = null;
        _ticker.start();
      }
    } else {
      if (_ticker.isActive) {
        _ticker.stop();
        _startTime = null;
        _lastTime = null;
      }
    }
  }

  Duration? _lastTime;
  void _tick(Duration elapsed) {
    Duration delta = _lastTime == null ? Duration.zero : elapsed - _lastTime!;
    _lastTime = elapsed;
    int deltaMillis = delta.inMilliseconds;
    _controller.tick(delta);
    bool shouldAutoPlay = false;
    if (_currentSlideDuration != null) {
      if (_startTime == null) {
        _startTime = elapsed;
        shouldAutoPlay = !widget.waitOnStart;
      } else {
        Duration elapsedDuration = elapsed - _startTime!;
        if (elapsedDuration >= _currentSlideDuration!) {
          shouldAutoPlay = true;
          _startTime = null;
        }
      }
    }
    if (shouldAutoPlay) {
      if (!_wrap &&
          widget.itemCount != null &&
          _controller.value >= widget.itemCount! - 1) {
        _controller.animateTo(0, _autoplaySpeed ?? _speed, _curve);
      } else if (!_wrap && widget.itemCount != null && _controller.value <= 0) {
        _controller.animateTo(
          widget.itemCount! - 1,
          _autoplaySpeed ?? _speed,
          _curve,
        );
      } else if (widget.autoplayReverse) {
        _controller.animatePrevious(_autoplaySpeed ?? _speed, _curve);
      } else {
        _controller.animateNext(_autoplaySpeed ?? _speed, _curve);
      }
    }
    if (_dragVelocity.abs() > 0.01 && !dragging) {
      var targetValue = progressedValue + _dragVelocity;
      _controller.jumpTo(targetValue);
      _dragVelocity *= pow(0.2, deltaMillis / 100);
      if (_dragVelocity.abs() < 0.01) {
        _dragVelocity = 0;
        if (widget.disableOverheadScrolling) {
          if (_lastDragValue < targetValue) {
            _controller.animateTo(
              _lastDragValue.floorToDouble() + 1,
              _speed,
              _curve,
            );
          } else {
            _controller.animateTo(
              _lastDragValue.floorToDouble() - 1,
              _speed,
              _curve,
            );
          }
        } else {
          _controller.animateSnap(_speed, _curve);
        }
      }
    }

    _check();
  }

  @override
  void didUpdateWidget(covariant Carousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onControllerChange);
      _controller = widget.controller ?? CarouselController();
      _controller.addListener(_onControllerChange);
      _dispatchControllerChange();
    }
  }

  void _onControllerChange() {
    setState(() {});
    if (!_wrap && widget.itemCount != null) {
      if (_controller.value < 0) {
        _controller._controller.value = 0;
      } else if (_controller.value >= widget.itemCount!) {
        _controller._controller.value = widget.itemCount!.toDouble() - 1;
      }
    }
    _dispatchControllerChange();
  }

  void _dispatchControllerChange() {
    _check();
    int index = _controller.getCurrentIndex(widget.itemCount).round();
    if (index != _currentIndex) {
      _currentIndex = index;
      widget.onIndexChanged?.call(index);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChange);
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        hovered = true;
        _check();
      },
      onExit: (event) {
        hovered = false;
        _check();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          var carouselWidget = buildCarousel(context, constraints);
          if (_draggable) {
            if (_direction == Axis.horizontal) {
              carouselWidget = buildHorizontalDragger(
                context,
                carouselWidget,
                constraints,
              );
            } else {
              carouselWidget = buildVerticalDragger(
                context,
                carouselWidget,
                constraints,
              );
            }
          }
          return carouselWidget;
        },
      ),
    );
  }

  Widget buildHorizontalDragger(
    BuildContext context,
    Widget carouselWidget,
    BoxConstraints constraints,
  ) {
    double size;
    if (widget.sizeConstraint is CarouselFixedConstraint) {
      size = (widget.sizeConstraint as CarouselFixedConstraint).size;
    } else if (widget.sizeConstraint is CarouselFractionalConstraint) {
      size = constraints.maxHeight *
          (widget.sizeConstraint as CarouselFractionalConstraint).fraction;
    } else {
      size = constraints.maxHeight;
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: carouselWidget,
      onHorizontalDragStart: (details) {
        dragging = true;
        _lastDragValue = progressedValue;
        _dragVelocity = 0;
      },
      onHorizontalDragUpdate: (details) {
        if (_draggable) {
          setState(() {
            var increment = -details.primaryDelta! / size;
            _controller.jumpTo(progressedValue + increment);
          });
        }
      },
      onHorizontalDragEnd: (details) {
        dragging = false;
        if (widget.disableDraggingVelocity) {
          _dragVelocity = 0;
        } else {
          _dragVelocity = -details.primaryVelocity! / size / 100.0;
        }
        _controller.animateSnap(_speed, _curve);
        _check();
      },
    );
  }

  Widget buildVerticalDragger(
    BuildContext context,
    Widget carouselWidget,
    BoxConstraints constraints,
  ) {
    double size;
    if (widget.sizeConstraint is CarouselFixedConstraint) {
      size = (widget.sizeConstraint as CarouselFixedConstraint).size;
    } else if (widget.sizeConstraint is CarouselFractionalConstraint) {
      size = constraints.maxWidth *
          (widget.sizeConstraint as CarouselFractionalConstraint).fraction;
    } else {
      size = constraints.maxWidth;
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: carouselWidget,
      onVerticalDragStart: (details) {
        dragging = true;
        _lastDragValue = progressedValue;
        _dragVelocity = 0;
      },
      onVerticalDragUpdate: (details) {
        if (_draggable) {
          setState(() {
            var increment = -details.primaryDelta! / size;
            _controller.jumpTo(progressedValue + increment);
          });
        }
      },
      onVerticalDragEnd: (details) {
        dragging = false;
        if (widget.disableDraggingVelocity) {
          _dragVelocity = 0;
        } else {
          _dragVelocity = -details.primaryVelocity! / size / 100.0;
        }
        _controller.animateSnap(_speed, _curve);
        _check();
      },
    );
  }

  double get progressedValue {
    if (!_wrap && widget.itemCount != null) {
      return _controller.value.clamp(0.0, widget.itemCount!.toDouble() - 1);
    } else {
      return _controller.value;
    }
  }

  Widget buildCarousel(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: widget.transition.layout(
        context,
        progress: progressedValue,
        constraints: constraints,
        alignment: _alignment,
        direction: _direction,
        sizeConstraint: widget.sizeConstraint,
        progressedIndex: progressedValue,
        wrap: _wrap,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
        reverse: widget.reverse,
      ),
    );
  }
}
