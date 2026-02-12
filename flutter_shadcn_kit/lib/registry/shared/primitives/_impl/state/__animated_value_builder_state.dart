part of '../../animated_value_builder.dart';


/// _AnimatedValueBuilderState defines a reusable type for this registry module.
class _AnimatedValueBuilderState<T> extends State<AnimatedValueBuilder<T>>
    with SingleTickerProviderStateMixin {
/// Stores `_controller` state/configuration for this implementation.
  late AnimationController _controller;
/// Stores `_animation` state/configuration for this implementation.
  late Animation<double> _animation;
/// Stores `_from` state/configuration for this implementation.
  T? _from;
/// Stores `_to` state/configuration for this implementation.
  T? _to;

  @override
/// Executes `initState` behavior for this component/composite.
  void initState() {
    super.initState();
    _from = widget.initialValue ?? widget.value;
    _to = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    if (widget.duration == Duration.zero) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
/// Executes `didUpdateWidget` behavior for this component/composite.
  void didUpdateWidget(covariant AnimatedValueBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    }
    if (widget.value != _to || widget.initialValue != oldWidget.initialValue) {
      _from = _currentValue;
      _to = widget.value;
      if (widget.duration == Duration.zero) {
        _controller.value = 1;
        widget.onEnd?.call(_to);
      } else {
        _controller
          ..reset()
          ..forward().whenComplete(() {
            widget.onEnd?.call(_to);
          });
      }
    }
  }

  @override
/// Executes `dispose` behavior for this component/composite.
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

/// Executes `_lerpValue` behavior for this component/composite.
  T _lerpValue(T? a, T? b, double t) {
    if (widget.lerp != null) {
      final value = widget.lerp!(a, b, t);
      if (value != null) {
        return value;
      }
/// Stores `fallback` state/configuration for this implementation.
      final fallback = b ?? a ?? widget.value ?? widget.initialValue;
      if (fallback != null) {
        return fallback;
      }
      // If we have at least one value, prefer the 'to' value
      if (a != null || b != null) {
        return (t < 0.5 ? a : b) as T;
      }
      throw FlutterError(
        'AnimatedValueBuilder received a null lerp result but both values are null.',
      );
    }
/// Stores `start` state/configuration for this implementation.
    final start = a ?? b;
/// Stores `end` state/configuration for this implementation.
    final end = b ?? a ?? start;
    if (start == null || end == null) {
/// Stores `fallback` state/configuration for this implementation.
      final fallback = b ?? a ?? widget.value ?? widget.initialValue;
      if (fallback != null) {
        return fallback;
      }
      // Both values are null and no fallback - this is an error condition
      throw FlutterError.fromParts(<DiagnosticsNode>[
/// Creates a `ErrorSummary` instance.
        ErrorSummary('AnimatedValueBuilder requires a non-null value'),
/// Creates a `ErrorDescription` instance.
        ErrorDescription(
          'Provide a non-null value or initialValue when lerping between nulls.',
        ),
      ]);
    }
    if (start is num && end is num) {
      return (start + (end - start) * t) as T;
    }
    if (start is Color && end is Color) {
      return Color.lerp(start, end, t) as T;
    }
    if (start is Offset && end is Offset) {
      return Offset.lerp(start, end, t) as T;
    }
    if (start is Size && end is Size) {
      return Size.lerp(start, end, t) as T;
    }
    if (start is Rect && end is Rect) {
      return Rect.lerp(start, end, t) as T;
    }
    if (start is EdgeInsets && end is EdgeInsets) {
      return EdgeInsets.lerp(start, end, t) as T;
    }
    if (start is BorderRadius && end is BorderRadius) {
      return BorderRadius.lerp(start, end, t) as T;
    }
    if (start is Matrix4 && end is Matrix4) {
      return Matrix4Tween(begin: start, end: end).lerp(t) as T;
    }
    return t < 1.0 ? start : end;
  }

  T get _currentValue {
    if (_controller.isCompleted || widget.duration == Duration.zero) {
      return _to as T;
    }
    return _lerpValue(_from, _to, _animation.value);
  }

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return widget.builder(context, _currentValue, child);
      },
    );
  }
}
