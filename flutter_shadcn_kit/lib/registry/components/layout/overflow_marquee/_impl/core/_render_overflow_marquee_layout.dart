part of '../../overflow_marquee.dart';

class _RenderOverflowMarqueeLayout extends RenderShiftedBox
    with ContainerRenderObjectMixin<RenderBox, _OverflowMarqueeParentData> {
  Axis direction;
  double fadePortion;
  Duration duration;
  Duration delayDuration;
  Ticker ticker;
  Duration elapsed;
  double step;
  TextDirection textDirection;
  Curve curve;

  _RenderOverflowMarqueeLayout({
    required this.direction,
    required this.fadePortion,
    required this.duration,
    required this.delayDuration,
    required this.ticker,
    required this.elapsed,
    required this.step,
    required this.textDirection,
    required this.curve,
  }) : super(null);

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _OverflowMarqueeParentData) {
      child.parentData = _OverflowMarqueeParentData();
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (direction == Axis.horizontal) {
      return super.computeMaxIntrinsicHeight(double.infinity);
    }
    return super.computeMaxIntrinsicHeight(width);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (direction == Axis.vertical) {
      return super.computeMaxIntrinsicWidth(double.infinity);
    }
    return super.computeMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (direction == Axis.horizontal) {
      return super.computeMinIntrinsicHeight(double.infinity);
    }
    return super.computeMinIntrinsicHeight(width);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (direction == Axis.vertical) {
      return super.computeMinIntrinsicWidth(double.infinity);
    }
    return super.computeMinIntrinsicWidth(height);
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    if (direction == Axis.horizontal) {
      constraints = constraints.copyWith(maxWidth: double.infinity);
    } else {
      constraints = constraints.copyWith(maxHeight: double.infinity);
    }
    final child = this.child;
    if (child != null) {
      return child.getDryLayout(constraints);
    }
    return constraints.biggest;
  }

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  double get offsetProgress {
    double durationInMicros =
        duration.inMicroseconds * ((sizeDiff ?? 0) / step);
    int delayDurationInMicros = delayDuration.inMicroseconds;
    double elapsedInMicros = elapsed.inMicroseconds.toDouble();
    // includes the reverse
    double overalCycleDuration =
        delayDurationInMicros +
        durationInMicros +
        delayDurationInMicros +
        durationInMicros;
    elapsedInMicros = elapsedInMicros % overalCycleDuration;
    bool reverse = elapsedInMicros > delayDurationInMicros + durationInMicros;
    double cycleElapsedInMicros =
        elapsedInMicros % (delayDurationInMicros + durationInMicros);
    if (cycleElapsedInMicros < delayDurationInMicros) {
      return reverse ? 1 : 0;
    } else if (cycleElapsedInMicros <
        delayDurationInMicros + durationInMicros) {
      double progress =
          (cycleElapsedInMicros - delayDurationInMicros) / durationInMicros;
      progress = curve.transform(progress);
      return reverse ? 1 - progress : progress;
    } else {
      return reverse ? 0 : 1;
    }
  }

  double? get sizeDiff {
    final parentData = child?.parentData as _OverflowMarqueeParentData?;
    return parentData?.sizeDiff;
  }

  double get fadeStartProgress {
    final child = this.child;
    if (child != null) {
      double size = sizeDiff ?? 0;
      double progressedSize = size * offsetProgress;
      return (progressedSize / fadePortion).clamp(0, 1);
    }
    return 0;
  }

  double get fadeEndProgress {
    final child = this.child;
    if (child != null) {
      double size = sizeDiff ?? 0;
      double progressedSize = size * (1 - offsetProgress);
      return (progressedSize / fadePortion).clamp(0, 1);
    }
    return 0;
  }

  Shader _createAlphaShader(
    bool fadeStart,
    bool fadeEnd,
    Rect bounds,
    double fadePortion,
  ) {
    double portionSize;
    if (direction == Axis.horizontal) {
      portionSize = fadePortion / bounds.width;
    } else {
      portionSize = fadePortion / bounds.height;
    }
    List<Color> colors = [];
    List<double> stops = [];
    if (fadeStart) {
      double start = fadeStartProgress;
      Color startColor = Colors.white.withValues(alpha: 1 - start);
      colors.addAll([startColor, Colors.white]);
      stops.addAll([0.0, portionSize]);
    } else {
      colors.addAll([Colors.white]);
      stops.addAll([0.0]);
    }
    if (fadeEnd) {
      double end = fadeEndProgress;
      Color endColor = Colors.white.withValues(alpha: 1 - end);
      colors.addAll([Colors.white, endColor]);
      stops.addAll([1.0 - portionSize, 1.0]);
    } else {
      colors.addAll([Colors.white]);
      stops.addAll([1.0]);
    }
    AlignmentGeometry begin;
    AlignmentGeometry end;
    if (direction == Axis.horizontal) {
      begin = AlignmentDirectional.centerStart.resolve(textDirection);
      end = AlignmentDirectional.centerEnd.resolve(textDirection);
    } else {
      begin = Alignment.topCenter;
      end = Alignment.bottomCenter;
    }
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
      stops: stops,
    ).createShader(bounds);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var child = this.child;
    if (child != null) {
      layer ??= ShaderMaskLayer();
      final parentData = child.parentData as _OverflowMarqueeParentData;
      final sizeDiff = parentData.sizeDiff ?? 0;
      var progress = offsetProgress;
      Shader shader = _createAlphaShader(
        progress > 0 && sizeDiff != 0,
        progress < 1 && sizeDiff != 0,
        (Offset.zero & size),
        25,
      );
      assert(needsCompositing);
      layer!
        ..shader = shader
        ..maskRect = (offset & size).inflate(1)
        ..blendMode = BlendMode.modulate;
      context.pushLayer(layer!, _paintChild, offset);
      assert(() {
        layer!.debugCreator = debugCreator;
        return true;
      }());
    } else {
      layer = null;
    }
  }

  void _paintChild(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) {
      final parentData = child.parentData as _OverflowMarqueeParentData;
      context.paintChild(child, offset + parentData.offset);
    }
  }

  @override
  void performLayout() {
    var child = this.child;
    if (child != null) {
      var constraints = this.constraints;
      if (direction == Axis.horizontal) {
        constraints = constraints.copyWith(maxWidth: double.infinity);
      } else {
        constraints = constraints.copyWith(maxHeight: double.infinity);
      }
      child.layout(constraints, parentUsesSize: true);
      size = this.constraints.constrain(child.size);
      final sizeDiff = child.size.width - size.width;
      if (sizeDiff > 0 && size.width > 0 && size.height > 0) {
        if (!ticker.isActive) {
          ticker.start();
        }
      } else {
        if (ticker.isActive) {
          ticker.stop();
        }
      }
      var progress = offsetProgress;
      final offset = direction == Axis.horizontal
          ? Offset(-sizeDiff * progress, 0)
          : Offset(0, -sizeDiff * progress);
      final parentData = child.parentData as _OverflowMarqueeParentData;
      parentData.sizeDiff = sizeDiff;
      parentData.offset = offset;
    } else {
      size = constraints.biggest;
      if (ticker.isActive) {
        ticker.stop();
      }
    }
  }
}
