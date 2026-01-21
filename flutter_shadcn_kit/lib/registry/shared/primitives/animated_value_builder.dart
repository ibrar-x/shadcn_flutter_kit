import 'package:flutter/widgets.dart';

typedef AnimatedValueWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T value,
  Widget? child,
);

typedef AnimatedValueLerp<T> = T? Function(T? a, T? b, double t);

class AnimatedValueBuilder<T> extends StatefulWidget {
  final T? value;
  final T? initialValue;
  final Duration duration;
  final Curve curve;
  final AnimatedValueLerp<T>? lerp;
  final AnimatedValueWidgetBuilder<T> builder;
  final Widget? child;
  final ValueChanged<T?>? onEnd;

  const AnimatedValueBuilder({
    super.key,
    required this.value,
    required this.builder,
    this.initialValue,
    this.duration = Duration.zero,
    this.curve = Curves.linear,
    this.lerp,
    this.child,
    this.onEnd,
  });

  @override
  State<AnimatedValueBuilder<T>> createState() =>
      _AnimatedValueBuilderState<T>();
}

class _AnimatedValueBuilderState<T> extends State<AnimatedValueBuilder<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  T? _from;
  T? _to;

  @override
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  T _lerpValue(T? a, T? b, double t) {
    if (widget.lerp != null) {
      final value = widget.lerp!(a, b, t);
      if (value != null) {
        return value;
      }
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
    final start = a ?? b;
    final end = b ?? a ?? start;
    if (start == null || end == null) {
      final fallback = b ?? a ?? widget.value ?? widget.initialValue;
      if (fallback != null) {
        return fallback;
      }
      // Both values are null and no fallback - this is an error condition
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('AnimatedValueBuilder requires a non-null value'),
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
