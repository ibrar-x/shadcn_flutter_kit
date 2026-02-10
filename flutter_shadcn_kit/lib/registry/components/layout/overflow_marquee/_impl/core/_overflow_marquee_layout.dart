part of '../../overflow_marquee.dart';

class _OverflowMarqueeLayout extends SingleChildRenderObjectWidget {
  final Axis direction;
  final double fadePortion;
  final Duration duration;
  final Duration delayDuration;
  final Ticker ticker;
  final Duration elapsed;
  final double step;
  final TextDirection textDirection;
  final Curve curve;

  const _OverflowMarqueeLayout({
    required this.direction,
    this.fadePortion = 25,
    required this.duration,
    required this.delayDuration,
    required this.ticker,
    required this.elapsed,
    required this.step,
    required this.textDirection,
    required this.curve,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderOverflowMarqueeLayout(
      direction: direction,
      fadePortion: fadePortion,
      duration: duration,
      delayDuration: delayDuration,
      ticker: ticker,
      step: step,
      elapsed: elapsed,
      textDirection: textDirection,
      curve: curve,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderOverflowMarqueeLayout renderObject,
  ) {
    bool hasChanged = false;
    if (renderObject.direction != direction) {
      renderObject.direction = direction;
      hasChanged = true;
    }
    if (renderObject.fadePortion != fadePortion) {
      renderObject.fadePortion = fadePortion;
      hasChanged = true;
    }
    if (renderObject.duration != duration) {
      renderObject.duration = duration;
      hasChanged = true;
    }
    if (renderObject.delayDuration != delayDuration) {
      renderObject.delayDuration = delayDuration;
      hasChanged = true;
    }
    // most likely this will never change
    if (renderObject.ticker != ticker) {
      renderObject.ticker = ticker;
      hasChanged = true;
    }
    if (renderObject.elapsed != elapsed) {
      renderObject.elapsed = elapsed;
      hasChanged = true;
    }
    if (renderObject.step != step) {
      renderObject.step = step;
      hasChanged = true;
    }
    if (renderObject.textDirection != textDirection) {
      renderObject.textDirection = textDirection;
      hasChanged = true;
    }
    if (renderObject.curve != curve) {
      renderObject.curve = curve;
      hasChanged = true;
    }
    if (hasChanged) {
      renderObject.markNeedsLayout();
    }
  }
}
