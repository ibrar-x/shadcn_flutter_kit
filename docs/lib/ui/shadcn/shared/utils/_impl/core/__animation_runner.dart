part of '../../animation_queue.dart';


class _AnimationRunner {
  final double from;
  final double to;
  final Duration duration;
  final Curve curve;

  double _progress = 0.0;

  _AnimationRunner(this.from, this.to, this.duration, this.curve);
}

/// Queue-based animation controller used by carousel transitions.
